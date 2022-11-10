namespace SecureFileUploader.Data.Models;

public class AccessToken : BaseEntity<Guid>
{
    public Guid InviteeId { get; set; }
    public Invitee Invitee { get; set; }
    public bool IsActive { get; set; }
    public string Token { get; set; }
    public DateTime GeneratedOn { get; set; }
    public DateTime StartsOn { get; set; }
    public DateTime EndsOn { get; set; }
    public bool IsSentToMailProvider { get; set; }
}
