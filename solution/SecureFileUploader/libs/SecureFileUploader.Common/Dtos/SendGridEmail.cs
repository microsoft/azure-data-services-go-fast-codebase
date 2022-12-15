namespace SecureFileUploader.Common.Dtos;

public class SendGridEmail
{
    public string? SendGridId { get; set; }
    public DateTime SentOn { get; set; }
    public DateTime? BouncedOn { get; set; }
    public string? BouncedReason { get; set; }
    public string Email { get; set; }
}
