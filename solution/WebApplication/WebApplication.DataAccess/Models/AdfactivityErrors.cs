using System;

namespace WebApplication.Models
{
    public partial class AdfactivityErrors
    {
        public long? EngineId { get; set; }
        public string TenantId { get; set; }
        public string SourceSystem { get; set; }
        public DateTime? TimeGenerated { get; set; }
        public string ResourceId { get; set; }
        public string OperationName { get; set; }
        public string Category { get; set; }
        public Guid CorrelationId { get; set; }
        public string Level { get; set; }
        public string Location { get; set; }
        public string Tags { get; set; }
        public string Status { get; set; }
        public string UserProperties { get; set; }
        public string Annotations { get; set; }
        public string EventMessage { get; set; }
        public DateTime? Start { get; set; }
        public string ActivityName { get; set; }
        public string ActivityRunId { get; set; }
        public Guid? PipelineRunId { get; set; }
        public string EffectiveIntegrationRuntime { get; set; }
        public string ActivityType { get; set; }
        public int? ActivityIterationCount { get; set; }
        public string LinkedServiceName { get; set; }
        public DateTime? End { get; set; }
        public string FailureType { get; set; }
        public string PipelineName { get; set; }
        public string Input { get; set; }
        public string Output { get; set; }
        public int? ErrorCode { get; set; }
        public string ErrorMessage { get; set; }
        public string Error { get; set; }
        public string Type { get; set; }
    }
}
