using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    [System.ComponentModel.DataAnnotations.DisplayColumn("ScheduleDesciption")]
    public partial class ScheduleMaster
    {
        public long ScheduleMasterId { get; set; }    
        [Display(Name = "Description")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Description")]
        public string ScheduleDesciption { get; set; }
        [Display(Name = "Cron Expression")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Cron Expression")]
        public string ScheduleCronExpression { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
    }
}
