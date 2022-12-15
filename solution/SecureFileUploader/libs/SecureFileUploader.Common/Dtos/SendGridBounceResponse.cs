namespace SecureFileUploader.Common.Dtos;

/// <summary>
/// Response payload from https://api.sendgrid.com/v3/suppression/bounces
/// </summary>
public class SendGridBounceResponse
{
    public long Created { get; set; }
    public string Email { get; set; }
    public string Reason { get; set; }
    public string Status { get; set; }
}
