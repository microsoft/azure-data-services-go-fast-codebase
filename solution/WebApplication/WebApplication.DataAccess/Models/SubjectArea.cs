using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebApplication.Models
{
    public partial class SubjectArea
    {
        public int SubjectAreaId { get; set; }
        [Display(Name = "Subject Area Name")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Area Name")]
        public string SubjectAreaName { get; set; }

        [StringLength(10)]
        [RegularExpression("^[a-zA-Z0-9]{3,10}$", ErrorMessage = "Short Code must be between 3-10 alphanumeric characters.")]
        public string ShortCode { get; set; }
        public bool ActiveYn { get; set; }
        [Display(Name = "Subject Area Form")]
        public int? SubjectAreaFormId { get; set; }
        [Display(Name = "Target Json Schema")]
        [Required(AllowEmptyStrings = false, ErrorMessage = "Please input valid Json Schema")]
        public string DefaultTargetSchema { get; set; }
        public string UpdatedBy { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime ValidFrom { get; set; }
        [DatabaseGenerated(DatabaseGeneratedOption.Computed)]
        public DateTime ValidTo { get; set; }

        public long? ExtractionVersionId { get; set; }

    }
}