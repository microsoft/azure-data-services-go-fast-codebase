/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/



using AdsGoFast;
using AdsGoFast.Models;
using AdsGoFast.Models.Options;
using AdsGoFast.Services;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Azure.WebJobs.Host.Bindings;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Microsoft.Identity.Web;
using System;
using System.IO;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Reflection;


[assembly: FunctionsStartup(typeof(AdsGoFast.Startup))]

namespace AdsGoFast
{
    public class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            //Swap between local development and deployed root paths
            var local_root = Environment.GetEnvironmentVariable("AzureWebJobsScriptRoot");          
            var azure_root = $"{Environment.GetEnvironmentVariable("HOME")}\\site\\wwwroot";

            var actual_root = local_root ?? azure_root;
            
            var config = new ConfigurationBuilder()
              .SetBasePath(actual_root)
              .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
              .AddUserSecrets(Assembly.GetExecutingAssembly(), true)
              .AddEnvironmentVariables()
              .Build();

            builder.Services.Configure<AuthOptions>(config.GetSection("AzureAdAuth"));
            builder.Services.Configure<ApplicationOptions>(config.GetSection("ApplicationOptions"));
            builder.Services.Configure<DownstreamAuthOptionsDirect>(config.GetSection("AzureAdAzureServicesDirect"));
            builder.Services.Configure<DownstreamAuthOptionsViaAppReg>(config.GetSection("AzureAdAzureServicesViaAppReg"));


            var AppOptions = config.GetSection("ApplicationOptions").Get<ApplicationOptions>();
            var DownstreamAuthOptionsDirect = config.GetSection("AzureAdAzureServicesDirect").Get<DownstreamAuthOptionsDirect>();
            Shared._ApplicationBasePath = actual_root;
            Shared._ApplicationOptions = AppOptions;
            Shared._DownstreamAuthOptionsDirect = DownstreamAuthOptionsDirect;
            Shared._AzureAuthenticationCredentialProvider = new AzureAuthenticationCredentialProvider(Options.Create(AppOptions), DownstreamAuthOptionsDirect);

            //builder.Services.AddSingleton<IConfiguration>(config); 
            builder.Services.AddSingleton<ISecurityAccessProvider>((provider) =>
            {
                var authOptions = provider.GetService<IOptions<DownstreamAuthOptionsViaAppReg>>();
                var appOptions = provider.GetService<IOptions<ApplicationOptions>>();
                return new SecurityAccessProvider(authOptions, appOptions);
            });

            //Inject Http Client for chained calling of core functions
            builder.Services.AddHttpClient("CoreFunctions",async (s,c) =>
            {
                var downstreamAuthOptionsViaAppReg = s.GetService<IOptions<DownstreamAuthOptionsViaAppReg>>();
                var appOptions = s.GetService<IOptions<ApplicationOptions>>();
                var authProvider = new AzureAuthenticationCredentialProvider(appOptions,downstreamAuthOptionsViaAppReg.Value);
                var token = authProvider.GetAzureRestApiToken(downstreamAuthOptionsViaAppReg.Value.Audience);
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes

            //Inject Context for chained calling of core functions
            builder.Services.AddSingleton<ICoreFunctionsContext,CoreFunctionsContext>();

            builder.Services.AddSingleton<IAppInsightsContext, AppInsightsContext>();

            builder.Services.AddHttpClient("AppInsights", async (s, c) =>
            {
                var downstreamAuthOptions= s.GetService<IOptions<DownstreamAuthOptionsDirect>>();
                var appOptions = s.GetService<IOptions<ApplicationOptions>>();
                var authProvider = new AzureAuthenticationCredentialProvider(appOptions, downstreamAuthOptions.Value);
                var token = authProvider.GetAzureRestApiToken("https://api.applicationinsights.io");
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes          

            builder.Services.AddHttpClient("LogAnalytics", async (s, c) =>
            {
                var downstreamAuthOptions = s.GetService<IOptions<DownstreamAuthOptionsDirect>>();
                var appOptions = s.GetService<IOptions<ApplicationOptions>>();
                var authProvider = new AzureAuthenticationCredentialProvider(appOptions, downstreamAuthOptions.Value);
                var token = authProvider.GetAzureRestApiToken("https://api.loganalytics.io");
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes

            builder.Services.AddSingleton<ILogAnalyticsContext, LogAnalyticsContext>();

            builder.Services.AddHttpClient("TaskMetaDataDatabase", async (s, c) =>
            {
                var downstreamAuthOptions = s.GetService<IOptions<DownstreamAuthOptionsDirect>>();
                var appOptions = s.GetService<IOptions<ApplicationOptions>>();
                var authProvider = new AzureAuthenticationCredentialProvider(appOptions, downstreamAuthOptions.Value);
                var token = authProvider.GetAzureRestApiToken("https://database.windows.net/");
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes
        }
    }
}

