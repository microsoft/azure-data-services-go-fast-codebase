namespace SecureFileUploader.Common.Models;

public class InviteEmailTemplateModel
{
    public string ProgramName { get; set; } = string.Empty;
    public DateTime SubmissionDeadline { get; set; }
    public string PracticeName { get; set; } = string.Empty;
    public string FileUploadUrl { get; set; } = string.Empty;
    public string HumanizedAccessTokenActiveWindow { get; set; } = string.Empty;
}
