/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Data;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Dapper;
using FormatWith;
using FunctionApp.Authentication;
using FunctionApp.DataAccess;
using FunctionApp.Helpers;
using FunctionApp.Models;
using FunctionApp.Models.GetTaskInstanceJSON;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Management.DataFactory.Models;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;
using SendGrid;
using SendGrid.Helpers.Mail;
using System.Data.SqlClient;
using System.IO;

namespace FunctionApp.Functions
{

    // ReSharper disable once UnusedMember.Global
    public class AdfRunFrameworkTasksHttpTrigger
    {
        private const string SqlInsertTaskInstanceExecution = @"
                                            INSERT INTO TaskInstanceExecution (
	                                                        [ExecutionUid]
	                                                        ,[TaskInstanceId]
	                                                        ,[EngineId]
	                                                        ,[PipelineName]
	                                                        ,[AdfRunUid]
	                                                        ,[StartDateTime]
	                                                        ,[Status]
	                                                        ,[Comment]
	                                                        )
                                                        VALUES (
	                                                            @ExecutionUid
	                                                        ,@TaskInstanceId
	                                                        ,@EngineId
	                                                        ,@PipelineName
	                                                        ,@AdfRunUid
	                                                        ,@StartDateTime
	                                                        ,@Status
	                                                        ,@Comment
	                                        )";
        private readonly ISecurityAccessProvider _sap;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly IOptions<ApplicationOptions> _options;
        private readonly IAzureAuthenticationProvider _authProvider;
        private readonly DataFactoryClientFactory _dataFactoryClientFactory;
        private readonly AzureSynapseService _azureSynapseService;
        private readonly MicrosoftAzureServicesAppAuthenticationProvider _microsoftAzureServicesAppAuthenticationProvider;
        private readonly KeyVaultService _keyVaultService;
        private readonly PowerBIService _powerBIService;
        private readonly AzureDataLakeService _azureDataLakeService;
        public string HeartBeatFolder { get; set; }


        public AdfRunFrameworkTasksHttpTrigger(ISecurityAccessProvider sap, 
            TaskMetaDataDatabase taskMetaDataDatabase,
            IOptions<ApplicationOptions> options, 
            IAzureAuthenticationProvider authProvider, 
            DataFactoryClientFactory dataFactoryClientFactory,
            AzureSynapseService azureSynapseService,
            MicrosoftAzureServicesAppAuthenticationProvider microsoftAzureServicesAppAuthenticationProvider,
            KeyVaultService keyVaultService,
            PowerBIService powerBIService,
            AzureDataLakeService azureDataLakeService)
        {
            _sap = sap;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _options = options;
            _authProvider = authProvider;
            _dataFactoryClientFactory = dataFactoryClientFactory;
            _azureSynapseService = azureSynapseService;
            _microsoftAzureServicesAppAuthenticationProvider = microsoftAzureServicesAppAuthenticationProvider;
            _keyVaultService = keyVaultService;
            _powerBIService = powerBIService;
            _azureDataLakeService = azureDataLakeService;
        }

