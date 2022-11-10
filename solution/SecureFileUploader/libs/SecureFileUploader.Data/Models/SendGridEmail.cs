namespace SecureFileUploader.Data.Models;

public class SendGridEmail : BaseEntity<Guid>
{
    public Guid InviteeId { get; set; }
    public Invitee Invitee { get; set; }
    public string? SendGridId { get; set; }
    public DateTime SentOn { get; set; }
    public DateTime? BouncedOn { get; set; }
    public string? BouncedReason { get; set; }
    // Useful because of the Invitee email itself can be many actual addresses
    public string Email { get; set; }
    // "Delivered on" not useful yet
}
