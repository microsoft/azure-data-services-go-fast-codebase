using System.Reflection;
using System.Text.Json.Serialization;
using CsvHelper;
using MaximeRouiller.Azure.AppService.EasyAuth;
using Microsoft.ApplicationInsights.AspNetCore.Extensions;
using Microsoft.AspNetCore.Mvc.ApplicationModels;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using SecureFileUploader.Portal.Web.Infrastructure;
using SecureFileUploader.Portal.Web.Interfaces;
using SecureFileUploader.Portal.Web.Mapping;
using SecureFileUploader.Portal.Web.Services;
using CsvParser = SecureFileUploader.Portal.Web.Services.CsvParser;

namespace SecureFileUploader.Portal.Web;

public class Startup
{
    public Startup(IConfiguration configuration)
    {
        Configuration = configuration;
    }

    public IConfiguration Configuration { get; }

    public void ConfigureServices(IServiceCollection services)
    {
        services.AddCommonServices().AddCommonConfiguration(Configuration);

        services.AddTransient<ICsvParser, CsvParser>();
        services.AddTransient<IProgramService, ProgramService>();
        services.AddTransient<ICreateProgramService, CreateProgramService>();

        var applicationInsightsOptions = new ApplicationInsightsServiceOptions
            { ConnectionString = Configuration["APPLICATIONINSIGHTS_CONNECTION_STRING"] };
        services.AddApplicationInsightsTelemetry(applicationInsightsOptions);

        services.AddDbContext<SecureFileUploaderContext>(options =>
        {
            options.UseSqlServer("name=ConnectionStrings:SecureFileUploaderDbContext");
        });

        services.AddCors();

        services.AddControllers(options =>
            {
                options.Conventions.Add(new RouteTokenTransformerConvention(new SlugifyParameterTransformer()));
                options.ModelBinderProviders.Insert(0, new CustomDateTimeModelBinderProvider());
            })
            .AddJsonOptions(options =>
                options.JsonSerializerOptions.Converters.Add(new JsonStringEnumConverter()));

        services.AddEndpointsApiExplorer();
        // Reminder: swagger available from https://localhost:44385/swagger/index.html with this setup
        services.AddSwaggerGen(options =>
        {
            options.SwaggerDoc("v1", new OpenApiInfo {
                Version = "v1",
                Title = "Secure File Uploader API"
            });
            options.IncludeXmlComments(Path.Combine(AppContext.BaseDirectory, $"{Assembly.GetExecutingAssembly().GetName().Name}.xml"));
        });

        services.AddAutoMapper(config =>
        {
            config.AddProfile<MappingProfile>();
        });

        services.AddHttpContextAccessor();
        services.AddTransient<IFactory, Factory>();
        services.AddScoped<IRequestContext, RequestContext>();

        // https://github.com/MaximRouiller/MaximeRouiller.Azure.AppService.EasyAuth
        services.AddAuthentication("EasyAuth").AddEasyAuthAuthentication((o) => { });
    }

    public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
    {
        // Configure the HTTP request pipeline.
        if (env.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
            // port 3000 likely no longer required
            app.UseCors(x => x.AllowAnyHeader().AllowAnyMethod().WithOrigins("http://localhost:3000",
                "https://localhost:44385", "https://localhost:44496"));
        }
        else
        {
            app.UseExceptionHandler("/Error");
            app.UseHsts();
            // Due to an issue CORS entry should be added to portal manually as a workaround
        }

        app.UseHttpsRedirection();

        app.UseStaticFiles();
        app.UseRouting();

        app.UseAuthentication();
        app.UseAuthorization();

        app.UseEndpoints(endpoints =>
            {
                endpoints.MapFallbackToFile("index.html");
                if (env.IsDevelopment())
                {
                    // allow anon locally because we are forcing easy auth under Azure
                    endpoints.MapControllers().AllowAnonymous();
                }
                else
                {
                    endpoints.MapControllers();
                }
            }
        );
    }
}
