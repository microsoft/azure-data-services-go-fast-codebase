namespace SecureFileUploader.Portal.Web.Interfaces;

public interface ICsvParser
{
    Task<List<T>> GetRecordsAsync<T>(IFormFile file);
}
