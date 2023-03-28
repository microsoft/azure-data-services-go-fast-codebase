/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Cronos;
using FunctionApp.DataAccess;
using FunctionApp.Helpers;
using FunctionApp.Models;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.ApplicationInsights;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace FunctionApp.Functions
{

    // ReSharper disable once UnusedMember.Global
    public class VMExecutionOutputCheckTimerTrigger
    {
        private readonly IOptions<ApplicationOptions> _appOptions;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly DataFactoryPipelineProvider _dataFactoryPipelineProvider;
        private readonly TaskTypeMappingProvider _taskTypeMappingProvider;
        private readonly IntegrationRuntimeMappingProvider _integrationRuntimeMappingProvider;
        private readonly IHttpClientFactory _httpClientFactory;    

        public string HeartBeatFolder { get; set; }
        public ILogger Log { get; set; }


        public VMExecutionOutputCheckTimerTrigger(IOptions<ApplicationOptions> appOptions, TaskMetaDataDatabase taskMetaDataDatabase, DataFactoryPipelineProvider dataFactoryPipelineProvider, TaskTypeMappingProvider taskTypeMappingProvider, IHttpClientFactory httpClientFactory, IntegrationRuntimeMappingProvider integrationRuntimeMappingProvider)
        {
            _appOptions = appOptions;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _dataFactoryPipelineProvider = dataFactoryPipelineProvider;
            _taskTypeMappingProvider = taskTypeMappingProvider;
            _httpClientFactory = httpClientFactory;
            _integrationRuntimeMappingProvider = integrationRuntimeMappingProvider;            
        }

        [FunctionName("VMExecutionOutputCheckTimerTrigger")]
        public async Task Run([TimerTrigger("0 */2 * * * *")] TimerInfo myTimer, ILogger log, ExecutionContext context)
        {
            this.Log = log;
            log.LogInformation(context.FunctionAppDirectory);
            //await VMExecutionOutputCheckCore(log);

        }
        /*
        public async Task<dynamic> VMExecutionOutputCheckCore(ILogger log)
        {
            try
            {
                await _taskMetaDataDatabase.ExecuteSql(
                    $"Insert into Execution values ('{logging.DefaultActivityLogItem.ExecutionUid}', '{DateTimeOffset.Now:u}', '{DateTimeOffset.Now.AddYears(999):u}')");
                short frameworkWideMaxConcurrency = _appOptions.Value.FrameworkWideMaxConcurrency;
                //Generate new task instances based on task master and schedules
                await CreateScheduleAndTaskInstances(logging);
                await _taskMetaDataDatabase.ExecuteSql("exec dbo.DistributeTasksToRunnners " + frameworkWideMaxConcurrency.ToString());
            }
            catch (Exception ex)
            {
                logging.LogErrors(new Exception("Prepare Framework Task Failed"));
                logging.LogErrors(ex);
            }
            //Chain Straight into RunFramework Tasks
            try
            {
                AdfRunFrameworkTasksTimerTrigger rfttt = new AdfRunFrameworkTasksTimerTrigger(_appOptions, _taskMetaDataDatabase, _httpClientFactory);
                rfttt.HeartBeatFolder = this.HeartBeatFolder;                
                await rfttt.Core(Log);
            }
            catch (Exception ex1)
            {
                logging.LogErrors(new Exception("Run Framework Task Failed"));
                logging.LogErrors(ex1);
            }
            return new { };
        }
 
        */



    }

}







