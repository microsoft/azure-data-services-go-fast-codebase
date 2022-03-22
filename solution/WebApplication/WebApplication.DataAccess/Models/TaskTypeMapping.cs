using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class TaskTypeMapping
    {
        public int TaskTypeMappingId { get; set; }
        [Display(Name = "Task Type")]
        public int TaskTypeId { get; set; }
        [Display(Name = "Mapping Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Mapping Type")]
        public string MappingType { get; set; }
        [Display(Name = "Mapping Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Mapping Name")]
        public string MappingName { get; set; }
        [Display(Name = "Source System Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Source System Type")]
        public string SourceSystemType { get; set; }
        [Display(Name = "Source Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Source Type")]
        public string SourceType { get; set; }
        [Display(Name = "Target System Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Target System Type")]
        public string TargetSystemType { get; set; }
        [Display(Name = "Target Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input a valid Target Type")]
        public string TargetType { get; set; }
        [Display(Name = "Task Type Json")]
        public string TaskTypeJson { get; set; }
        [Display(Name = "Is Active")]
        public bool ActiveYn { get; set; }
        [Display(Name = "Task Master Json Schema")]
        public string TaskMasterJsonSchema { get; set; }
        [Display(Name = "Task Instance Json Schema")]
        public string TaskInstanceJsonSchema { get; set; }
    }
}
