using SecureFileUploader.Data.Models;

namespace SecureFileUploader.Common.Interfaces;

public interface IInviteeEventTypeService
{
    Task<InviteeEventType> GetOrAddAsync(string description);
}
