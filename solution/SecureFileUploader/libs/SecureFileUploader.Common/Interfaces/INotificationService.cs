using SecureFileUploader.Common.Dtos;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;

namespace SecureFileUploader.Common.Interfaces;

public interface INotificationService
{
    Task SendAllPendingInvitesAsync();
    Task SendFileUploadConfirmationAsync(Guid inviteeId);
    Task SendBouncedEmailsNotification(List<SendGridEmailDto> bounces);
}
