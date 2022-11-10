using SecureFileUploader.Data.Interfaces;

namespace SecureFileUploader.Data.Models;

public abstract class BaseEntity<T> : IAuditable
{
    public T Id { get; set; }
    public DateTime CreatedOn { get; set; }
    public string CreatedBy { get; set; } = string.Empty;
    public DateTime LastModifiedOn { get; set; }
    public string LastModifiedBy { get; set; } = string.Empty;
}
