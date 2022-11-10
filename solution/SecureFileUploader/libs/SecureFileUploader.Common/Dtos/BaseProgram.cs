namespace SecureFileUploader.Common.Dtos;

public abstract class BaseProgram
{
    public abstract string Name { get; set; }
    public abstract DateTime CommencementDate { get; set; }
    public abstract DateTime SubmissionDeadline { get; set; }
    public abstract string TimeZone { get; set; }
}
