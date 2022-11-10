using SettingsDataModel = SecureFileUploader.Data.Models.Settings;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;

namespace SecureFileUploader.Common.Interfaces;

public interface ICreateSettingsService
{
    Task<SettingsDataModel> InsertSettingsDataAsync(SettingsDto settings);
}