        [FunctionName("RunFrameworkTasksHttpTrigger")]
        public async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)] HttpRequest req, ILogger log,
            ExecutionContext context, System.Security.Claims.ClaimsPrincipal principal)
        {
            this.HeartBeatFolder = context.FunctionAppDirectory;
            //log.LogWarning("Principal is in role?: " + principal.IsInRole("FunctionAPICaller"));
            bool isAuthorised = await _sap.IsAuthorised(req, log);
            if (isAuthorised)
            {
                Guid executionId = context.InvocationId;
                FrameworkRunner fr = new FrameworkRunner(log, executionId);

                FrameworkRunnerWorkerWithHttpRequest worker = RunFrameworkTasksCore;
                FrameworkRunnerResult result = await fr.Invoke(req, "RunFrameworkTasksHttpTrigger", worker);
                if (result.Succeeded)
                {
                    return new OkObjectResult(JObject.Parse(result.ReturnObject));
                }
                else
                {
                    return new BadRequestObjectResult(new { Error = "Execution Failed...." });
                }
            }
            else
            {
                log.LogWarning("User is not authorised to call RunFrameworkTasksHttpTrigger.");
                short taskRunnerId = Convert.ToInt16(req.Query["TaskRunnerId"]);
                await _taskMetaDataDatabase.ExecuteSql($"exec [dbo].[UpdFrameworkTaskRunner] {taskRunnerId}");
                return new BadRequestObjectResult(new { Error = "User is not authorised to call this API...." });
            }
        }


        public async Task<dynamic> RunFrameworkTasksCore(HttpRequest req, Logging.Logging logging)
        {
            short taskRunnerId = Convert.ToInt16(req.Query["TaskRunnerId"]);
            return await RunFrameworkTasksCore(taskRunnerId, logging);
        }
        
        /// <summary>
        /// This is the core function for processing the list of tasks assigned to a particular TaskRunnerId. 
        /// The function performs the following steps 
        ///     - Deletes a "heartbeat" file for the current task runner, which is used to track successful execution of the task runner
        ///     - Inserting a new execution record into the task metadata database
        ///     - Fetching a list of tasks to be executed by the current task runner
        ///     - Iterating through the list of tasks, and for each task:
        ///         a. Updating the task instance status to "Untried" if the task failed to execute
        ///         b. Logging that the ADF pipeline is being executed for the task instance
        ///         c. If the "GenerateTaskObjectTestFiles" testing option is enabled, generating test files for the task
        ///         d. Otherwise, executing the task based on the task execution type (ADF or AF) and the appropriate execution engine (Datafactory or Synapse).
        ///  
        ///     If the task execution type is AF then the TriggerAzureFunction method is called to trigger an Azure function based on the pipeline name, passing in the task as a parameter.
        /// </summary>
        /// <param name="taskRunnerId"></param>
        /// <param name="logging"></param>
        /// <returns></returns>
        public async Task<dynamic> RunFrameworkTasksCore(Int16 taskRunnerId, Logging.Logging logging)
        {            
            try
            {
                //Delete the runner heartbeat file -- this is here so that we can track successful HTTP trigger execution without the parent caller actually having to wait for a response
                DirectoryInfo folder = Directory.CreateDirectory(Path.Combine(this.HeartBeatFolder, "runners"));
                var files = folder.GetFiles();
                foreach (var f in files.Where(f => f.Name.StartsWith($"hb_{taskRunnerId.ToString()}_")))
                {
                    f.Delete();
                }


                await _taskMetaDataDatabase.ExecuteSql($"Insert into Execution values ('{logging.DefaultActivityLogItem.ExecutionUid}', '{DateTimeOffset.Now:u}', '{DateTimeOffset.Now.AddYears(999):u}')");

                //Fetch Top # tasks
                JArray tasks = await GetTaskInstancesForTaskRunner(logging.DefaultActivityLogItem.ExecutionUid.Value, taskRunnerId,  logging);

                var utcCurDay = DateTime.UtcNow.ToString("yyyyMMdd");
                foreach (var jsonTask in tasks)
                {
                    var task = (JObject)jsonTask;
                    long taskInstanceId = Convert.ToInt64(JsonHelpers.GetDynamicValueFromJson(logging, "TaskInstanceId", task, null, true));
                    logging.DefaultActivityLogItem.TaskInstanceId = taskInstanceId;

                    //TO DO: Update TaskInstance yto UnTried if failed
                    string pipelineName = task["ExecutionEngine"]["ADFPipeline"].ToString();
                    var pipelineParams =  new Dictionary<string, object>();

                    logging.LogInformation($"Executing ADF Pipeline for TaskInstanceId {taskInstanceId} ");

                    if (_options.Value.TestingOptions.GenerateTaskObjectTestFiles)
                    {
                        await GenerateTaskObjectTestFiles(logging, task, pipelineName, taskInstanceId);
                    }
                    else
                    {
                        try
                        {
                            if (task["TaskExecutionType"].ToString() == "ADF")
                            {
                                //The "SystemType" is used for calling the appropriate execution engine to manage the pipeline as required. This is to future proof any future execution engines that microsoft may add. Allows for expansion and contraction as required.
                                switch (task["ExecutionEngine"]["SystemType"].ToString())
                                {
                                    case "Datafactory":
                                        await RunAzureDataFactoryPipeline(logging, pipelineName, pipelineParams, task);
                                        break;
                                    case "Synapse":
                                        await RunSynapsePipeline(logging, pipelineName, pipelineParams, task);
                                        break;
                                }
                            }
                            else if (task["TaskExecutionType"].ToString() == "AF")
                            {
                                //The "AF" branch is for calling Azure Function Based Tasks that do not require ADF. Calls are made async (just like the ADF calls) and calls are made using "AsyncHttp" requests even though at present the "AF" based Tasks reside in the same function app. This is to "future proof" as it is expected that these AF based tasks will be moved out to a separate function app in the future. 
                                switch (pipelineName)
                                {
                                    case "AZ-Storage-SAS-Uri-SMTP-Email":
                                        TriggerAzureFunction("GetSASUriSendEmailHttpTrigger", task);
                                        break;
                                    case "AZ-Storage-Cache-File-List":
                                        TriggerAzureFunction("AZStorageCacheFileListHttpTrigger", task);
                                        break;
                                    case "StartAndStopVMs":
                                        TriggerAzureFunction(pipelineName, task);
                                        break;
                                    case "Cache-File-List-To-Email-Alert":
                                        await SendAlert(task, logging);
                                        break;
                                    default:
                                        var msg = $"Could not find execution path for Task Type of {pipelineName} and Execution Type of {task["TaskExecutionType"]}";
                                        logging.LogErrors(new Exception(msg));
                                        await _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId, logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, msg);
                                        break;
                                }
                                //To Do // Batch to make less "chatty"
                                //To Do // Upgrade to stored procedure call
                            }
                            else if (task["TaskExecutionType"].ToString() == "DLL")
                            {

                                await RunDLLTask(logging, pipelineName, task);
                            }   
                            
                        }
                        catch (Exception taskException)
                        {
                            logging.LogErrors(taskException);
                            await _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId, logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty,"Runner failed to execute task.");
                        }

                    }
                }
            }
            catch (Exception runnerException)
            {
                //Set Runner back to Idle
                await _taskMetaDataDatabase.ExecuteSql($"exec [dbo].[UpdFrameworkTaskRunner] {taskRunnerId}");
                logging.LogErrors(runnerException);
                //log and re-throw the error
                throw;
            }

            //Set Runner back to Idle
            await _taskMetaDataDatabase.ExecuteSql($"exec [dbo].[UpdFrameworkTaskRunner] {taskRunnerId}");

            //Return success
            JObject root = new JObject
            {
                ["Succeeded"] = true
            };

            return root;

        }

        private async Task RunAzureDataFactoryPipeline(Logging.Logging logging, string pipelineName, Dictionary<string, object> pipelineParams, JObject task)
        {
            pipelineParams.Add("TaskObject", task);

            if (!string.IsNullOrEmpty(pipelineName))
            {
                var subscriptionId = task["ExecutionEngine"]["SubscriptionId"].ToString();
                var resourceGroup = task["ExecutionEngine"]["ResourceGroup"].ToString();
                var factoryName = task["ExecutionEngine"]["EngineName"].ToString();
               
                //Create a data factory management client
                logging.LogInformation("Creating ADF connectivity client.");

                using var client = await _dataFactoryClientFactory.CreateDataFactoryClient(subscriptionId).ConfigureAwait(false);
                //Run pipeline
                CreateRunResponse runResponse;

                if (pipelineParams?.Count == 0)
                {
                    logging.LogInformation("Called pipeline without parameters.");

                    var result = await client.Pipelines.CreateRunWithHttpMessagesAsync(resourceGroup, factoryName, pipelineName);
                    runResponse = result.Body;
                }
                else
                {
                    logging.LogInformation("Called pipeline with parameters.");
                    logging.LogInformation("Number of parameters provided: " + pipelineParams.Count);

                    System.Threading.Thread.Sleep(1000);

                    var result = await client.Pipelines.CreateRunWithHttpMessagesAsync(resourceGroup, factoryName, pipelineName, parameters: pipelineParams);
                    runResponse = result.Body;
                }

                logging.LogInformation("Pipeline run ID: " + runResponse.RunId);

                logging.DefaultActivityLogItem.AdfRunUid = Guid.Parse(runResponse.RunId);
                using var con = await _taskMetaDataDatabase.GetSqlConnection();
                await con.ExecuteAsync(SqlInsertTaskInstanceExecution, new
                {
                    ExecutionUid = logging.DefaultActivityLogItem.ExecutionUid.ToString(),
                    TaskInstanceId = Convert.ToInt64(task["TaskInstanceId"]),
                    //DatafactorySubscriptionUid = task["ExecutionEngine"]["SubscriptionId"].ToString(),
                    //DatafactoryResourceGroup = task["ExecutionEngine"]["ResourceGroup"].ToString(),
                    EngineID = Convert.ToInt64(task["ExecutionEngine"]["EngineId"]),
                    PipelineName = pipelineName,
                    AdfRunUid = Guid.Parse(runResponse.RunId),
                    StartDateTime = DateTimeOffset.UtcNow,
                    Status = "InProgress",
                    Comment = ""
                }).ConfigureAwait(true);
            }
            //To Do // Batch to make less "chatty"
            //To Do // Upgrade to stored procedure call
        }


        private async Task RunSynapsePipeline(Logging.Logging logging, string pipelineName, Dictionary<string, object> pipelineParams, JObject task)
        {
            //change to a string object
            pipelineParams.Add("TaskObject", task);

            if (!string.IsNullOrEmpty(pipelineName))
            {
                //var subscriptionId = task["ExecutionEngine"]["SubscriptionId"].ToString();
                //var resourceGroup = task["ExecutionEngine"]["ResourceGroup"].ToString();
                //var factoryName = task["ExecutionEngine"]["EngineName"].ToString();
                var engineJson = task["ExecutionEngine"]["EngineJson"].ToString();
                JObject json = JObject.Parse(engineJson);
                string data = json["endpoint"].ToString();
                Uri endpoint = new Uri(data); 

                logging.LogInformation("Setting up Synapse Pipeline Object.");
                string runId;

                logging.LogInformation("Called pipeline with parameters.");
                logging.LogInformation("Number of parameters provided: " + pipelineParams.Count);

                System.Threading.Thread.Sleep(1000);

                string response = await _azureSynapseService.RunSynapsePipeline(endpoint, pipelineName, pipelineParams, logging);                
                //add error handling before checking runid
                
                runId = JObject.Parse(response)["runId"].ToString();

                logging.LogInformation("Pipeline run ID: " + runId);
                logging.LogInformation("Execution UID: " + logging.DefaultActivityLogItem.ExecutionUid.ToString());

                logging.DefaultActivityLogItem.AdfRunUid = Guid.Parse(runId);

                using var con = await _taskMetaDataDatabase.GetSqlConnection();
                await con.ExecuteAsync(SqlInsertTaskInstanceExecution, new
                {
                    ExecutionUid = Guid.Parse(logging.DefaultActivityLogItem.ExecutionUid.ToString()),
                    TaskInstanceId = Convert.ToInt64(task["TaskInstanceId"]),
                    EngineID = Convert.ToInt64(task["ExecutionEngine"]["EngineId"]),
                    PipelineName = pipelineName,
                    AdfRunUid = Guid.Parse(runId),
                    StartDateTime = DateTimeOffset.UtcNow,
                    Status = "InProgress",
                    Comment = ""
                }).ConfigureAwait(false);                
            }
            //To Do // Batch to make less "chatty"
            //To Do // Upgrade to stored procedure call
        }

        private async Task RunDLLTask(Logging.Logging logging, string pipelineName, JObject task)
        {
            var taskInstanceId = Convert.ToInt64(task["TaskInstanceId"]);
            var taskMasterId = Convert.ToInt64(task["TaskMasterId"]);

            using var con = await _taskMetaDataDatabase.GetSqlConnection();
            await con.ExecuteAsync(SqlInsertTaskInstanceExecution, new
            {
                ExecutionUid = Guid.Parse(logging.DefaultActivityLogItem.ExecutionUid.ToString()),
                TaskInstanceId = taskInstanceId,
                EngineID = Convert.ToInt64(task["ExecutionEngine"]["EngineId"]),
                PipelineName = pipelineName,
                AdfRunUid = Guid.Parse(logging.DefaultActivityLogItem.ExecutionUid.ToString()),
                StartDateTime = DateTimeOffset.UtcNow,
                Status = "InProgress",
                Comment = ""
            }).ConfigureAwait(false);

            var completeCheck = true;
            switch (true)
            {

                //We want to check whether the pipelineName matches, however it can include several different IR's as subsequent value on the pipeline name. Regex allows to ignore the end of the string for the checking.
                case bool _ when Regex.IsMatch(pipelineName, @"Synapse_SQLPool_Start_Stop.*"):
                    var subscriptionId = task["ExecutionEngine"]["SubscriptionId"].ToString();
                    var resourceGroup = task["ExecutionEngine"]["ResourceGroup"].ToString();
                    var synapseWorkspaceName = task["Target"]["System"]["Workspace"].ToString();
                    var synapseSQLPoolName = task["TMOptionals"]["SQLPoolName"].ToString();
                    var poolOperation = task["TMOptionals"]["SQLPoolOperation"].ToString();
                    await _azureSynapseService.StartStopSynapseSqlPool(subscriptionId, resourceGroup, synapseWorkspaceName, synapseSQLPoolName, poolOperation, logging);
                    break;
                case bool _ when Regex.IsMatch(pipelineName, @"Synpase_Stop_Idle_Spark_Sessions.*"):
                    string SparkPoolName = JObject.Parse(task["ExecutionEngine"]["EngineJson"].ToString())["DefaultSparkPoolName"].ToString();
                    string Endpoint = JObject.Parse(task["ExecutionEngine"]["EngineJson"].ToString())["endpoint"].ToString();
                    string JobName = $"TaskInstance_{task["TaskInstanceId"].ToString()}";
                    await _azureSynapseService.StopIdleSessions(new Uri(Endpoint), SparkPoolName, logging, task);
                    break;
                case bool _ when Regex.IsMatch(pipelineName, @"Execute_VM_Command_VM.*"):
                    var storageAccountName = JObject.Parse(task["ExecutionEngine"]["EngineJson"].ToString())["StorageAccountName"].ToString();
                    var containerName = task["Target"]["Type"].ToString();
                    var executionUid = (logging.DefaultActivityLogItem.ExecutionUid.ToString());
                    var executionCommand = task["Target"]["ExecutionCommand"].ToString();
                    var executionParameters = task["Target"]["ExecutionParameters"].ToString();
                    var executionPath = task["TMOptionals"]["ExecutionPath"].ToString();
                    var keyVaultUrl = JObject.Parse(task["ExecutionEngine"]["EngineJson"].ToString())["KeyVaultURL"].ToString();
                    await _azureDataLakeService.InjectInput(storageAccountName,containerName,executionUid,taskMasterId, taskInstanceId, executionCommand,executionParameters,executionPath, keyVaultUrl,logging);
                    // setting to false as our completion check is done after output has been found from vm execution
                    completeCheck = false;
                    break;
                default:
                    var msg = $"Could not find execution path for Task Type of {pipelineName} and Execution Type of {task["TaskExecutionType"]}";
                    logging.LogErrors(new Exception(msg));
                    await _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId, logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, msg);
                    completeCheck = false;
                    break;
            }
            if (completeCheck)
            {
                var completemsg = $"Sucessfully completed {pipelineName} and Execution Type of {task["TaskExecutionType"]}";
                await _taskMetaDataDatabase.LogTaskInstanceCompletion(System.Convert.ToInt64(taskInstanceId), logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.Complete, System.Guid.Empty, completemsg);
            }

            //To Do // Batch to make less "chatty"
            //To Do // Upgrade to stored procedure call
        }

        private async Task GenerateTaskObjectTestFiles(Logging.Logging logging, JObject task, string pipelineName, long taskInstanceId)
        {
            string fileFullPath = $"{_options.Value.TestingOptions.TaskObjectTestFileLocation}/";
            // Determine whether the directory exists.
            if (!System.IO.Directory.Exists(fileFullPath))
            {
                // Try to create the directory.
                System.IO.DirectoryInfo di = System.IO.Directory.CreateDirectory(fileFullPath);
            }

            fileFullPath = $"{fileFullPath}{task["TaskType"]}_{pipelineName}_{task["TaskMasterId"]}.json";
            System.IO.File.WriteAllText(fileFullPath, task.ToString());
            await _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId,
                logging.DefaultActivityLogItem.ExecutionUid.Value,
                TaskInstance.TaskStatus.Complete, Guid.Empty, "Complete");
        }

        private void TriggerAzureFunction(string functionName, JObject task)
        {
            using (var client = new HttpClient())
            {
                //Lets get an access token based on MSI or Service Principal                                            
                var accessToken = GetSecureFunctionToken();

                using HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                {
                    Method = HttpMethod.Post,
                    RequestUri = new Uri($"{_options.Value.ServiceConnections.CoreFunctionsURL}/api/{functionName}"),
                    Content = new StringContent(task.ToString(), System.Text.Encoding.UTF8,
                        "application/json"),
                    Headers =
                    {
                        {
                            System.Net.HttpRequestHeader.Authorization.ToString(),
                            $"Bearer {accessToken}"
                        }
                    }
                };

                //Todo Add some error handling in case function cannot be reached. Note Wait time is there to provide sufficient time to complete post before the HttpClientFactory is disposed.
                var httpTask = client.SendAsync(httpRequestMessage).Wait(3000);
            }
        }
        

        private async Task<string> GetSecureFunctionToken()
        {
            string ret = "";
            string secureFunctionApiUrl = _options.Value.ServiceConnections.CoreFunctionsURL;
            if (!secureFunctionApiUrl.Contains("localhost"))
            {
                ret = await _authProvider.GetAzureRestApiToken(secureFunctionApiUrl).ConfigureAwait(false);
            }

            return ret;
        }

        public async Task<JArray> GetTaskInstancesForTaskRunner(Guid ExecutionUid, short TaskRunnerId, Logging.Logging logging)
        {
            SqlConnection con = await _taskMetaDataDatabase.GetSqlConnection();
            //Get All Task Instance Objects for the current Framework Task Runner
            IEnumerable<GetTaskInstanceJsonResult> taskInstances = con.Query<GetTaskInstanceJsonResult>($"Exec [dbo].[GetTaskInstanceJSON] {TaskRunnerId}, '{ExecutionUid}'");
            JArray isJson = new JArray();

            //Instantiate the Collections that contain the JSON Schemas (These are used to populate valid TaskObject json to send to ADF
            var ttMappingProvider = new TaskTypeMappingProvider(_taskMetaDataDatabase);
            SourceAndTargetSystemJsonSchemasProvider systemSchemas = new SourceAndTargetSystemJsonSchemasProvider(_taskMetaDataDatabase);

            EngineJsonSchemasProvider engineSchemas = new EngineJsonSchemasProvider(_taskMetaDataDatabase);


            //Set up table to Store Invalid Task Instance Objects
            using DataTable invalidTIs = new DataTable();
            invalidTIs.Columns.Add("ExecutionUid", typeof(Guid));
            invalidTIs.Columns.Add("TaskInstanceId", typeof(Int64));
            invalidTIs.Columns.Add("LastExecutionComment", typeof(String));

            foreach (GetTaskInstanceJsonResult taskInstanceJson in taskInstances)
            {
                try
                {
                    //Add Task Ids to Logging Object
                    logging.DefaultActivityLogItem.TaskInstanceId = taskInstanceJson.TaskInstanceId;
                    logging.DefaultActivityLogItem.TaskMasterId = taskInstanceJson.TaskMasterId;

                    AdfJsonBaseTask T =  new AdfJsonBaseTask(taskInstanceJson, logging, _options);
                    //Set the base properties using data stored in non-json columns of the database
                    T.CreateJsonObjectForAdf(ExecutionUid);
                    JObject root = await T.ProcessRoot(ttMappingProvider, systemSchemas, engineSchemas);

                    if (T.TaskIsValid)
                    {
                        isJson.Add(root);
                    }
                    else
                    {
                        DataRow dr = invalidTIs.NewRow();
                        dr["TaskInstanceId"] = T.TaskInstanceId;
                        dr["ExecutionUid"] = ExecutionUid;
                        dr["LastExecutionComment"] = "Task structure is invalid. Check activity level logs for details.";
                        invalidTIs.Rows.Add(dr);
                    }
                }

                catch (Exception e)
                {
                    logging.LogErrors(e);
                    //ToDo: Convert to bulk insert                    
                    await _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceJson.TaskInstanceId, ExecutionUid, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, "Uncaught error building Task Instance JSON object.");
                    DataRow dr = invalidTIs.NewRow();
                    dr["TaskInstanceId"] = taskInstanceJson.TaskInstanceId;
                    dr["ExecutionUid"] = ExecutionUid;
                    dr["LastExecutionComment"] = "Task structure is invalid. Check activity level logs for details.";
                    invalidTIs.Rows.Add(dr);

                }
            } // End For Each

            //
            foreach (DataRow dr in invalidTIs.Rows)
            {
                //ToDo: Convert to bulk insert    
                await _taskMetaDataDatabase.LogTaskInstanceCompletion(Convert.ToInt64(dr["TaskInstanceId"]), ExecutionUid,
                    TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, dr["LastExecutionComment"].ToString());
            }

            return isJson;
        }

        private async Task SendAlert(JObject task, Logging.Logging logging)
        {
            try
            {
                if ((JObject)task["Target"] != null)
                {
                    if ((JArray)task["Target"]["Alerts"] != null)
                    {
                        foreach (JObject alert in (JArray)task["Target"]["Alerts"])
                        {
                            //Only Send out for Operator Level Alerts
                            //if (Alert["AlertCategory"].ToString() == "Task Specific Operator Alert")
                            {
                                //Get Plain Text and Email Subject from Template Files 
                                Dictionary<string, string> @params =
                                    new Dictionary<string, string>();
                                @params.Add("Source.RelativePath", task["Source"]["RelativePath"].ToString());
                                @params.Add("Source.DataFileName", task["Source"]["DataFileName"].ToString());
                                @params.Add("Alert.EmailRecepientName", alert["EmailRecepientName"].ToString());

                                string plainTextContent = System.IO.File.ReadAllText(
                                    System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(),
                                        _options.Value.LocalPaths.HTMLTemplateLocation,
                                        alert["EmailTemplateFileName"].ToString() + ".txt"));
                                plainTextContent = plainTextContent.FormatWith(@params,
                                    MissingKeyBehaviour.ThrowException, null, '{', '}');

                                string htmlContent = System.IO.File.ReadAllText(
                                    System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(),
                                        _options.Value.LocalPaths.HTMLTemplateLocation,
                                        alert["EmailTemplateFileName"].ToString() + ".html"));
                                htmlContent = htmlContent.FormatWith(@params, MissingKeyBehaviour.ThrowException, null,
                                    '{', '}');

                                var apiKey = Environment.GetEnvironmentVariable("SendGridApiKey");
                                var client = new SendGridClient(apiKey);
                                var msg = new SendGridMessage()
                                {
                                    From = new EmailAddress(task["Target"]["SenderEmail"].ToString(),
                                        task["Target"]["SenderDescription"].ToString()),
                                    Subject = alert["EmailSubject"].ToString(),
                                    PlainTextContent = plainTextContent,
                                    HtmlContent = htmlContent
                                };
                                msg.AddTo(new EmailAddress(alert["EmailRecepient"].ToString(),
                                    alert["EmailRecepientName"].ToString()));
                                var res = await client.SendEmailAsync(msg);
                            }
                        }
                    }

                    await _taskMetaDataDatabase.LogTaskInstanceCompletion(Convert.ToInt64(task["TaskInstanceId"]),
                        Guid.Parse(task["ExecutionUid"].ToString()), TaskInstance.TaskStatus.Complete,
                        Guid.Empty, "");
                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                await _taskMetaDataDatabase.LogTaskInstanceCompletion(Convert.ToInt64(task["TaskInstanceId"]),
                    Guid.Parse(task["ExecutionUid"].ToString()), TaskInstance.TaskStatus.FailedNoRetry,
                    Guid.Empty, "Failed to send email");
            }




        }


        private static void MarkTaskAsInvalid(Logging.Logging logging, Int64 TargetSystemId, Guid ExecutionId, string comment,
            ref bool TaskIsValid)
        {
            Dictionary<string, string> p = new Dictionary<string, string>
            {
                { "TargetSystemId", TargetSystemId.ToString() },
                { "ExecutionId", ExecutionId.ToString() }
            };

            comment = comment.FormatWith(p);
            logging.LogErrors(new Exception(comment));
            TaskIsValid = false;
        }


    }
}