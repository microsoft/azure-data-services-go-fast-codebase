using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskType
    {
        [Display(Name = "Task Execution Type")]
        public int TaskTypeId { get; set; }
        [Display(Name = "Task Type Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Task Type Name")]
        public string TaskTypeName { get; set; }
        //public string TaskExecutionType { get; set; }
        [Display(Name = "Task Type Json")]
        public string TaskTypeJson { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
    }
}
