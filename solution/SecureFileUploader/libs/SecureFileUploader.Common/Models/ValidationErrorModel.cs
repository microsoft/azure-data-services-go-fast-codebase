using Newtonsoft.Json;

namespace SecureFileUploader.Common.Models;

public class ValidationErrorModel
{
    public List<string> ErrorMessage { get; } = new();
}
