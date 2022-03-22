using System.ComponentModel.DataAnnotations;

namespace WebApplication.Models
{
    public partial class SourceAndTargetSystemsJsonSchema
    {
        [Display(Name = "Type")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Type")]
        public string SystemType { get; set; }
        [Display(Name = "Json Schema")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Json Schema")]
        public string JsonSchema { get; set; }
    }
}
