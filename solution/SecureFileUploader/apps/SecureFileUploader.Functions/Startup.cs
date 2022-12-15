using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Functions;
using SecureFileUploader.Functions.Interfaces;
using SecureFileUploader.Functions.Services;

[assembly: FunctionsStartup(typeof(Startup))]

namespace SecureFileUploader.Functions;

public class Startup : FunctionsStartup
{
    public override void Configure(IFunctionsHostBuilder builder)
    {
        builder.Services.AddCommonServices().AddCommonConfiguration(builder.GetContext().Configuration);
        // Function specific request context
        builder.Services.AddScoped<IRequestContext, FunctionRequestContext>();

        builder.Services.AddLogging();

        builder.Services.AddTransient<IProgramCommencementCheckService, ProgramCommencementCheckService>();

        builder.Services.AddTransient<ICreateProgramService, CreateProgramService>();

        builder.Services.AddTransient<IPipelineService, PipelineService>();

        builder.Services.AddDbContext<SecureFileUploaderContext>(options =>
        {
            options.UseSqlServer("name=ConnectionStrings:SecureFileUploaderDbContext");
        });
    }
}
