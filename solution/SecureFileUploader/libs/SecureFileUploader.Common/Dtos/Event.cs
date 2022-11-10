using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Common.Dtos;

public class Event
{
    public DateTime TriggeredAt { get; set; }
    [Required] public string Description { get; set; } = string.Empty;
    [Required] public string TriggeredBy { get; set; } = string.Empty;
}
