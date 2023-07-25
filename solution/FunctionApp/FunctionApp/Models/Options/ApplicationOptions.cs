namespace FunctionApp.Models.Options
{
    public class ApplicationOptions
    {
        public bool UseMSI { get; set; }
        public System.Int16 FrameworkWideMaxConcurrency { get; set; }
        public ServiceConnections ServiceConnections { get; set; }
        public TimerTriggers TimerTriggers { get; set; }
        public LocalPaths LocalPaths { get; set; }
        public TestingOptions TestingOptions { get; set; }
        public string SendGridApiKey { get; set; }
        public AzureCommunicationsService AzureCommunicationsService { get; set; }
    }
}