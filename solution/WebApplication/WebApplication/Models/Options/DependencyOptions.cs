namespace WebApplication.Models.Options
{
    public class ApplicationOptions
    {
        public bool UseMSI { get; set; }
        public string AdsGoFastTaskMetaDataDatabaseName { get; set; }
        public string AdsGoFastTaskMetaDataDatabaseServer { get; set; }
        public string AppInsightsWorkspaceId { get; set; }
        public string LogAnalyticsWorkspaceId { get; set; }
        public string ConnectionString { get; set; }
    }

    public class AuthOptions
    {
        public string Instance { get; set; }
        public string TenantId { get; set; }
        public string Domain { get; set; }
        public string ClientId { get; set; }
        public string ClientSecret { get; set; }
        public string CallbackPath { get; set; }
        public string SignedOutCallbackPath { get; set; }
    }
}