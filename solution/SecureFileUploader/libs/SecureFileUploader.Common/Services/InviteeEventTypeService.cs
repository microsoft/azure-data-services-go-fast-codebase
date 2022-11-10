using EnsureThat;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using SecureFileUploader.Data;
using SecureFileUploader.Common.Interfaces;
using InviteeEventTypeDataModel = SecureFileUploader.Data.Models.InviteeEventType;

namespace SecureFileUploader.Common.Services;

public class InviteeEventTypeService : IInviteeEventTypeService
{
    private readonly ILogger<InviteeEventTypeService> _logger;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;

    public InviteeEventTypeService(ILogger<InviteeEventTypeService> logger, SecureFileUploaderContext secureFileUploaderContext)
    {
        _logger = logger;
        _secureFileUploaderContext = secureFileUploaderContext;
    }
    
    public async Task<InviteeEventTypeDataModel> GetOrAddAsync(string description)
    {
        Ensure.That(description).IsNotNullOrWhiteSpace();

        var eventType = await _secureFileUploaderContext.InviteeEventType.SingleOrDefaultAsync(x => x.Description.Equals(description));
        if (eventType != null) return eventType;

        _logger.LogInformation("Adding invitee event type '{eventType}'.", description);

        eventType = new InviteeEventTypeDataModel { Description = description };
        await _secureFileUploaderContext.InviteeEventType.AddAsync(eventType);
        await _secureFileUploaderContext.SaveChangesAsync();
        return eventType;
    }
}
