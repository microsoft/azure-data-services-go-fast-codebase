using System.Collections.ObjectModel;

namespace SecureFileUploader.Data.Models;

public class Invitee : BaseEntity<Guid>
{
    public Program Program { get; set; }
    public string CrmId { get; set; }
    public string PHN { get; set; }
    public string PracticeId { get; set; }
    public string Name { get; set; }
    public string ContainerName { get; set; }
    public string ReportingQuarter { get; set; }
    public string Email { get; set; }
    public bool IsFileUploaded { get; set; }
    public ObservableCollection<InviteeEvent> InviteeEvents { get; set;  } = new();
    public ObservableCollection<AccessToken> AccessTokens { get; set;  } = new();
    public ObservableCollection<SendGridEmail> SendGridEmails { get; set;  } = new();
}
