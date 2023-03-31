using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace WebApplication.Models
{
    public partial class MetadataExtractionVersion
    {
        [Display(Name = "Version Id")]
        public long ExtractionVersionId { get; set; }

        [Display(Name = "Extracted Date Time")]
        public DateTime? ExtractedDateTime { get; set; }

    }
}
