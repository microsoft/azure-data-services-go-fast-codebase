namespace SecureFileUploader.Data.Models;

public class ProgramSettingsSnapshot : BaseEntity<Guid>
{
    // Note: quick and dirty to add this here
    public Guid ProgramId { get; set; }
    public Program Program { get; set; }
    public SettingsValues Settings { get; set; }
    public DateTime SnapshotOn { get; set; }
}
