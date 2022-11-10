using Newtonsoft.Json;

namespace SecureFileUploader.Common.Dtos;

public class ProgramRequest : BaseProgram
{
    [JsonRequired] public override string Name { get; set; }

    [JsonRequired]
    public override DateTime CommencementDate { get; set; }

    [JsonRequired]
    public override DateTime SubmissionDeadline { get; set; }

    // do not accept TimeZones through the API, but this will be required by the underlying model
    [JsonIgnore] public override string TimeZone { get; set; }
}
