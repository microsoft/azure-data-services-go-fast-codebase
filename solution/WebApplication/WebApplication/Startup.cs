using Microsoft.Identity.Web;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Data.SqlClient;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using WebApplication.Helpers;
using WebApplication.Models;
using WebApplication.Models.Options;
using WebApplication.Services;
using Microsoft.AspNetCore.Authentication.Cookies;
using WebApplication.Framework;
using System;
using Polly.Extensions.Http;
using Polly;
using System.Net.Http;
using System.Net.Http.Headers;
using Microsoft.Extensions.Options;

namespace WebApplication
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            System.Data.Common.DbProviderFactories.RegisterFactory("System.Data.SqlClient", Microsoft.Data.SqlClient.SqlClientFactory.Instance);
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddApplicationInsightsTelemetry();
         
            services.Configure<ApplicationOptions>(Configuration.GetSection("ApplicationOptions"));
            services.Configure<SecurityModelOptions>(Configuration.GetSection("SecurityModelOptions"));
            services.Configure<AuthOptions>(Configuration.GetSection("AzureAd"));

            //Configure Entity Framework with Token Auth via Interceptor
            services.AddSingleton<AadAuthenticationDbConnectionInterceptor>();
            services.AddDbContext<AdsGoFastContext>((provider, options) =>
            {
                var appOptions = provider.GetService<IOptions<ApplicationOptions>>();
                if (!string.IsNullOrEmpty(appOptions.Value.ConnectionString))
                {
                    options.UseSqlServer(appOptions.Value.ConnectionString);
                }
                else
                {
                    SqlConnectionStringBuilder scsb = new SqlConnectionStringBuilder
                    {
                        DataSource = appOptions.Value.AdsGoFastTaskMetaDataDatabaseServer,
                        InitialCatalog = appOptions.Value.AdsGoFastTaskMetaDataDatabaseName
                    };
                    options.UseSqlServer(scsb.ConnectionString);
                    options.AddInterceptors(provider.GetRequiredService<AadAuthenticationDbConnectionInterceptor>());
                }
            });

            //Configure HttpClients for a centralised management using HttpClientFactory
            services.AddHttpClient<AppInsightsContext>(async (s,c) =>
            {
                var authProvider = s.GetService<AzureAuthenticationCredentialProvider>();
                var token = authProvider.GetAzureRestApiToken("https://api.applicationinsights.io");
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5))  //Set lifetime to five minutes
                .AddPolicyHandler(GetRetryPolicy());

            services.AddHttpClient<LogAnalyticsContext>(async (s, c) =>
            {
                var authProvider = s.GetService<AzureAuthenticationCredentialProvider>();
                var token = authProvider.GetAzureRestApiToken("https://api.loganalytics.io");
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5))  //Set lifetime to five minutes
                .AddPolicyHandler(GetRetryPolicy());

         
            services.AddSingleton<AzureAuthenticationCredentialProvider>((provider) =>
            {
                var appOptions = provider.GetService<IOptions<ApplicationOptions>>();
                var authOptions = provider.GetService<IOptions<AuthOptions>>();
                return new AzureAuthenticationCredentialProvider(appOptions,authOptions);
            }
            );
            services.AddSingleton<AdsGoFastDapperContext>();
            services.AddSingleton<ISecurityAccessProvider, SecurityAccessProvider>();
            services.AddTransient<IEntityRoleProvider, EntityRoleProvider>();
            services.AddSingleton<IAuthorizationHandler, PermissionAssignedViaRoleHandler>();
            services.AddScoped<IAuthorizationHandler, PermissionAssignedViaControllerActionHandler>();

            services.AddControllersWithViews(opt =>
            {
                opt.Filters.Add(new DefaultHelpLinkActionFilter());
            }).AddMvcOptions(m => m.ModelMetadataDetailsProviders.Add(new HumanizerMetadataProvider()));

            //services.AddServerSideBlazor();

            services.AddRazorPages();

            services.AddMicrosoftIdentityWebAppAuthentication(Configuration, "AzureAdAuth");
            services.Configure<CookieAuthenticationOptions>(CookieAuthenticationDefaults.AuthenticationScheme, options => options.AccessDeniedPath = "/Home/AccessDenied");

            services.AddAuthorization(options =>
            {
                options.DefaultPolicy = new AuthorizationPolicyBuilder()
                            .RequireAuthenticatedUser()
                            .AddRequirements(new PermissionAssignedViaRole())
                            .Build();

                options.FallbackPolicy = new AuthorizationPolicyBuilder()
                            .RequireAuthenticatedUser()
                            .Build();
            });

        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
        {
            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();

            app.UseRouting();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Dashboard}/{action=Index}/{id?}").RequireAuthorization();
                endpoints.MapRazorPages();
             //   endpoints.MapBlazorHub();
            });
        }

        static IAsyncPolicy<HttpResponseMessage> GetRetryPolicy()
        {
            return HttpPolicyExtensions
                .HandleTransientHttpError()
                .OrResult(msg => msg.StatusCode == System.Net.HttpStatusCode.NotFound)
                .WaitAndRetryAsync(6, retryAttempt => TimeSpan.FromSeconds(Math.Pow(2, retryAttempt)));
        }
    }
}
