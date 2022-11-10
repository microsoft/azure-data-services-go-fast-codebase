using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Data;
using SettingsDataModel = SecureFileUploader.Data.Models.Settings;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;

namespace SecureFileUploader.Common.Services;

public class CreateSettingsService : ICreateSettingsService
{
    private readonly SecureFileUploaderContext _secureFileUploaderContext;

    public CreateSettingsService(SecureFileUploaderContext secureFileUploaderContext)
    {
        _secureFileUploaderContext = secureFileUploaderContext;
    }

    public async Task<SettingsDataModel> InsertSettingsDataAsync(SettingsDto settings)
    {
        var phnLogo = Convert.FromBase64String(settings.PhnLogo ?? string.Empty);

        var newSettings = new SettingsDataModel {
            MaxFileSize = settings.MaxFileSize,
            MinFileSize = settings.MinFileSize,
            FileUnit = settings.FileUnit,
            NotificationFromDisplayName = settings.NotificationFromDisplayName,
            NotificationFromEmailAddress = settings.NotificationFromEmailAddress,
            InviteTimeToLiveDays = settings.InviteTimeToLiveDays,
            InviteNotificationSendGridTemplateId = settings.InviteNotificationSendGridTemplateId,
            ConfirmationNotificationSendGridTemplateId = settings.ConfirmationNotificationSendGridTemplateId,
            PhnLogo = phnLogo,
            AllowCsvFiles = settings.AllowCsvFiles,
            AllowJsonFiles = settings.AllowJsonFiles,
            AllowZippedFiles = settings.AllowZippedFiles,
            BounceNotificationEmailAddress = settings.BounceNotificationEmailAddress
        };

        await _secureFileUploaderContext.Settings.AddAsync(newSettings);

        return newSettings;
    }
}
