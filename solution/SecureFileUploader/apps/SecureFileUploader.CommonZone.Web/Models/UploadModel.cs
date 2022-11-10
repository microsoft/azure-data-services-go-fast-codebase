namespace SecureFileUploader.CommonZone.Web.Models;

public class UploadModel
{
    public string ProgramName { get; set; } = string.Empty;
    public int MaxFileSize { get; set; }
    public int MinFileSize { get; set; }
    public string FileSizeUnits { get; set; }
    public AllowedFileTypes AllowedFileTypes { get; set; }
    public string PhnLogo { get; set; }
}

public class AllowedFileTypes
{
    public bool AllowCsv { get; set; }
    public bool AllowJson { get; set; }
    public bool AllowZip { get; set; }
}
