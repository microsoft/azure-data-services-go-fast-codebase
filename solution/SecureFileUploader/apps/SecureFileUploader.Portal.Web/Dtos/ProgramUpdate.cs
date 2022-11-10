using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Portal.Web.Dtos;

public class ProgramUpdate
{
    [Required]
    public string Name { get; set; }
    [Required]
    public DateTime CommencementDate { get; set; }
    [Required]
    public DateTime SubmissionDeadline { get; set; }
    [Required]
    public string TimeZone { get; set; }
}
