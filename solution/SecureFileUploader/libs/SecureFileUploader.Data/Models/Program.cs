using System.Collections.ObjectModel;

namespace SecureFileUploader.Data.Models;

public class Program : BaseEntity<Guid>
{
    public string Name { get; set; }
    public DateTime CommencementDate { get; set; }
    public DateTime SubmissionDeadline { get; set; }
    public string TimeZone { get; set; }
    public bool IsCommenced { get; set; }
    public ObservableCollection<Invitee> Invitees { get; set; } = new();
    public ObservableCollection<ProgramEvent> ProgramEvents { get; set; } = new();
}
