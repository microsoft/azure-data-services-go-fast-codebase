namespace SecureFileUploader.Data.Models;

public class InviteeEvent
{
    public Guid Id { get; set; }
    public Guid InviteeId { get; set; }
    public Invitee Invitee { get; set; }
    public int EventTypeId { get; set; }
    public InviteeEventType EventType { get; set; }
    public DateTime PerformedOn { get; set; }
    public string PerformedBy { get; set; }
    public string Description { get; set; }
}
