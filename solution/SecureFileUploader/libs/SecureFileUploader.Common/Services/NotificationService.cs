using System.Text;
using System.Web;
using EnsureThat;
using HandlebarsDotNet;
using Humanizer;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using NodaTime;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Models;
using SecureFileUploader.Common.Settings;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Models;
using SendGrid;
using SendGrid.Helpers.Mail;
using ExceptionMessages = SecureFileUploader.Common.Resources.ExceptionMessages;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeEventDataModel = SecureFileUploader.Data.Models.InviteeEvent;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;

namespace SecureFileUploader.Common.Services;

public class NotificationService : INotificationService
{
    private readonly IAccessTokenService _accessTokenService;
    private readonly IClock _dateTimeProvider;
    private readonly HandlebarsTemplate<FileUploadUrlTemplateModel, string> _fileUploadUrlGenerator;
    private readonly IInviteeEventTypeService _inviteeEventTypeService;
    private readonly IConfiguration _configuration;
    private readonly ICryptographyProvider _cryptographyProvider;
    private readonly ISendGridEmailService _sendGridEmailService;
    private readonly ISettingsService _settingsService;
    private readonly ILogger<NotificationService> _logger;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;
    private readonly ISendGridClient _sendGridClient;
    private readonly SendGridSettings _sendGridSettings;

    public NotificationService(
        ILogger<NotificationService> logger,
        IClock dateTimeProvider,
        SecureFileUploaderContext secureFileUploaderContext,
        ISendGridClient sendGridClient,
        IOptionsSnapshot<SendGridSettings> sendGridSettingsAccessor,
        IOptionsSnapshot<InviteEmailTemplateSettings> inviteEmailTemplateSettingsAccessor,
        IAccessTokenService accessTokenService,
        IInviteeEventTypeService inviteeEventTypeService,
        IConfiguration configuration,
        ISettingsService settingsService,
        ICryptographyProvider cryptographyProvider,
        ISendGridEmailService sendGridEmailService)
    {
        _logger = logger;
        _dateTimeProvider = dateTimeProvider;
        _secureFileUploaderContext = secureFileUploaderContext;
        _sendGridClient = sendGridClient;
        _accessTokenService = accessTokenService;
        _inviteeEventTypeService = inviteeEventTypeService;
        _configuration = configuration;
        _cryptographyProvider = cryptographyProvider;
        _sendGridEmailService = sendGridEmailService;
        _settingsService = settingsService;
        _sendGridSettings = sendGridSettingsAccessor.Value;

        _fileUploadUrlGenerator = Handlebars.Compile(inviteEmailTemplateSettingsAccessor.Value.FileUploadUrlTemplate);
    }

    /// <summary>
    ///     Sends all pending invite emails.
    /// </summary>
    public async Task SendAllPendingInvitesAsync()
    {
        var allPendingAccessTokens = await _accessTokenService.GetAllPendingAsync();
        if (!allPendingAccessTokens.Any())
        {
            _logger.LogInformation("Did not find any pending invites to send.");
            return;
        }

        /*
         * https://docs.sendgrid.com/for-developers/sending-email/personalizations
         * You may not include more than 1000 personalizations per API request.
         * If you need to include more than 1000 personalizations, please divide these across multiple API requests.
         */
        var pagedPendingAccessTokens = allPendingAccessTokens
            .Select((x, i) => new { Item = x, Index = i })
            .GroupBy(x => x.Index / _sendGridSettings.PerRequestPersonalizationLimit, x => x.Item);

        foreach (var page in pagedPendingAccessTokens)
        {
            var pendingAccessTokens = page.ToList();
            var message = await CreateInviteSendGridMessageAsync(pendingAccessTokens);

            _logger.LogInformation("Sending invite email for access tokens '{ids}'.", JsonConvert.SerializeObject(pendingAccessTokens.Select(x => x.Id)));
            var response = await _sendGridClient.SendEmailAsync(message);
            if (!response.IsSuccessStatusCode)
            {
                _logger.LogError("An error occurred sending the invitee email for access tokens '{ids}'.", JsonConvert.SerializeObject(pendingAccessTokens.Select(x => x.Id)));
                var body = await response.Body.ReadAsStringAsync();
                _logger.LogError("SendGrid error response code: {code} with body: {body}", response.StatusCode, body);
                continue;
            }

            _logger.LogInformation("Invite email for access tokens '{ids}' sent.", JsonConvert.SerializeObject(pendingAccessTokens.Select(x => x.Id)));

            await _accessTokenService.MarkAsSentAsync(pendingAccessTokens);
            if (response.Headers.TryGetValues("X-Message-Id", out var values))
            {
                var sendGridId = values.First();
                await _sendGridEmailService.SaveNewSendGridEmailAsync(sendGridId,
                    pendingAccessTokens.Select(x => x.Invitee.Id),
                    _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc());
            }
        }
    }

