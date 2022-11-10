using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.Portal.Web.Dtos;

public class PreviewFileUpload
{
    [Required]
    public IFormFile File { get; set; }
}
