namespace SecureFileUploader.Data.Interfaces;

public interface IAuditable
{
    public DateTime CreatedOn { get; set; }
    public string CreatedBy { get; set; }
    public DateTime LastModifiedOn { get; set; }
    public string LastModifiedBy { get; set; }
}
