using SecureFileUploader.Data.Interfaces;

namespace SecureFileUploader.Functions.Services;

public class FunctionRequestContext : IRequestContext
{
    public string DisplayName {
        get => "System";
    }
}
