using CsvHelper.Configuration.Attributes;

namespace SecureFileUploader.Common.Dtos;

public class InviteCsvRow : BaseInvitee
{
    [Index(0)]
    public override string CrmId { get; set; }
    [Index(1)]
    public override string Phn { get; set; }
    [Index(2)]
    public override string PracticeId { get; set; }
    [Index(3)]
    public override string GeneralPracticeName { get; set; }
    [Index(4)]
    public override string FolderName { get; set; }
    [Index(5)]
    public override string GenericEmailAddress { get; set; }
    // Note: skipping Clinical Information System at index 6
    [Index(7)]
    public override string ReportingQuarter { get; set; }
}
