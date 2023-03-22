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
using System.Linq;
using Microsoft.ApplicationInsights.Extensibility;

[assembly: FunctionsStartup(typeof(Startup))]

namespace FunctionApp
{
    /// <summary>\
    ///     This is a C# class named "Startup" that inherits from a class called "FunctionsStartup".*/
    ///     It sets up the application's configuration, services, and dependencies.
    /// </summary>
    public class Startup : FunctionsStartup
    {
        /// <summary>
        //     This method is used to configure the services collection.
        ///    The method starts by creating a ConfigurationBuilder object and setting the base path to the current working folder. It then adds a JSON file named "appsettings.json" to the configuration, user secrets, and environment variables.
        ///    The method then calls another method called "ConfigureServices" which is used to configure the services collection. This method takes in the services collection and the configuration object as parameters.
        ///    The method also adds a custom telemetry processor called "SuccessfulDependencyFilter" to the telemetry configuration.        
        /// </summary>
        /// <param name="builder"></param>
        public override void Configure(IFunctionsHostBuilder builder)
        {
            var config = new ConfigurationBuilder()
                .SetBasePath(EnvironmentHelper.GetWorkingFolder())
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddUserSecrets(Assembly.GetExecutingAssembly(), true)
                .AddEnvironmentVariables()
                .Build();

            ConfigureServices(builder.Services, config);

            //Add a custom telemetry processor
            var configDescriptor = builder.Services.SingleOrDefault(tc => tc.ServiceType == typeof(TelemetryConfiguration));
            if (configDescriptor?.ImplementationFactory != null)
            {
                var implFactory = configDescriptor.ImplementationFactory;
                builder.Services.Remove(configDescriptor);
                builder.Services.AddSingleton(provider =>
                {
                    if (implFactory.Invoke(provider) is TelemetryConfiguration config)
                    {
                        var newConfig = config;
                        newConfig.ApplicationIdProvider = config.ApplicationIdProvider;
                        newConfig.InstrumentationKey = config.InstrumentationKey;
                        newConfig.TelemetryProcessorChainBuilder.Use(next => new SuccessfulDependencyFilter(next));
                        /*foreach (var processor in config.TelemetryProcessors)
                        {
                            newConfig.TelemetryProcessorChainBuilder.Use(next => processor);
                        }*/                        
                        newConfig.TelemetryProcessorChainBuilder.Build();
                        newConfig.TelemetryProcessors.OfType<ITelemetryModule>().ToList().ForEach(module => module.Initialize(newConfig));
                        return newConfig;
                    }
                    return null;
                });
            }

        }

        /// <summary>
        ///     This method is used to configure the services collection.
        ///     The method configures Dapper, adds the application options, downstream authentication options, and the authentication provider to the services collection.
        ///     The method also adds the TaskTypeMappingProvider, TaskMetaDataDatabase, DataFactoryClientFactory, SourceAndTargetSystemJsonSchemasProvider, AzureSynapseService, IntegrationRuntimeMappingProvider, KeyVaultService, PowerBIService, DataFactoryPipelineProvider, and SecurityAccessProvider to the services collection.
        ///     The method also adds an Http Client to the services collection.
        /// </summary>
        /// <param name="services"></param>
        /// <param name="config"></param>
        public static void ConfigureServices(IServiceCollection services, IConfigurationRoot config)
        {
            //Application Insights
            //services.AddApplicationInsightsTelemetry();
            //services.AddApplicationInsightsTelemetryProcessor<SuccessfulDependencyFilter>();
            
            
            //Configure Dapper
            Dapper.DefaultTypeMap.MatchNamesWithUnderscores = true;

            services.Configure<ApplicationOptions>(config.GetSection("ApplicationOptions"));
            services.Configure<DownstreamAuthOptionsDirect>(config.GetSection("AzureAdAzureServicesDirect"));
            services.Configure<DownstreamAuthOptionsViaAppReg>(config.GetSection("AzureAdAzureServicesViaAppReg"));

            var appOptions = config.GetSection("ApplicationOptions").Get<ApplicationOptions>();
            var downstreamAuthOptionsDirect = config.GetSection("AzureAdAzureServicesDirect").Get<DownstreamAuthOptionsDirect>();
            var downstreamAuthOptionsViaAppReg = config.GetSection("AzureAdAzureServicesViaAppReg").Get<DownstreamAuthOptionsViaAppReg>();
            //Used for Service Connections
            var downstreamAuthenticationProvider = new AzureIdentityAuthenticationProvider(appOptions, downstreamAuthOptionsDirect);
            //Only Used for Chained Function Calls
            var downstreamViaAppRegAuthenticationProvider = new MicrosoftAzureServicesAppAuthenticationProvider(downstreamAuthOptionsViaAppReg, appOptions.UseMSI);

            services.AddSingleton<TaskTypeMappingProvider>();
            services.AddSingleton<TaskMetaDataDatabase>();
            services.AddSingleton<DataFactoryClientFactory>();
            services.AddSingleton<SourceAndTargetSystemJsonSchemasProvider>();
            services.AddSingleton<AzureSynapseService>();
            services.AddSingleton<IntegrationRuntimeMappingProvider>();
            services.AddSingleton<KeyVaultService>();
            services.AddSingleton<PowerBIService>();
            services.AddSingleton<AzureDataLakeService>();
            services.AddSingleton<DataFactoryPipelineProvider>();
            services.AddSingleton<MicrosoftAzureServicesAppAuthenticationProvider>(downstreamViaAppRegAuthenticationProvider);
            services.AddSingleton<IAzureAuthenticationProvider>(downstreamAuthenticationProvider);
            //services.AddSingleton<IAzureAuthenticationProvider>(downstreamViaAppRegAuthenticationProvider);
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

