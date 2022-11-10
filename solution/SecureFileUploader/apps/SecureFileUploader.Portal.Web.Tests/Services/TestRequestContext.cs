using SecureFileUploader.Data.Interfaces;

namespace SecureFileUploader.Portal.Web.Tests.Services;

public class TestRequestContext : IRequestContext
{
    public string DisplayName {
        get => "TestName";
    }
}
