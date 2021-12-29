using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskMaster
    {
        public long TaskMasterId { get; set; }
        [Display(Name = "Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Name")]
        public string TaskMasterName { get; set; }
        [Display(Name = "Task Type")]
        public int TaskTypeId { get; set; }
        [Display(Name = "Task Group")]
        public long TaskGroupId { get; set; }
        [Display(Name = "Schedule Master")]
        public long ScheduleMasterId { get; set; }
        [Display(Name = "Source System")]
        public long SourceSystemId { get; set; }
        [Display(Name = "Target System")]
        public long TargetSystemId { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Degree Of Parallelism")]
        public int DegreeOfCopyParallelism { get; set; }
        public bool AllowMultipleActiveInstances { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid DataFactory")]
        public string TaskDatafactoryIr { get; set; }
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid json data")]
        public string TaskMasterJson { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
        public string DependencyChainTag { get; set; }
        public long DataFactoryId { get; set; }
    }
}
