using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Portal.Web.Dtos;

public class ProgramSummary
{
    [Required] public Guid Id { get; set; }
    [Required] public string Name { get; set; } = string.Empty;
    [Required] public DateTime CommencementDate { get; set; }
    [Required] public DateTime SubmissionDeadline { get; set; }
    [Required] public int NumberOfInvitees { get; set; }
    [Required] public int NumberOfInviteesThatHaveUploaded { get; set; }
    [Required] public ProgramStatus Status { get; set; }
}
