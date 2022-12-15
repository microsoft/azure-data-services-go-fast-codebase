using System.ComponentModel.DataAnnotations;
using SecureFileUploader.Common.Dtos;

namespace SecureFileUploader.Portal.Web.Dtos;

public class InviteeSummary
{
    [Required] public Guid Id { get; set; }
    [Required] public string PracticeName { get; set; } = string.Empty;
    [Required] public string EmailAddress { get; set; } = string.Empty;
    [Required] public bool HasBeenInvited { get; set; }
    [Required] public bool HasUploaded { get; set; }
    [Required] public InviteeStatus Status { get; set; }
    [Required] public List<SendGridEmail> BounceResponses { get; set; }
}
