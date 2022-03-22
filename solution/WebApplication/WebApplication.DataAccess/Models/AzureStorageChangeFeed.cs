using System;

namespace WebApplication.Models
{
    public partial class AzureStorageChangeFeed
    {
        public DateTimeOffset? EventTime { get; set; }
        public string EventType { get; set; }
        public string Subject { get; set; }
        public string Topic { get; set; }
        public string EventDataBlobOperationName { get; set; }
        public string EventDataBlobType { get; set; }
        public long Pkey1ebebb3aD7af431593c8A438fe7a36ff { get; set; }
    }
}