    /// <summary>
    ///     Sends a file upload confirmation for an invitee.
    /// </summary>
    /// <param name="inviteeId">The invitee to send the file upload confirmation to.</param>
    /// <exception cref="KeyNotFoundException">The invitee could not be found.</exception>
    public async Task SendFileUploadConfirmationAsync(Guid inviteeId)
    {
        var invitee = await _secureFileUploaderContext.FindAsync<InviteeDataModel>(inviteeId);
        if (invitee == null) throw new KeyNotFoundException(ExceptionMessages.InviteeNotFound);
        await _secureFileUploaderContext.Entry(invitee).Reference(x => x.Program).LoadAsync();

        var message = await CreateConfirmationSendGridMessageAsync(invitee);

        _logger.LogInformation("Sending confirmation email for invitee '{id}'.", invitee.Id);
        var response = await _sendGridClient.SendEmailAsync(message);
        if (!response.IsSuccessStatusCode)
        {
            _logger.LogError("An error occurred sending the confirmation email for invitee '{id}'.", invitee.Id);
            return;
        }

        _logger.LogInformation("Confirmation email for invitee '{id}' sent.", invitee.Id);

        var eventType = await _inviteeEventTypeService.GetOrAddAsync("Email");
        var inviteeEvent = new InviteeEventDataModel {
            InviteeId = invitee.Id,
            EventTypeId = eventType.Id,
            Description = "File upload confirmation email sent",
            PerformedBy = "System",
            PerformedOn = _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc()
        };
        await _secureFileUploaderContext.InviteeEvent.AddAsync(inviteeEvent);
    }

    /// <summary>
    /// Sends a predetermined address a list of bounces
    /// </summary>
    /// <param name="bounces">bounces to inform an admin user of</param>
    public async Task SendBouncedEmailsNotification(List<SendGridEmailDto> bounces)
    {
        var response = await _sendGridClient.SendEmailAsync(await CreateBouncesEmail(bounces));
        if (!response.IsSuccessStatusCode)
        {
            _logger.LogError("An error occurred Bounced Email Notification");
            var body = await response.Body.ReadAsStringAsync();
            _logger.LogError("SendGrid error response code: {code} with body: {body} for Bounced Error Notification", response.StatusCode, body);
        }
    }

    private async Task<SendGridMessage> CreateBouncesEmail(List<SendGridEmailDto> bounces)
    {
        var userDefinedSettings = await _settingsService.GetAllCurrentSystemSettingsAsync();

        var builder = new StringBuilder();
        builder.Append("The following email addresses have been detected as having bounced by SendGrid:<br/>");
        foreach (var bounce in bounces)
        {
            // UTC for brevity lest we store even more data about the admins theoretical Timezone
            builder.Append($"<br/>{bounce.Email} on: {bounce.BouncedOn} UTC<br/>");
            builder.Append($"Bounce reason: {bounce.BouncedReason}<br/>");
        }

        var message = new SendGridMessage {
            From = new EmailAddress(userDefinedSettings.NotificationFromEmailAddress),
            Subject = "Secure File Uploader SendGrid Bounce Report",
            Personalizations = new List<Personalization> {
                new() {
                    Tos = new List<EmailAddress> {
                        new() {
                            Email = userDefinedSettings.BounceNotificationEmailAddress,
                            // I suspect name is not important here
                        }
                    }
                }
            }
        };

        message.AddContent("text/html", builder.ToString());
        return message;
    }

