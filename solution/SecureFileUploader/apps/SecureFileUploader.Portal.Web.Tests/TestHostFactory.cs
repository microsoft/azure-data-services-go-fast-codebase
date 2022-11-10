using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.TestHost;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using NodaTime;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Portal.Web.Tests.Providers;
using SecureFileUploader.Portal.Web.Tests.Services;
using SystemClock = NodaTime.SystemClock;

namespace SecureFileUploader.Portal.Web.Tests;

public class TestHostFactory
{
    public static HttpClient CreateTestClient(Action<TestClientCreateOptions>? testClientCreateOptions = null)
    {
        var createOptions = new TestClientCreateOptions();
        testClientCreateOptions?.Invoke(createOptions);
        return CreateTestClient(createOptions);
    }

    public static HttpClient CreateTestClient(TestClientCreateOptions testClientCreateOptions)
    {
        var server = new TestServer(
            new WebHostBuilder()
                .UseStartup<Startup>()
                .ConfigureServices(services =>
                {
                    services.AddTransient<IAuthenticationSchemeProvider, MockSchemeProvider>();
                    services.AddSingleton<IClock>(SystemClock.Instance);
                    services.AddSingleton<IRequestContext, TestRequestContext>();

                    if (testClientCreateOptions.DbContext.Options == null) return;

                    services.AddDbContext<SecureFileUploaderContext>(testClientCreateOptions.DbContext.Options);

                    if (testClientCreateOptions.DbContext.InitializationStepsForTests == null) return;

                    var serviceProvider = services.BuildServiceProvider();
                    using var scope = serviceProvider.CreateScope();
                    var dbContext = scope.ServiceProvider.GetRequiredService<SecureFileUploaderContext>();
                    testClientCreateOptions.DbContext.InitializationStepsForTests(dbContext);
                }));

        return server.CreateClient();
    }

    public class TestClientCreateOptions
    {
        public DbContextCreateOptions DbContext { get; set; } = new();
    }

    public class DbContextCreateOptions
    {
        public Action<DbContextOptionsBuilder>? Options { get; set; }
        public Action<DbContext>? InitializationStepsForTests { get; set; }
    }
}
