using System;

namespace WebApplication.Models
{
    public partial class AdfpipelineRun1
    {
        public int TaskInstanceId { get; set; }
        public Guid ExecutionUid { get; set; }
        public int EngineId { get; set; }
        public Guid PipelineRunUid { get; set; }
        public DateTimeOffset? Start { get; set; }
        public DateTimeOffset? End { get; set; }
        public string PipelineRunStatus { get; set; }
        public DateTimeOffset MaxPipelineTimeGenerated { get; set; }
        public long? Activities { get; set; }
        public float? TotalCost { get; set; }
        public float? CloudOrchestrationCost { get; set; }
        public float? SelfHostedOrchestrationCost { get; set; }
        public float? SelfHostedDataMovementCost { get; set; }
        public float? SelfHostedPipelineActivityCost { get; set; }
        public float? CloudPipelineActivityCost { get; set; }
        public long? RowsCopied { get; set; }
        public long? DataRead { get; set; }
        public long? DataWritten { get; set; }
        public string TaskExecutionStatus { get; set; }
        public long? FailedActivities { get; set; }
        public DateTimeOffset? MaxActivityTimeGenerated { get; set; }
    }
}