    private async Task<SendGridMessage> CreateInviteSendGridMessageAsync(List<AccessToken> accessTokens)
    {
        Ensure.That(accessTokens).IsNotNull();
        var phnHostname = _configuration.GetValue<string>("Phn:PhnHostname");
        Ensure.That(phnHostname).IsNotNullOrWhiteSpace();
        var apiKey = _configuration.GetValue<string>("ApiKey");
        Ensure.That(apiKey).IsNotNullOrWhiteSpace();


        var userDefinedSettings = await _settingsService.GetAllCurrentSystemSettingsAsync();
        var utcNow = _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc();

        return new SendGridMessage {
            From = new EmailAddress(userDefinedSettings.NotificationFromEmailAddress,
                userDefinedSettings.NotificationFromDisplayName),
            TemplateId = userDefinedSettings.InviteNotificationSendGridTemplateId,
            Personalizations = accessTokens.Select(s => new Personalization {
                Tos = CreateEmailAddress(s.Invitee.Email, s.Invitee.Name),
                /*
                 * https://docs.sendgrid.com/for-developers/sending-email/substitution-tags
                 * Substitutions are limited to 10000 bytes per personalization block.
                 */
                TemplateData = new InviteEmailTemplateModel {
                    ProgramName = s.Invitee.Program.Name,
                    SubmissionDeadline = DateTime.SpecifyKind(s.Invitee.Program.SubmissionDeadline, DateTimeKind.Utc),
                    PracticeName = s.Invitee.Name,
                    /*
                     * https://docs.sendgrid.com/for-developers/sending-email/substitution-tags
                     * Do not nest substitution tags in substitutions as they will fail and your substitution will not take place.
                     */
                    FileUploadUrl = _fileUploadUrlGenerator(new FileUploadUrlTemplateModel {
                        QueryString = HttpUtility.UrlEncode(_cryptographyProvider.EncryptString(
                            $"phnHostname={phnHostname}&accessToken={s.Token}&apiKey={apiKey}&programName={s.Invitee.Program.Name}"))
                    }),
                    /*
                     * 2 days, 1 day; 23 hours etc
                     * Rounds up to the nearest hour
                     * 1 day, 23 hours, 30 minutes > 2 days
                     * 1 day, 23 hours, 1 minutes > 2 days
                     * 1 day, 22 hours, 59 minutes > 1 day, 23 hours
                     */
                    HumanizedAccessTokenActiveWindow =
                        TimeSpan.FromHours(Math.Ceiling((s.EndsOn - utcNow).TotalHours)).Humanize(2)
                }
            }).ToList()
        };
    }

    private async Task<SendGridMessage> CreateConfirmationSendGridMessageAsync(InviteeDataModel invitee)
    {
        Ensure.That(invitee).IsNotNull();
        // check settings via program then system to handle future overrides
        var userDefinedSettings = await _settingsService.GetAllCurrentSettingsForProgramAsync(invitee.Program.Id);

        return new SendGridMessage {
            From = new EmailAddress(userDefinedSettings.NotificationFromEmailAddress, userDefinedSettings.NotificationFromDisplayName),
            TemplateId = userDefinedSettings.ConfirmationNotificationSendGridTemplateId,
            Personalizations = new List<Personalization> {
                new() {
                    Tos = CreateEmailAddress(invitee.Email, invitee.Name),
                    /*
                     * https://docs.sendgrid.com/for-developers/sending-email/substitution-tags
                     * Substitutions are limited to 10000 bytes per personalization block.
                     */
                    TemplateData = new ConfirmationEmailTemplateModel {
                        ProgramName = invitee.Program.Name,
                        PracticeName = invitee.Name
                    }
                }
            }
        };
    }

    /// <summary>
    /// So for a comma separated string of email addresses, create a SendGrid.EmailAddress after splitting the string by comma.
    /// If an overriden email is specified - send emails to that address instead.
    /// </summary>
    /// <param name="inviteeEmailAddress">a string with comma separated email address</param>
    /// <param name="inviteeName">name to go on the email - usually a practise name</param>
    /// <returns>A list of email address</returns>
    private List<EmailAddress> CreateEmailAddress(string inviteeEmailAddress, string inviteeName)
    {
        var emailAddresses = new List<EmailAddress>();

        if (!string.IsNullOrWhiteSpace(_sendGridSettings.SubstituteToEmailAddressWith))
        {
            emailAddresses.Add(new EmailAddress(_sendGridSettings.SubstituteToEmailAddressWith));
            return emailAddresses;
        }

        emailAddresses.AddRange(inviteeEmailAddress.Split(',').Select(address => new EmailAddress(address, inviteeName)));

        return emailAddresses;
    }

}
