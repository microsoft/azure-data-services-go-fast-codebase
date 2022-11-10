using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Common.Dtos;

public class Settings
{
    [Required] public int MinFileSize { get; set; }
    [Required] public int MaxFileSize { get; set; }
    [Required] public string FileUnit { get; set; }
    [Required] public string NotificationFromEmailAddress { get; set; }
    [Required] public string NotificationFromDisplayName { get; set; }
    [Required] public string InviteNotificationSendGridTemplateId { get; set; }
    [Required] public string ConfirmationNotificationSendGridTemplateId { get; set; }
    [Required] public int InviteTimeToLiveDays { get; set; }
    public string? PhnLogo { get; set; } = string.Empty;
    [Required] public bool AllowCsvFiles { get; set; }
    [Required] public bool AllowJsonFiles { get; set; }
    [Required] public bool AllowZippedFiles { get; set; }
    [Required] public string BounceNotificationEmailAddress { get; set; }
}
