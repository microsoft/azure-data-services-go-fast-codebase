using System;

namespace WebApplication.Models
{
    public partial class TaskInstanceExecution
    {
        public Guid ExecutionUid { get; set; }
        public long TaskInstanceId { get; set; }
        public string EngineId { get; set; }
        public string PipelineName { get; set; }
        public Guid? AdfRunUid { get; set; }
        public DateTimeOffset? StartDateTime { get; set; }
        public DateTimeOffset? EndDateTime { get; set; }
        public string Status { get; set; }
        public string Comment { get; set; }
    }
}
