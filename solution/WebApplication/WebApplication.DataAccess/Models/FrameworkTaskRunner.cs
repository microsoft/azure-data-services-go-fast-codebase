using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class FrameworkTaskRunner
    {
        public int TaskRunnerId { get; set; }
        [Display(Name = "Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Name")]
        public string TaskRunnerName { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
        public string Status { get; set; }
        [Display(Name = "Maximum Concurrent Tasks")]
        public int? MaxConcurrentTasks { get; set; }
    }
}
