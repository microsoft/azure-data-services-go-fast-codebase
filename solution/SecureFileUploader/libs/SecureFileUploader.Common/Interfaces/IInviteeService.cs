using SecureFileUploader.Common.Dtos;

namespace SecureFileUploader.Common.Interfaces;

public interface IInviteeService
{
    Task<Invitee?> GetByIdAsync(Guid id);
    Task MarkInviteeFileUpload(Guid id);
}
