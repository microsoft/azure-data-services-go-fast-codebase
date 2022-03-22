using System;

namespace WebApplication.Models
{
    public partial class AdfpipelineRun
    {
        public long TaskInstanceId { get; set; }
        public Guid ExecutionUid { get; set; }
        public long EngineId { get; set; }
        public Guid PipelineRunUid { get; set; }
        public DateTimeOffset? Start { get; set; }
        public DateTimeOffset? End { get; set; }
        public string PipelineRunStatus { get; set; }
        public DateTimeOffset MaxPipelineTimeGenerated { get; set; }
    }
}
