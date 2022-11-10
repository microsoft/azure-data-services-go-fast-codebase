using Newtonsoft.Json;

namespace SecureFileUploader.Common.Dtos;

public class CreateProgramRequest
{
    [JsonRequired]
    public ProgramRequest Program { get; set; }

    [JsonRequired]
    public List<InviteeRequest> Invitees { get; set; }
}
