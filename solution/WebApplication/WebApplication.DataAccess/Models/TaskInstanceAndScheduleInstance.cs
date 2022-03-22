using System;

namespace WebApplication.Models
{
    public partial class TaskInstanceAndScheduleInstance
    {
        public long TaskInstanceId { get; set; }
        public long TaskMasterId { get; set; }
        public long ScheduleInstanceId { get; set; }
        public Guid ExecutionUid { get; set; }
        public string Adfpipeline { get; set; }
        public string TaskInstanceJson { get; set; }
        public string LastExecutionStatus { get; set; }
        public string LastExecutionComment { get; set; }
        public int NumberOfRetries { get; set; }
        public bool ActiveYn { get; set; }
        public DateTimeOffset? CreatedOn { get; set; }
        public int? TaskRunnerId { get; set; }
        public DateTime? ScheduledDateUtc { get; set; }
        public DateTimeOffset? ScheduledDateTimeOffset { get; set; }
    }
}
