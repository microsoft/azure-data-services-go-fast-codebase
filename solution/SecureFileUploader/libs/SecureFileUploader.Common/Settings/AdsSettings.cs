namespace SecureFileUploader.Common.Settings
{
    public class AdsSettings
    {
        public bool UseADS { get; set; } = false;
        public string SubscriptionId { get; set; } = string.Empty;
        public string TenantId { get; set; } = string.Empty;
        public string ResourceGroup { get; set; } = string.Empty;
        public string DataFactoryName { get; set; } = string.Empty;
        public string PipelineName { get; set; } = string.Empty;
    }
}
