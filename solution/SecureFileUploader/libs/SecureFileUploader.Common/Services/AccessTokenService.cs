using AutoMapper;
using EnsureThat;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using NodaTime;
using SecureFileUploader.Data;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Resources;
using AccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;
using AccessTokenDto = SecureFileUploader.Common.Dtos.AccessToken;
using ExceptionMessages = SecureFileUploader.Common.Resources.ExceptionMessages;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeEventDataModel = SecureFileUploader.Data.Models.InviteeEvent;

namespace SecureFileUploader.Common.Services;

public class AccessTokenService : IAccessTokenService
{
    private readonly IClock _dateTimeProvider;
    private readonly IInviteeEventTypeService _inviteeEventTypeService;
    private readonly ILogger<AccessTokenService> _logger;
    private readonly IMapper _mapper;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;
    private readonly ISettingsService _settingsService;

    public AccessTokenService(
        ILogger<AccessTokenService> logger,
        IMapper mapper,
        IClock dateTimeProvider,
        SecureFileUploaderContext secureFileUploaderContext,
        IInviteeEventTypeService inviteeEventTypeService,
        ISettingsService settingsService)
    {
        _logger = logger;
        _mapper = mapper;
        _dateTimeProvider = dateTimeProvider;
        _secureFileUploaderContext = secureFileUploaderContext;
        _inviteeEventTypeService = inviteeEventTypeService;
        _settingsService = settingsService;
    }

    /// <summary>
    ///     Generates a new access token for an invitee.
    /// </summary>
    /// <param name="inviteeId">The invitee to generate a new access token for.</param>
    /// <returns>The new access token.</returns>
    /// <exception cref="KeyNotFoundException">The invitee could not be found.</exception>
    /// <exception cref="InvalidOperationException">An existing active access token was found.</exception>
    public async Task<AccessTokenDto> GenerateForInviteeAsync(Guid inviteeId)
    {
        var invitee = await _secureFileUploaderContext.FindAsync<InviteeDataModel>(inviteeId);
        if (invitee == null) throw new KeyNotFoundException(ExceptionMessages.InviteeNotFound);
        await _secureFileUploaderContext.Entry(invitee).Collection(x => x.AccessTokens).LoadAsync();
        if (invitee.AccessTokens.Any(x => x.IsActive)) throw new InvalidOperationException(ExceptionMessages.ActiveAccessTokenFound);

        var activeWindowDurationInDays = await _settingsService.GetAllCurrentSystemSettingsAsync();
        var accessToken = CreateAccessTokenDataModel(invitee.Id, activeWindowDurationInDays.InviteTimeToLiveDays);
        invitee.AccessTokens.Add(accessToken);
        await _secureFileUploaderContext.SaveChangesAsync();

        return _mapper.Map<AccessTokenDto>(accessToken);
    }

    /// <summary>
    ///     Generates the initial invitee access tokens for programs that have commenced.
    /// </summary>
    /// <remarks>
    ///     Self healing process; looks for invitees assigned to programs that have commenced that do not have an initial
    ///     access token.
    /// </remarks>
    public async Task GenerateForCommencedProgramsAsync()
    {
        var inviteeIds = await _secureFileUploaderContext.Invitee.Where(x => x.Program.IsCommenced && !x.AccessTokens.Any()).Select(x => x.Id).ToListAsync();
        if (!inviteeIds.Any())
        {
            _logger.LogInformation(LogMessages.NoInitialInviteeAccessTokensToGenerate);
            return;
        }

        _logger.LogInformation(LogMessages.FoundInitialInviteeAccessTokenToGenerate, inviteeIds.Count);

        var activeWindowDurationInDays = await _settingsService.GetAllCurrentSystemSettingsAsync();

        var accessTokens = inviteeIds.Select(inviteeId => CreateAccessTokenDataModel(inviteeId, activeWindowDurationInDays.InviteTimeToLiveDays));
        await _secureFileUploaderContext.AccessToken.AddRangeAsync(accessTokens);
        await _secureFileUploaderContext.SaveChangesAsync();
    }

    /// <summary>
    ///     Gets all pending access tokens.
    /// </summary>
    /// <returns>All pending access tokens.</returns>
    /// <remarks>Pending === active, within the active window, and has not been sent.</remarks>
    public async Task<List<AccessTokenDataModel>> GetAllPendingAsync()
    {
        var utcNow = _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc();
        return await _secureFileUploaderContext.AccessToken
            .Include(x => x.Invitee)
            .ThenInclude(x => x.Program)
            .Where(x => x.IsActive
                        && utcNow >= x.StartsOn
                        && utcNow <= x.EndsOn
                        && !x.IsSentToMailProvider)
            .ToListAsync();
    }

    /// <summary>
    ///     For a given token, it will be valid if it matches an existing one and active and before it's end date.
    /// </summary>
    /// <param name="token">a token for validation</param>
    /// <returns>A valid token, else null</returns>
    public async Task<AccessTokenDataModel?> ValidateToken(Guid token) =>
        // its still active, we need the invitee
        await _secureFileUploaderContext.AccessToken
            .Include(x => x.Invitee)
            .ThenInclude(x => x.Program)
            .Where(x => x.Token == token.ToString()
                        && x.IsActive == true
                        // We may care to check the entire list for invalid tokens or some such?
                        && _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc() < x.EndsOn
                        && _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc() < x.Invitee.Program.SubmissionDeadline)
            .FirstOrDefaultAsync();


    /// <summary>
    ///     Marks the provided access tokens as sent to the mail provider.
    /// </summary>
    /// <param name="accessTokens">The access tokens to mark as sent.</param>
    public async Task MarkAsSentAsync(List<AccessTokenDataModel> accessTokens)
    {
        Ensure.That(accessTokens).IsNotNull();

        if (!accessTokens.Any()) return;

        _logger.LogInformation("Marking access tokens '{ids}' as sent.", JsonConvert.SerializeObject(accessTokens.Select(x => x.Id)));

        var eventType = await _inviteeEventTypeService.GetOrAddAsync("Email");
        var utcNow = _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc();

        foreach (var accessToken in accessTokens)
        {
            accessToken.IsSentToMailProvider = true;
            var inviteeEvent = new InviteeEventDataModel {
                InviteeId = accessToken.InviteeId,
                EventTypeId = eventType.Id,
                Description = "Invite email sent",
                PerformedBy = "System",
                PerformedOn = utcNow
            };
            await _secureFileUploaderContext.InviteeEvent.AddAsync(inviteeEvent);
        }

        await _secureFileUploaderContext.SaveChangesAsync();
    }

    private AccessTokenDataModel CreateAccessTokenDataModel(Guid inviteeId, int activeWindowDurationInDays)
    {
        var utcNow = _dateTimeProvider.GetCurrentInstant().ToDateTimeUtc();
        return new AccessTokenDataModel {
            InviteeId = inviteeId,
            Token = Guid.NewGuid().ToString(),
            StartsOn = utcNow,
            EndsOn = utcNow.AddDays(activeWindowDurationInDays),
            IsActive = true,
            GeneratedOn = utcNow,
            CreatedOn = utcNow,
            CreatedBy = "System",
            LastModifiedOn = utcNow,
            LastModifiedBy = "System"
        };
    }
}
