using System;
using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskMasterWaterMark
    {
        [Display(Name = "Name")]
        public long TaskMasterId { get; set; }
        [Display(Name = "Column Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Column Name")]
        public string TaskMasterWaterMarkColumn { get; set; }
        [Display(Name = "Column Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Column Type")]
        public string TaskMasterWaterMarkColumnType { get; set; }
        [Display(Name = "Date Time Value")]
        public DateTime? TaskMasterWaterMarkDateTime { get; set; }
        [Display(Name = "Big Integer Value")]
        public long? TaskMasterWaterMarkBigInt { get; set; }
        [Display(Name = "Configuration Json")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Json Data")]
        public string TaskWaterMarkJson { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
        public DateTimeOffset UpdatedOn { get; set; }
    }
}
