using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Common.Dtos;

public class AccessToken
{
    public Guid Id { get; set; }
    public bool IsActive { get; set; }
    public DateTime GeneratedAt { get; set; }
    public DateTime ActiveWindowStartsAt { get; set; }
    public DateTime ActiveWindowEndsAt { get; set; }
    [Required] public string GeneratedBy { get; set; } = string.Empty;
    public string Token { get; set; }
}
