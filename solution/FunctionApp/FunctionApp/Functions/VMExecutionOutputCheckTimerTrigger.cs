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
        private readonly AzureDataLakeService _azureDataLakeService;

        public ILogger Log { get; set; }


        public VMExecutionOutputCheckTimerTrigger(IOptions<ApplicationOptions> appOptions, TaskMetaDataDatabase taskMetaDataDatabase, AzureDataLakeService azureDataLakeService)
        {
            _appOptions = appOptions;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _azureDataLakeService = azureDataLakeService;     
        }

        [FunctionName("VMExecutionOutputCheckTimerTrigger")]
        public async Task Run([TimerTrigger("0 */2 * * * *")] TimerInfo myTimer, ILogger log, ExecutionContext context)
        {
            this.Log = log;
            Guid executionId = context.InvocationId;
            FrameworkRunner fr = new FrameworkRunner(log, executionId);
            FrameworkRunnerWorker worker = VMExecutionOutputCheckCore;
            FrameworkRunnerResult result = await fr.Invoke("VMExecutionOutputCheckCore", worker);


        }

        public async Task<dynamic> VMExecutionOutputCheckCore(Logging.Logging logging)
        {
            try
            {
                using var con = await _taskMetaDataDatabase.GetSqlConnection();

                var activeTasks = con.QueryWithRetry(@"SELECT
                TI.TaskMasterId, TI.TaskInstanceId, TI.LastExecutionUid, TI.LastExecutionStatus, TM.EngineId, TM.TaskTypeId, EE.EngineJson, TM.TaskMasterJSON, TI.NumberOfRetries
            FROM
                [dbo].[TaskInstance] TI
                INNER JOIN TaskMaster TM
                    on TI.TaskMasterId = TM.TaskMasterId

                INNER JOIN[dbo].[ExecutionEngine] EE

                    on TM.EngineId = EE.EngineId
            WHERE
                TI.LastExecutionStatus = 'InProgress' AND TM.TaskTypeId = -13
            ");
                foreach (var task in activeTasks)
                {
                    string executionUid = (((dynamic)task).LastExecutionUid).ToString();
                    string engineJsonString = ((dynamic)task).EngineJson;
                    JObject engineJson = JObject.Parse(engineJsonString);
                    string taskMasterJsonString = ((dynamic)task).TaskMasterJSON;
                    JObject taskMasterJson = JObject.Parse(taskMasterJsonString);
                    string instanceId = (((dynamic)task).TaskInstanceId).ToString();
                    var retries = (((dynamic)task).NumberOfRetries);
                    logging.LogInformation($"Active VM Execution Task found with TaskInstanceId: {instanceId}");
                    var storageAccountName = engineJson["StorageAccountName"].ToString();
                    var containerName = taskMasterJson["Target"]["Type"].ToString();
                    var directory = "output/";
                    var fileName = executionUid + ".json";
                    var fileExists = await _azureDataLakeService.FileExists(storageAccountName, containerName, directory, fileName, logging);
                    logging.LogInformation($"Relevant Output file exists: {fileExists}");
                    var archiveDirectory = DateTime.UtcNow.ToString("yyyy/MM/dd/");
                    archiveDirectory = "archive/" + archiveDirectory;
                    if (fileExists)
                    {
                        var json = await _azureDataLakeService.GetJsonFile(storageAccountName, containerName, directory, fileName, logging);
                        var success = true;
                        if (json.ContainsKey("ErrorOutput"))
                        {
                            logging.LogInformation($"Error has been found in output json: {json["ErrorOutput"]}");
                            success = false;
                        }
                        await _azureDataLakeService.DeleteFile(storageAccountName, containerName, directory, fileName, logging);
                        json["ArchiveCreatedUTC"] = DateTime.UtcNow.ToString("dd/MM/yyyy HH:mm:ss tt");
                        await _azureDataLakeService.UploadFile(storageAccountName, containerName, archiveDirectory, fileName, json, logging);
                        if (success)
                        {
                            var msg = $"Sucessfully completed VM Execution. Archive file created. Storage Account: {storageAccountName}. Container: {containerName}. File path: {archiveDirectory}{fileName}.";
                            await _taskMetaDataDatabase.LogTaskInstanceCompletion(System.Convert.ToInt64(instanceId), logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.Complete, System.Guid.Empty, msg);
                        }
                        else
                        {
                            var msg = $"Failed VM Execution Task - refer to archive file for error output. Archive file created. Storage Account: {storageAccountName}. Container: {containerName}. File path: {archiveDirectory}{fileName}.";
                            await _taskMetaDataDatabase.LogTaskInstanceCompletion(System.Convert.ToInt64(instanceId), logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, System.Guid.Empty, msg);
                            logging.LogErrors(new Exception(msg));
                        }
                    }
                }
            }
            catch (Exception ex1)
            {
                logging.LogErrors(new Exception("VM Execution Output Failed"));
                logging.LogErrors(ex1);
            }
            return new { };
        }
 
        



    }

}







