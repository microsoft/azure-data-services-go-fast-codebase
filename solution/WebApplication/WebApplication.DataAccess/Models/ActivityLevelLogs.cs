using System;

namespace WebApplication.Models
{
    public partial class ActivityLevelLogs
    {
        public DateTime? Timestamp { get; set; }
        public string OperationId { get; set; }
        public string OperationName { get; set; }
        public int? SeverityLevel { get; set; }
        public Guid? ExecutionUid { get; set; }
        public int? TaskInstanceId { get; set; }
        public string ActivityType { get; set; }
        public string LogSource { get; set; }
        public DateTime? LogDateUtc { get; set; }
        public DateTime? LogDateTimeOffset { get; set; }
        public string Status { get; set; }
        public int? TaskMasterId { get; set; }
        public string Comment { get; set; }
        public string Message { get; set; }
    }
}
