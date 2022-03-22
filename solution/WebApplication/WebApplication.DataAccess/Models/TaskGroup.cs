using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskGroup
    {
        public long TaskGroupId { get; set; }
        [Display(Name = "Group Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Group Name")]
        public string TaskGroupName { get; set; }
        [Display(Name = "Group Priority")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Group Priority")]
        public int TaskGroupPriority { get; set; }
        [Display(Name = "Group Concurrency")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Group Concurrency")]
        public int TaskGroupConcurrency { get; set; }
        [Display(Name = "Group Json")]
        public string TaskGroupJson { get; set; }
        [Display(Name = "Subject Area")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input a valid Subject Area Id")]
        public int SubjectAreaId {get; set;}
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
    }

    
}
