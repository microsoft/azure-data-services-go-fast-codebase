using Newtonsoft.Json;

namespace SecureFileUploader.Common.Dtos;

public class InviteeRequest : BaseInvitee
{
    [JsonRequired]
    public override string CrmId { get; set; }

    [JsonRequired]
    public override string Phn { get; set; }

    [JsonRequired]
    public override string PracticeId { get; set; }

    [JsonRequired]
    public override string GeneralPracticeName { get; set; }

    [JsonRequired]
    public override string FolderName { get; set; }

    [JsonRequired]
    public override string GenericEmailAddress { get; set; }

    [JsonRequired]
    public override string ReportingQuarter { get; set; }
}
