using AutoMapper;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using NodaTime;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Data;
using SendGrid;
using SendGridEmailModel = SecureFileUploader.Data.Models.SendGridEmail;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;
using InviteeEventDataModel = SecureFileUploader.Data.Models.InviteeEvent;

namespace SecureFileUploader.Common.Services;

public class SendGridEmailService : ISendGridEmailService
{
    private readonly SecureFileUploaderContext _secureFileUploaderContext;
    private readonly ILogger<SendGridEmailService> _logger;
    private readonly IMapper _mapper;
    private readonly ISendGridClient _sendGridClient;
    private readonly IInviteeEventTypeService _eventTypeService;
    private readonly IClock _clock;

    public SendGridEmailService(SecureFileUploaderContext secureFileUploaderContext,
        ILogger<SendGridEmailService> logger, IMapper mapper, ISendGridClient sendGridClient,
        IInviteeEventTypeService eventTypeService, IClock clock)
    {
        _secureFileUploaderContext = secureFileUploaderContext;
        _logger = logger;
        _mapper = mapper;
        _sendGridClient = sendGridClient;
        _eventTypeService = eventTypeService;
        _clock = clock;
    }

    /// <summary>
    /// Saves a new SendGridEmail row
    /// </summary>
    /// <param name="sendGridId">X-Message-id value from the response headers</param>
    /// <param name="invitees">The associated invitees</param>
    /// <param name="sentOn">DateTime the email was sent</param>
    public async Task SaveNewSendGridEmailAsync(string sendGridId, IEnumerable<Guid> invitees, DateTime sentOn)
    {
        // create 1 sendgrid email per email in the list
        // this could be avoided with a 1:1 relationship between invitee and an "email"
        var inviteesToCheck = _secureFileUploaderContext.Invitee.Where(x => invitees.Contains(x.Id));

        var sendGridEntries = new List<SendGridEmailModel>();
        foreach (var invitee in inviteesToCheck)
        {
            // Each of these emails were sent, untangle this when we separate
            // the comma separated emails from a single field
            var emails = invitee.Email.Split(',').ToList();
            sendGridEntries.AddRange(emails.Select(email => new SendGridEmailModel {
                Email = email, SendGridId = sendGridId, InviteeId = invitee.Id, SentOn = sentOn
            }));
        }

        if (sendGridEntries.Any()) {
            await _secureFileUploaderContext.SendGridEmail.AddRangeAsync(sendGridEntries);
            await _secureFileUploaderContext.SaveChangesAsync();
        }
    }

    /// <summary>
    /// For a list of Bounces from SendGrid - check against existing SendGridEmail rows. If a row is matched
    /// to an invitee email, update with the BouncedOn and BouncedReason provided.
    /// </summary>
    /// <param name="bounces">A List of bounced email address from SendGrid</param>
    public async Task<List<SendGridEmailDto>> SaveSendGridBounceEmailsAsync(List<SendGridBounceResponse> bounces)
    {
        var updatedRows = new List<SendGridEmailModel>();
        // ok so we will get 1 response per DISTINCT email it seems, so try and backward match things up
        foreach (var bounce in bounces)
        {
            // check to see if a row exists already keyed via email, and we want the Invitee object this time too
            var results = _secureFileUploaderContext.SendGridEmail.Where(x => x.Invitee.Email.Contains(bounce.Email))
                .Include(x => x.Invitee).ToList();
            foreach (var sendGridEmail in results)
            {
                // Only add the bounce for the appropriate email - don't add on all rows
                // Noting SendGrid has a habit of returning emails in lowercase
                if (sendGridEmail.Email.ToLower().Equals(bounce.Email))
                {
                    sendGridEmail.BouncedOn = DateTimeOffset.FromUnixTimeSeconds(bounce.Created).UtcDateTime;
                    sendGridEmail.BouncedReason = bounce.Reason;
                    updatedRows.Add(sendGridEmail);
                    // add bounce events
                    var eventType = await _eventTypeService.GetOrAddAsync("Bounced Email");
                    var inviteeEvent = new InviteeEventDataModel {
                        InviteeId = sendGridEmail.InviteeId,
                        EventTypeId = eventType.Id,
                        Description = $"Bounced Email Detected - {sendGridEmail.Email}",
                        PerformedOn = _clock.GetCurrentInstant().ToDateTimeUtc(),
                        PerformedBy = "System"
                    };
                    await _secureFileUploaderContext.InviteeEvent.AddAsync(inviteeEvent);
                }
            }
        }

        if (updatedRows.Any()) {
            await _secureFileUploaderContext.SaveChangesAsync();
        }
        return _mapper.Map<List<SendGridEmailDto>>(updatedRows);
    }

    /// <summary>
    /// Fetches bounces during a time period from the SendGrid API
    /// </summary>
    /// <param name="startTime">Start time in UTC</param>
    /// <param name="endTime">End time in UTC</param>
    /// <returns></returns>
    public async Task<List<SendGridBounceResponse>> FetchSendGridBouncesAsync(DateTimeOffset startTime,
        DateTimeOffset endTime)
    {
        var startUnix = startTime.ToUnixTimeSeconds();
        var endUnix = endTime.ToUnixTimeSeconds();

        // For some reason - the client here expects this query string as JSON
        var queryParams = $@"{{
                               'end_time': {endUnix},
                               'start_time': {startUnix}
                             }}";
        const string apiPath = "suppression/bounces";

        var response = await _sendGridClient.RequestAsync(BaseClient.Method.GET, null,
            queryParams,
            apiPath);

        var results = new List<SendGridBounceResponse>();
        if (!response.IsSuccessStatusCode)
        {
            var body = await response.Body.ReadAsStringAsync();
            _logger.LogError("SendGrid error response code: {code} with body: {body} for GET at {apiPath}",
                response.StatusCode, body, apiPath);
            return results;
        }

        var bounces =
            JsonConvert.DeserializeObject<List<SendGridBounceResponse>>(await response.Body.ReadAsStringAsync());

        if (bounces != null && bounces.Any())
        {
            results.AddRange(bounces);
        }

        return results;
    }

    /// <summary>
    /// Purge a list of email address from the SendGrid bounce list
    /// </summary>
    /// <param name="bounceAddresses">A list of addresses to purge</param>
    public async Task PurgeSendGridBouncesAsync(List<string> bounceAddresses)
    {
        if (!bounceAddresses.Any())
        {
            return;
        }

        var requestBody = JsonConvert.SerializeObject(new SendGridDeleteBounceRequest {
            Emails = bounceAddresses.ToArray()
        });

        const string apiPath = "suppression/bounces";

        var response = await _sendGridClient.RequestAsync(BaseClient.Method.DELETE, requestBody, null, apiPath);

        if (!response.IsSuccessStatusCode)
        {
            var body = await response.Body.ReadAsStringAsync();
            _logger.LogError("SendGrid error response code: {code} with body: {body} for DELETE at {apiPath}",
                response.StatusCode, body, apiPath);
        }
    }
}
