/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


using System;
using System.Net.Http.Headers;
using System.Reflection;
using FunctionApp;
using FunctionApp.Authentication;
using FunctionApp.DataAccess;
using FunctionApp.Helpers;
using FunctionApp.Models;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.Azure.Functions.Extensions.DependencyInjection;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

[assembly: FunctionsStartup(typeof(Startup))]

namespace FunctionApp
{
    public class Startup : FunctionsStartup
    {
        public override void Configure(IFunctionsHostBuilder builder)
        {
            var config = new ConfigurationBuilder()
                .SetBasePath(EnvironmentHelper.GetWorkingFolder())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddUserSecrets(Assembly.GetExecutingAssembly(), true)
                .AddEnvironmentVariables()
                .Build();

            ConfigureServices(builder.Services, config);
        }

        public static void ConfigureServices(IServiceCollection services, IConfigurationRoot config)
        {
            //Configure Dapper
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;

            services.Configure<ApplicationOptions>(config.GetSection("ApplicationOptions"));
            services.Configure<DownstreamAuthOptionsDirect>(config.GetSection("AzureAdAzureServicesDirect"));
            services.Configure<DownstreamAuthOptionsViaAppReg>(config.GetSection("AzureAdAzureServicesViaAppReg"));

            var appOptions = config.GetSection("ApplicationOptions").Get<ApplicationOptions>();
            var downstreamAuthOptionsDirect = config.GetSection("AzureAdAzureServicesDirect").Get<DownstreamAuthOptionsDirect>();
            var downstreamAuthOptionsViaAppReg = config.GetSection("AzureAdAzureServicesViaAppReg").Get<DownstreamAuthOptionsViaAppReg>();
            var downstreamAuthenticationProvider = new MicrosoftAzureServicesAppAuthenticationProvider(downstreamAuthOptionsDirect, appOptions.UseMSI);
            var downstreamViaAppRegAuthenticationProvider = new MicrosoftAzureServicesAppAuthenticationProvider(downstreamAuthOptionsViaAppReg, appOptions.UseMSI);

            services.AddSingleton<TaskTypeMappingProvider>();
            services.AddSingleton<TaskMetaDataDatabase>();
            services.AddSingleton<DataFactoryClientFactory>();
            services.AddSingleton<MicrosoftAzureManagementAuthenticationProvider>();
            services.AddSingleton<SourceAndTargetSystemJsonSchemasProvider>();
            services.AddSingleton<AzureSynapseService>();

            services.AddSingleton<DataFactoryPipelineProvider>();
            services.AddSingleton<IAzureAuthenticationProvider>(downstreamAuthenticationProvider);
            services.AddSingleton<ISecurityAccessProvider>((provider) => new SecurityAccessProvider(downstreamAuthOptionsViaAppReg, appOptions));

            //Inject Http Client for chained calling of core functions
            services.AddHttpClient(HttpClients.CoreFunctionsHttpClientName, async (s, c) =>
            {
                var token = await downstreamViaAppRegAuthenticationProvider.GetAzureRestApiToken(downstreamAuthOptionsViaAppReg.Audience).ConfigureAwait(false);
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes

            services.AddHttpClient(HttpClients.AppInsightsHttpClientName, async (s, c) =>
            {
                var token = await downstreamAuthenticationProvider.GetAzureRestApiToken("https://api.applicationinsights.io").ConfigureAwait(false);
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes          

            services.AddHttpClient(HttpClients.LogAnalyticsHttpClientName, async (s, c) =>
            {
                var token = await downstreamAuthenticationProvider.GetAzureRestApiToken("https://api.loganalytics.io").ConfigureAwait(false);
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes


            services.AddHttpClient(HttpClients.PurviewHttpClientName, async (s, c) =>
            {
                var token = await downstreamAuthenticationProvider.GetAzureRestApiToken("https://purview.azure.net").ConfigureAwait(false);
                c.DefaultRequestHeaders.Accept.Clear();
                c.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
                c.DefaultRequestHeaders.Authorization = new AuthenticationHeaderValue("Bearer", token);
            }).SetHandlerLifetime(TimeSpan.FromMinutes(5));  //Set lifetime to five minutes

            services.AddSingleton<PurviewService>();
        }
    }
}

