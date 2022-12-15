using System.Collections.ObjectModel;

namespace SecureFileUploader.Data.Models;

public class InviteeEventType
{
    public int Id { get; set; }
    public string Description { get; set; }
    public ObservableCollection<InviteeEvent> InviteeEvents { get; set; } = new();
}
