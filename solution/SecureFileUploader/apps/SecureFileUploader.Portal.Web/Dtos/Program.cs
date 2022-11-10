using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Portal.Web.Dtos;

public class Program
{
    [Required] public Guid Id { get; set; }
    [Required] public string Name { get; set; } = string.Empty;
    [Required] public DateTime CommencementDate { get; set; }
    [Required] public DateTime SubmissionDeadline { get; set; }
    [Required] public string TimeZone { get; set; }
    [Required] public List<InviteeSummary> Invitees { get; set; } = new();
    [Required] public ProgramStatus Status { get; set; }
}
