namespace SecureFileUploader.Common.Settings;

public class SendGridSettings
{
    public string ApiKey { get; set; } = string.Empty;
    public int PerRequestPersonalizationLimit { get; set; } = 1000;
    public string SubstituteToEmailAddressWith { get; set; } = string.Empty;
}
