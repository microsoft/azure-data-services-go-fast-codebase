namespace SecureFileUploader.Common.Interfaces;

using SettingsDto = SecureFileUploader.Common.Dtos.Settings;

public interface ISettingsService
{
    Task<SettingsDto> GetAllCurrentSettingsForProgramAsync(Guid programId);

    Task<SettingsDto> GetAllCurrentSystemSettingsAsync();

    Task<Guid> UpdateSystemSettingsAsync(SettingsDto settings);

    Task<string> GetCurrentSystemLogo();
}
