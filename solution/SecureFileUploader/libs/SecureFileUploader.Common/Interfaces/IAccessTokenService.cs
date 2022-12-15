using AccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;
using AccessTokenDto = SecureFileUploader.Common.Dtos.AccessToken;

namespace SecureFileUploader.Common.Interfaces;

public interface IAccessTokenService
{
    Task<AccessTokenDto> GenerateForInviteeAsync(Guid inviteeId);
    Task GenerateForCommencedProgramsAsync();
    Task<List<AccessTokenDataModel>> GetAllPendingAsync();
    Task MarkAsSentAsync(List<AccessTokenDataModel> accessTokens);
    Task<AccessTokenDataModel?> ValidateToken(Guid token);
}
