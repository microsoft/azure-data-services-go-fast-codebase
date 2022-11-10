using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Common.Dtos;

public class Invitee
{
    [Required] public Guid Id { get; set; }
    [Required] public string CrmId { get; set; } = string.Empty;
    [Required] public string PHN { get; set; } = string.Empty;
    [Required] public string PracticeId { get; set; } = string.Empty;
    [Required] public string PracticeName { get; set; } = string.Empty;
    [Required] public string FolderName { get; set; } = string.Empty;
    [Required] public string EmailAddress { get; set; } = string.Empty;
    [Required] public string ContainerName { get; set; } = string.Empty;
    [Required] public string ReportingQuarter { get; set; } = string.Empty;
    [Required] public InviteeStatus Status { get; set; }
    public List<AccessToken> AccessTokens { get; set; } = new();
    public List<Event> Events { get; set; } = new();
    public List<SendGridEmail> SendGridEmails { get; set; } = new();
}
