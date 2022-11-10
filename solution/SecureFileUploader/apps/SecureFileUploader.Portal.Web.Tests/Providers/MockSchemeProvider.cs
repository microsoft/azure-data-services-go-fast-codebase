using Microsoft.AspNetCore.Authentication;
using Microsoft.Extensions.Options;
using SecureFileUploader.Portal.Web.Tests.Handlers;

namespace SecureFileUploader.Portal.Web.Tests.Providers;

public class MockSchemeProvider : AuthenticationSchemeProvider
{
    public MockSchemeProvider(IOptions<AuthenticationOptions> options)
        : base(options)
    {
    }

    protected MockSchemeProvider(
        IOptions<AuthenticationOptions> options,
        IDictionary<string, AuthenticationScheme> schemes
    )
        : base(options, schemes)
    {
    }

    public override Task<AuthenticationScheme?> GetSchemeAsync(string name)
    {
        if (name == "EasyAuth")
        {
            var scheme = new AuthenticationScheme(
                "EasyAuth",
                "EasyAuth",
                typeof(MockAuthenticationHandler)
            );
            return Task.FromResult(scheme)!;
        }

        return base.GetSchemeAsync(name);
    }
}
