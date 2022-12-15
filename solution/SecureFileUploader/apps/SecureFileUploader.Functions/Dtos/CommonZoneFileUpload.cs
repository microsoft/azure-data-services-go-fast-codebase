using System;
using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;

namespace SecureFileUploader.Functions.Dtos;

public class CommonZoneFileUpload
{
    [Required]
    public IFormFile File { get; set; }

    [Required]
    public Guid AccessToken { get; set; }
}
