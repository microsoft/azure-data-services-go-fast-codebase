using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskMaster
    {
        public long TaskMasterId { get; set; }
        public string TaskMasterName { get; set; }
        public int TaskTypeId { get; set; }
        public long TaskGroupId { get; set; }
        public long ScheduleMasterId { get; set; }
        public long SourceSystemId { get; set; }
        public long TargetSystemId { get; set; }
        public int DegreeOfCopyParallelism { get; set; }
        public bool AllowMultipleActiveInstances { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input a DataFactory")]
        public string TaskDatafactoryIr { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid json data")]
        public string TaskMasterJson { get; set; }
        public bool ActiveYn { get; set; }
        public bool InsertIntoCurrentSchedule { get; set; }
        public string DependencyChainTag { get; set; }
        public long EngineId { get; set; }
        [Display(Name = "Extraction Version Id")]
        public long? ExtractionVersionId { get; set; }
    }
}
