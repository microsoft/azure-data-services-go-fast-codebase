using System.ComponentModel.DataAnnotations;

namespace SecureFileUploader.CommonZone.Web.Dtos;

public class FileUpload
{
    [Required]
    public IFormFile File { get; set; }

    [Required]
    public string QueryString { get; set; }
}
