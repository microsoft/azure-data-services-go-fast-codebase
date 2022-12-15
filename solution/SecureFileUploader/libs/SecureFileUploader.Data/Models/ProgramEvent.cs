namespace SecureFileUploader.Data.Models;

public class ProgramEvent
{
    public Guid Id { get; set; }
    public Program Program { get; set; }
    public ProgramEventType EventType { get; set; }
    public DateTime PerformedOn { get; set; }
    public string PerformedBy { get; set; }
    public string Description { get; set; }
}
