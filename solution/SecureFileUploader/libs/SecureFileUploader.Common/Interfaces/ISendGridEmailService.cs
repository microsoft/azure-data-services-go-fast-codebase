using SecureFileUploader.Common.Dtos;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;
using SendGridEmailModel = SecureFileUploader.Data.Models.SendGridEmail;

namespace SecureFileUploader.Common.Interfaces;

public interface ISendGridEmailService
{
    Task SaveNewSendGridEmailAsync(string sendGridId, IEnumerable<Guid> invitees, DateTime sentOn);
    Task<List<SendGridEmailDto>> SaveSendGridBounceEmailsAsync(List<SendGridBounceResponse> bounces);
    Task<List<SendGridBounceResponse>> FetchSendGridBouncesAsync(DateTimeOffset startTime, DateTimeOffset endTime);
    Task PurgeSendGridBouncesAsync(List<string> bounceAddresses);
}
