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


        public AdfRunFrameworkTasksHttpTrigger(ISecurityAccessProvider sap, 
            TaskMetaDataDatabase taskMetaDataDatabase,
            IOptions<ApplicationOptions> options, 
            IAzureAuthenticationProvider authProvider, 
            DataFactoryClientFactory dataFactoryClientFactory,
            AzureSynapseService azureSynapseService)
        {
            _sap = sap;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _options = options;
            _authProvider = authProvider;
            _dataFactoryClientFactory = dataFactoryClientFactory;
            _azureSynapseService = azureSynapseService;
        }

        [FunctionName("RunFrameworkTasksHttpTrigger")]
        public IActionResult Run(
            [HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)] HttpRequest req, ILogger log,
            ExecutionContext context, System.Security.Claims.ClaimsPrincipal principal)
        {
            bool isAuthorised = _sap.IsAuthorised(req, log);
            if (isAuthorised)
            {
                Guid executionId = context.InvocationId;
                FrameworkRunner fr = new FrameworkRunner(log, executionId);

                FrameworkRunnerWorkerWithHttpRequest worker = RunFrameworkTasksCore;
                FrameworkRunnerResult result = fr.Invoke(req, "RunFrameworkTasksHttpTrigger", worker);
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
                _taskMetaDataDatabase.ExecuteSql($"exec [dbo].[UpdFrameworkTaskRunner] {taskRunnerId}");
                return new BadRequestObjectResult(new { Error = "User is not authorised to call this API...." });
            }
        }


        public async Task<dynamic> RunFrameworkTasksCore(HttpRequest req, Logging.Logging logging)
        {
            short taskRunnerId = Convert.ToInt16(req.Query["TaskRunnerId"]);
            return await RunFrameworkTasksCore(taskRunnerId, logging);
        }

        public async Task<dynamic> RunFrameworkTasksCore(Int16 taskRunnerId, Logging.Logging logging)
        {            
            try
            {
                _taskMetaDataDatabase.ExecuteSql($"Insert into Execution values ('{logging.DefaultActivityLogItem.ExecutionUid}', '{DateTimeOffset.Now:u}', '{DateTimeOffset.Now.AddYears(999):u}')");

                //Fetch Top # tasks
                JArray tasks = GetTaskInstancesForTaskRunner(logging.DefaultActivityLogItem.ExecutionUid.Value, taskRunnerId,  logging);

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
                        GenerateTaskObjectTestFiles(logging, task, pipelineName, taskInstanceId);
                    }
                    else
                    {
                        try
                        {
                            if (task["TaskExecutionType"].ToString() == "ADF")
                            {
                                //The "SystemType" is used for calling the appropriate execution engine to manage the pipeline as required. This is to future proof any future execution engines that microsoft may add. Allows for expansion and contraction as required.
                                switch(task["ExecutionEngine"]["SystemType"].ToString())
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
                                        SendAlert(task, logging);
                                        break;
                                    default:
                                        var msg = $"Could not find execution path for Task Type of {pipelineName} and Execution Type of {task["TaskExecutionType"]}";
                                        logging.LogErrors(new Exception(msg));
                                        _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId, logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, msg);
                                        break;
                                }
                                //To Do // Batch to make less "chatty"
                                //To Do // Upgrade to stored procedure call
                            }
                            else if (task["TaskExecutionType"].ToString() == "DLL")
                            {
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
                                    default:
                                        var msg = $"Could not find execution path for Task Type of {pipelineName} and Execution Type of {task["TaskExecutionType"]}";
                                        logging.LogErrors(new Exception(msg));
                                        _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId, logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, msg);
                                        completeCheck = false;
                                        break;
                                }
                                if (completeCheck)
                                {
                                    var completemsg = $"Sucessfully completed {pipelineName} and Execution Type of {task["TaskExecutionType"]}";
                                    _taskMetaDataDatabase.LogTaskInstanceCompletion(System.Convert.ToInt64(taskInstanceId), logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.Complete, System.Guid.Empty, completemsg);
                                }
                            }
                        }
                        catch (Exception taskException)
                        {
                            logging.LogErrors(taskException);
                            _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId, logging.DefaultActivityLogItem.ExecutionUid.Value, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty,"Runner failed to execute task.");
                        }

                    }
                }
            }
            catch (Exception runnerException)
            {
                //Set Runner back to Idle
                _taskMetaDataDatabase.ExecuteSql($"exec [dbo].[UpdFrameworkTaskRunner] {taskRunnerId}");
                logging.LogErrors(runnerException);
                //log and re-throw the error
                throw;
            }

            //Set Runner back to Idle
            _taskMetaDataDatabase.ExecuteSql($"exec [dbo].[UpdFrameworkTaskRunner] {taskRunnerId}");

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
                await using var con = _taskMetaDataDatabase.GetSqlConnection();
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

                var response = await _azureSynapseService.RunSynapsePipeline(endpoint, pipelineName, pipelineParams, logging);
                var content = response.ReadAsStringAsync().Result;
                runId = JObject.Parse(content.ToString())["runId"].ToString();

                logging.LogInformation("Pipeline run ID: " + runId);
                logging.LogInformation("Execution UID: " + logging.DefaultActivityLogItem.ExecutionUid.ToString());

                logging.DefaultActivityLogItem.AdfRunUid = Guid.Parse(runId);

                await using var con = _taskMetaDataDatabase.GetSqlConnection();
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
                logging.LogInformation("Test");
            }
            //To Do // Batch to make less "chatty"
            //To Do // Upgrade to stored procedure call
        } 

        private void GenerateTaskObjectTestFiles(Logging.Logging logging, JObject task, string pipelineName, long taskInstanceId)
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
            _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceId,
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

        public JArray GetTaskInstancesForTaskRunner(Guid ExecutionUid, short TaskRunnerId, Logging.Logging logging)
        {
            //Get All Task Instance Objects for the current Framework Task Runner
            IEnumerable<GetTaskInstanceJsonResult> taskInstances = _taskMetaDataDatabase.GetSqlConnection()
                .Query<GetTaskInstanceJsonResult>($"Exec [dbo].[GetTaskInstanceJSON] {TaskRunnerId}, '{ExecutionUid}'");
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

                    AdfJsonBaseTask T =  new AdfJsonBaseTask(taskInstanceJson, logging);
                    //Set the base properties using data stored in non-json columns of the database
                    T.CreateJsonObjectForAdf(ExecutionUid);
                    var root = T.ProcessRoot(ttMappingProvider, systemSchemas, engineSchemas);

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
                    _taskMetaDataDatabase.LogTaskInstanceCompletion(taskInstanceJson.TaskInstanceId, ExecutionUid, TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, "Uncaught error building Task Instance JSON object.");
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
                _taskMetaDataDatabase.LogTaskInstanceCompletion(Convert.ToInt64(dr["TaskInstanceId"]), ExecutionUid,
                    TaskInstance.TaskStatus.FailedNoRetry, Guid.Empty, dr["LastExecutionComment"].ToString());
            }

            return isJson;
        }

        private void SendAlert(JObject task, Logging.Logging logging)
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
                                var res = client.SendEmailAsync(msg).Result;
                            }
                        }
                    }

                    _taskMetaDataDatabase.LogTaskInstanceCompletion(Convert.ToInt64(task["TaskInstanceId"]),
                        Guid.Parse(task["ExecutionUid"].ToString()), TaskInstance.TaskStatus.Complete,
                        Guid.Empty, "");
                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);
                _taskMetaDataDatabase.LogTaskInstanceCompletion(Convert.ToInt64(task["TaskInstanceId"]),
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