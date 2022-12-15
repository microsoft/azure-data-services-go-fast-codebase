namespace SecureFileUploader.Data.Models;

public class Settings : BaseEntity<Guid>
{
    public int MinFileSize { get; set; }
    public int MaxFileSize { get; set; }
    public string FileUnit { get; set; }
    public string NotificationFromEmailAddress { get; set; }
    public string NotificationFromDisplayName { get; set; }
    public string InviteNotificationSendGridTemplateId { get; set; }
    public string ConfirmationNotificationSendGridTemplateId { get; set; }
    public int InviteTimeToLiveDays { get; set; }

    public byte[]? PhnLogo { get; set; }
    public string BounceNotificationEmailAddress { get; set; }
    public bool AllowCsvFiles { get; set; }
    public bool AllowJsonFiles { get; set; }
    public bool AllowZippedFiles { get; set; }
}

public class SettingsValues
{
    public int MinFileSize { get; set; }
    public int MaxFileSize { get; set; }
    public string FileUnit { get; set; }
    public string NotificationFromEmailAddress { get; set; }
    public string NotificationFromDisplayName { get; set; }
    public string InviteNotificationSendGridTemplateId { get; set; }
    public string ConfirmationNotificationSendGridTemplateId { get; set; }
    public int InviteTimeToLiveDays { get; set; }
    public byte[]? PhnLogo { get; set; }
    public bool AllowCsvFiles { get; set; } = true;
    public bool AllowJsonFiles { get; set; } = false;
    public bool AllowZippedFiles { get; set; } = false;
}
