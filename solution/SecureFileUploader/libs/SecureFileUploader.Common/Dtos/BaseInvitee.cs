namespace SecureFileUploader.Common.Dtos;

public abstract class BaseInvitee
{
    public abstract string CrmId { get; set; }
    public abstract string Phn { get; set; }
    public abstract string PracticeId { get; set; }
    public abstract string GeneralPracticeName { get; set; }
    public abstract string FolderName { get; set; }
    public abstract string GenericEmailAddress { get; set; }
    public abstract string ReportingQuarter { get; set; }
}
