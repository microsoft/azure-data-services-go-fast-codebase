using System.ComponentModel.DataAnnotations;
using SecureFileUploader.Common.Dtos;

namespace SecureFileUploader.Portal.Web.Dtos;

public class FileUpload : BaseProgram
{
    [Required]
    public override string Name { get; set; }
    [Required]
    public override DateTime CommencementDate { get; set; }
    [Required]
    public override DateTime SubmissionDeadline { get; set; }
    [Required]
    public override string TimeZone { get; set; }
    [Required]
    public IFormFile File { get; set; }
}
