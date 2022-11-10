using Newtonsoft.Json;

namespace SecureFileUploader.Common.Dtos;

public class SendGridDeleteBounceRequest
{
    [JsonProperty("emails")]
    public string[] Emails { get; set; }
}
