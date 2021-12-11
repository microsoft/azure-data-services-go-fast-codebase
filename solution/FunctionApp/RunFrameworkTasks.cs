/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
using AdsGoFast.GetTaskInstanceJSON.TaskMasterJson.AZ_SQL_StoredProcedure;
using AdsGoFast.SqlServer;
using AdsGoFast.TaskMetaData;
using Dapper;
using FormatWith;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.Management.ContainerRegistry.Fluent;
using Microsoft.Azure.Management.DataFactory.Models;
using Microsoft.Azure.Management.Storage.Fluent.Models;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json.Linq;
using SendGrid;
using SendGrid.Helpers.Mail;
using System;
using System.Collections;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Http;
using System.Reflection.Metadata.Ecma335;
using System.Security.Claims;
using System.Threading.Tasks;
using AdsGoFast.Services;
using AdsGoFast.Models;
using Microsoft.Extensions.Options;
using AdsGoFast.Models.Options;

namespace AdsGoFast
{

    public class RunFrameworkTasksHttpTrigger
    {
        private readonly ISecurityAccessProvider _sap;
        public RunFrameworkTasksHttpTrigger(ISecurityAccessProvider sap)
        {
            _sap = sap;
        }

        [FunctionName("RunFrameworkTasksHttpTrigger")]
        public  async Task<IActionResult> Run([HttpTrigger(AuthorizationLevel.Anonymous, "get", Route = null)] HttpRequest req, ILogger log, ExecutionContext context, System.Security.Claims.ClaimsPrincipal principal)
        {
            bool IsAuthorised = _sap.IsAuthorised(req, log);
            if (IsAuthorised)
            {
                Guid ExecutionId = context.InvocationId;
                using FrameworkRunner FR = new FrameworkRunner(log, ExecutionId);

                FrameworkRunner.FrameworkRunnerWorkerWithHttpRequest worker = RunFrameworkTasks.RunFrameworkTasksCore;
                FrameworkRunner.FrameworkRunnerResult result = FR.Invoke(req, "RunFrameworkTasksHttpTrigger", worker);
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
                TaskMetaDataDatabase TMD = new TaskMetaDataDatabase();
                short TaskRunnerId = System.Convert.ToInt16(req.Query["TaskRunnerId"]);
                TMD.ExecuteSql(string.Format("exec [dbo].[UpdFrameworkTaskRunner] {0}", TaskRunnerId));
                return new BadRequestObjectResult(new { Error = "User is not authorised to call this API...." });
            }
        }
    }

    public  class RunFrameworkTasksTimerTrigger
    {
        private readonly ICoreFunctionsContext _functionscontext;

        private readonly IOptions<ApplicationOptions> _appOptions;
        public RunFrameworkTasksTimerTrigger(ICoreFunctionsContext functionsContext, IOptions<ApplicationOptions> appOptions)
        {
            _functionscontext = functionsContext;
            _appOptions = appOptions;
        }

        /// <summary>
        /// 
        /// 
        ///             "0 */5 * * * *" once every five minutes
        ///              "0 0 * * * *"   once at the top of every hour
        ///              "0 0 */2 * * *" once every two hours
        ///              "0 0 9-17 * * *"    once every hour from 9 AM to 5 PM
        ///              "0 30 9 * * *"  at 9:30 AM every day
        ///              "0 30 9 * * 1-5"    at 9:30 AM every weekday
        ///              "0 30 9 * Jan Mon"  at 9:30 AM every Monday in January
        ///
        /// </summary>
        /// <param name="myTimer"></param>
        /// <param name="log"></param>
        [FunctionName("RunFrameworkTasksTimerTrigger")]         
        public  async Task Run([TimerTrigger("0 */2 * * * *")] TimerInfo myTimer, ILogger log, ExecutionContext context)
        {
            log.LogInformation("FunctionAppDirectory:" + context.FunctionAppDirectory);
            if (_appOptions.Value.TimerTriggers.EnableRunFrameworkTasks)
            {
                TaskMetaDataDatabase TMD = new TaskMetaDataDatabase();
                var client = _functionscontext.httpClient.CreateClient(_functionscontext.httpClientName);
                
                    using (SqlConnection _con = TMD.GetSqlConnection())
                    {
                        var ftrs = _con.QueryWithRetry("Exec dbo.GetFrameworkTaskRunners");

                        foreach (var ftr in ftrs)
                        {
                            int TaskRunnerId = ((dynamic)ftr).TaskRunnerId;

                            try
                            {

                                //Lets get an access token based on MSI or Service Principal
                                var secureFunctionAPIURL = string.Format("{0}/api/RunFrameworkTasksHttpTrigger?TaskRunnerId={1}", Shared._ApplicationOptions.ServiceConnections.CoreFunctionsURL, TaskRunnerId.ToString());
                                //var accessToken = Shared.Azure.AzureSDK.GetAzureRestApiToken(Shared.GlobalConfigs.GetStringConfig("AzureFunctionURL"));

                                using HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                                {
                                    Method = HttpMethod.Get,
                                    RequestUri = new Uri(secureFunctionAPIURL)//,
                                    //Headers = { { System.Net.HttpRequestHeader.Authorization.ToString(), "Bearer " + accessToken } }
                                };
                                
                                //Todo Add some error handling in case function cannot be reached. Note Wait time is there to provide sufficient time to complete post before the HttpClient is disposed.
                                var HttpTask = client.SendAsync(httpRequestMessage).Wait(3000);
                            
                        }
                            catch (Exception e)
                            {
                                _con.ExecuteWithRetry($"[dbo].[UpdFrameworkTaskRunner] {TaskRunnerId.ToString()}");
                                throw e;
                            }
                        }
                        
                    }                   
                
            }
            
        }

    }

    public  class RunFrameworkTasks
    {
        public static dynamic RunFrameworkTasksCore(HttpRequest req, Logging logging)
        {

            TaskMetaDataDatabase TMD = new TaskMetaDataDatabase();
            short TaskRunnerId = System.Convert.ToInt16(req.Query["TaskRunnerId"]);
            try
            {
                TMD.ExecuteSql(string.Format("Insert into Execution values ('{0}', '{1}', '{2}')", logging.DefaultActivityLogItem.ExecutionUid, DateTimeOffset.Now.ToString("u"), DateTimeOffset.Now.AddYears(999).ToString("u")));                           

                //Fetch Top # tasks
                JArray _Tasks = AdsGoFast.TaskMetaData.TaskInstancesStatic.GetActive_ADFJSON((Guid)logging.DefaultActivityLogItem.ExecutionUid, TaskRunnerId, logging);

                var UtcCurDay = DateTime.UtcNow.ToString("yyyyMMdd");
                foreach (JObject _Task in _Tasks)
                {

                    long _TaskInstanceId = System.Convert.ToInt64(Shared.JsonHelpers.GetDynamicValueFromJSON(logging, "TaskInstanceId", _Task, null, true));
                    logging.DefaultActivityLogItem.TaskInstanceId = _TaskInstanceId;

                    //TO DO: Update TaskInstance yto UnTried if failed
                    string _pipelinename = _Task["DataFactory"]["ADFPipeline"].ToString();
                    System.Collections.Generic.Dictionary<string, object> _pipelineparams = new System.Collections.Generic.Dictionary<string, object>();

                    logging.LogInformation(string.Format("Executing ADF Pipeline for TaskInstanceId {0} ", _TaskInstanceId.ToString()));
                    //Check Task Type and execute appropriate ADF Pipeline
                    //Todo: Potentially extract switch into metadata

                    if (Shared._ApplicationOptions.TestingOptions.GenerateTaskObjectTestFiles)
                    {
                        string FileFullPath = Shared._ApplicationOptions.TestingOptions.TaskObjectTestFileLocation +  /*UtcCurDay +*/ "/";
                        // Determine whether the directory exists.
                        if (!System.IO.Directory.Exists(FileFullPath))
                        {
                            // Try to create the directory.
                            System.IO.DirectoryInfo di = System.IO.Directory.CreateDirectory(FileFullPath);
                        }

                        FileFullPath = FileFullPath + _Task["TaskType"].ToString() + "_" + _pipelinename.ToString() + "_" +  _Task["TaskMasterId"].ToString() + ".json";
                        System.IO.File.WriteAllText(FileFullPath, _Task.ToString());
                        TMD.LogTaskInstanceCompletion(_TaskInstanceId, (Guid)logging.DefaultActivityLogItem.ExecutionUid, TaskMetaData.BaseTasks.TaskStatus.Complete, System.Guid.Empty, "Complete");
                    }
                    else
                    {
                        try
                        {
                            if (_Task["TaskExecutionType"].ToString() == "ADF")
                            {


                                _pipelinename = "Master_" + _Task["DataFactory"]["TaskDatafactoryIR"].ToString();
                                _pipelineparams.Add("TaskObject", _Task);

                                if (_pipelinename != "")
                                {
                                    JObject _pipelineresult = ExecutePipeline.ExecutePipelineMethod(_Task["DataFactory"]["SubscriptionId"].ToString(), _Task["DataFactory"]["ResourceGroup"].ToString(), _Task["DataFactory"]["Name"].ToString(), _pipelinename, _pipelineparams, logging);
                                    logging.DefaultActivityLogItem.AdfRunUid = Guid.Parse(_pipelineresult["RunId"].ToString());
                                    TMD.GetSqlConnection().Execute(string.Format(@"
                                            INSERT INTO TaskInstanceExecution (
	                                                        [ExecutionUid]
	                                                        ,[TaskInstanceId]
	                                                        ,[DatafactorySubscriptionUid]
	                                                        ,[DatafactoryResourceGroup]
	                                                        ,[DatafactoryName]
	                                                        ,[PipelineName]
	                                                        ,[AdfRunUid]
	                                                        ,[StartDateTime]
	                                                        ,[Status]
	                                                        ,[Comment]
	                                                        )
                                                        VALUES (
	                                                            @ExecutionUid
	                                                        ,@TaskInstanceId
	                                                        ,@DatafactorySubscriptionUid
	                                                        ,@DatafactoryResourceGroup
	                                                        ,@DatafactoryName
	                                                        ,@PipelineName
	                                                        ,@AdfRunUid
	                                                        ,@StartDateTime
	                                                        ,@Status
	                                                        ,@Comment
	                                        )"), new
                                    {
                                        ExecutionUid = logging.DefaultActivityLogItem.ExecutionUid.ToString(),
                                        TaskInstanceId = System.Convert.ToInt64(_Task["TaskInstanceId"]),
                                        DatafactorySubscriptionUid = _Task["DataFactory"]["SubscriptionId"].ToString(),
                                        DatafactoryResourceGroup = _Task["DataFactory"]["ResourceGroup"].ToString(),
                                        DatafactoryName = _Task["DataFactory"]["Name"].ToString(),
                                        PipelineName = _pipelineresult["PipelineName"].ToString(),
                                        AdfRunUid = Guid.Parse(_pipelineresult["RunId"].ToString()),
                                        StartDateTime = DateTimeOffset.UtcNow,
                                        Status = _pipelineresult["Status"].ToString(),
                                        Comment = ""

                                    });


                                }
                                //To Do // Batch to make less "chatty"
                                //To Do // Upgrade to stored procedure call
                            }

                            else if (_Task["TaskExecutionType"].ToString() == "AF")
                            {
                                                          

                                
                                //The "AF" branch is for calling Azure Function Based Tasks that do not require ADF. Calls are made async (just like the ADF calls) and calls are made using "AsyncHttp" requests even though at present the "AF" based Tasks reside in the same function app. This is to "future proof" as it is expected that these AF based tasks will be moved out to a separate function app in the future. 
                                switch (_pipelinename)
                                {
                                    case "AZ-Storage-SAS-Uri-SMTP-Email":
                                        using (var client = new System.Net.Http.HttpClient())
                                        {
                                            //Lets get an access token based on MSI or Service Principal
                                            var secureFunctionAPIURL = string.Format("{0}/api/GetSASUriSendEmailHttpTrigger", Shared._ApplicationOptions.ServiceConnections.CoreFunctionsURL);
                                            var accessToken = Shared._AzureAuthenticationCredentialProvider.GetAzureRestApiToken(secureFunctionAPIURL);

                                            using HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                                            {
                                                Method = HttpMethod.Post,
                                                RequestUri = new Uri(secureFunctionAPIURL),
                                                Content = new StringContent(_Task.ToString(), System.Text.Encoding.UTF8, "application/json"),
                                                Headers = { { System.Net.HttpRequestHeader.Authorization.ToString(), "Bearer " + accessToken } }
                                            };

                                            
                                            //Todo Add some error handling in case function cannot be reached. Note Wait time is there to provide sufficient time to complete post before the HttpClient is disposed.
                                            var HttpTask = client.SendAsync(httpRequestMessage).Wait(3000);

                                        }
                                        break;
                                    case "AZ-Storage-Cache-File-List":
                                        using (var client = new System.Net.Http.HttpClient())
                                        {                                            
                                            
                                            //Lets get an access token based on MSI or Service Principal
                                            var secureFunctionAPIURL = string.Format("{0}/api/AZStorageCacheFileListHttpTrigger", Shared._ApplicationOptions.ServiceConnections.CoreFunctionsURL);
                                            var accessToken = Shared._AzureAuthenticationCredentialProvider.GetAzureRestApiToken(secureFunctionAPIURL);

                                            using HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                                            {
                                                Method = HttpMethod.Post,
                                                RequestUri = new Uri(secureFunctionAPIURL),
                                                Content = new StringContent(_Task.ToString(), System.Text.Encoding.UTF8, "application/json"),
                                                Headers = { { System.Net.HttpRequestHeader.Authorization.ToString(), "Bearer " + accessToken } }
                                            };


                                            //Todo Add some error handling in case function cannot be reached. Note Wait time is there to provide sufficient time to complete post before the HttpClient is disposed.
                                            var HttpTask = client.SendAsync(httpRequestMessage).Wait(3000);

                                        }
                                        break;
                                    case "StartAndStopVMs":
                                        using (var client = new System.Net.Http.HttpClient())
                                        {
                                            //Lets get an access token based on MSI or Service Principal                                            
                                            var accessToken = GetSecureFunctionToken(_pipelinename);

                                            using HttpRequestMessage httpRequestMessage = new HttpRequestMessage
                                            {
                                                Method = HttpMethod.Post,
                                                RequestUri = new Uri(GetSecureFunctionURI(_pipelinename)),
                                                Content = new StringContent(_Task.ToString(), System.Text.Encoding.UTF8, "application/json"),
                                                Headers = { { System.Net.HttpRequestHeader.Authorization.ToString(), "Bearer " + accessToken } }
                                            };

                                            //Todo Add some error handling in case function cannot be reached. Note Wait time is there to provide sufficient time to complete post before the HttpClient is disposed.
                                            var HttpTask = client.SendAsync(httpRequestMessage).Wait(3000);

                                        }
                                        break;
                                    case "Cache-File-List-To-Email-Alert":
                                        using (var client = new System.Net.Http.HttpClient())
                                        {
                                            SendAlert(_Task, logging);
                                        }
                                        break;

                                    default:
                                        var msg = $"Could not find execution path for Task Type of {_pipelinename} and Execution Type of {_Task["TaskExecutionType"].ToString()}";
                                        logging.LogErrors(new Exception(msg));
                                        TMD.LogTaskInstanceCompletion((Int64)_TaskInstanceId, (System.Guid)logging.DefaultActivityLogItem.ExecutionUid, BaseTasks.TaskStatus.FailedNoRetry, Guid.Empty, (String)msg);
                                        break;
                                }
                                //To Do // Batch to make less "chatty"
                                //To Do // Upgrade to stored procedure call

                            }
                        }
                        catch (Exception TaskException)
                        {
                            logging.LogErrors(TaskException);                            
                            TMD.LogTaskInstanceCompletion((Int64)_TaskInstanceId, (System.Guid)logging.DefaultActivityLogItem.ExecutionUid, BaseTasks.TaskStatus.FailedNoRetry, Guid.Empty, (String)"Runner failed to execute task.");  
                        }

                    }
                }
            }
            catch (Exception RunnerException)
            {
                //Set Runner back to Idle
                TMD.ExecuteSql(string.Format("exec [dbo].[UpdFrameworkTaskRunner] {0}", TaskRunnerId));
                logging.LogErrors(RunnerException);
                //log and re-throw the error
                throw RunnerException;
            }
            //Set Runner back to Idle
            TMD.ExecuteSql(string.Format("exec [dbo].[UpdFrameworkTaskRunner] {0}", TaskRunnerId));

            //Return success
            JObject Root = new JObject
            {
                ["Succeeded"] = true
            };
            
            return Root;

        }

        private static string GetSecureFunctionURI(string FunctionName) {
            return string.Format("{0}/api/{1}", Shared._ApplicationOptions.ServiceConnections.CoreFunctionsURL, FunctionName);
        }
        private static string GetSecureFunctionToken(string FunctionName) {
            string ret = "";            
            string secureFunctionAPIURL = Shared._ApplicationOptions.ServiceConnections.CoreFunctionsURL;
            if (!secureFunctionAPIURL.Contains("localhost"))
            { 
                ret = Shared._AzureAuthenticationCredentialProvider.GetAzureRestApiToken(secureFunctionAPIURL); 
            }

            return ret;
        }


        public static void SendAlert(JObject task, Logging logging)
        {
            TaskMetaDataDatabase TMD = new TaskMetaDataDatabase();
            try
            {
                if ((JObject)task["Target"] != null)
                {
                    if ((JArray)task["Target"]["Alerts"] != null)
                    {
                        foreach (JObject Alert in (JArray)task["Target"]["Alerts"])
                        {
                            //Only Send out for Operator Level Alerts
                            //if (Alert["AlertCategory"].ToString() == "Task Specific Operator Alert")
                            {
                                //Get Plain Text and Email Subject from Template Files 
                                System.Collections.Generic.Dictionary<string, string> Params = new System.Collections.Generic.Dictionary<string, string>();
                                Params.Add("Source.RelativePath", task["Source"]["RelativePath"].ToString());
                                Params.Add("Source.DataFileName", task["Source"]["DataFileName"].ToString());
                                Params.Add("Alert.EmailRecepientName", Alert["EmailRecepientName"].ToString());

                                string _plainTextContent = System.IO.File.ReadAllText(System.IO.Path.Combine(Shared._ApplicationBasePath, Shared._ApplicationOptions.LocalPaths.HTMLTemplateLocation,Alert["EmailTemplateFileName"].ToString() + ".txt"));
                                _plainTextContent = _plainTextContent.FormatWith(Params, MissingKeyBehaviour.ThrowException, null, '{', '}');

                                string _htmlContent = System.IO.File.ReadAllText(System.IO.Path.Combine(Shared._ApplicationBasePath, Shared._ApplicationOptions.LocalPaths.HTMLTemplateLocation, Alert["EmailTemplateFileName"].ToString() + ".html"));
                                _htmlContent = _htmlContent.FormatWith(Params, MissingKeyBehaviour.ThrowException, null, '{', '}');

                                var apiKey = System.Environment.GetEnvironmentVariable("SENDGRID_APIKEY");
                                var client = new SendGridClient(apiKey);
                                var msg = new SendGridMessage()
                                {
                                    From = new EmailAddress(task["Target"]["SenderEmail"].ToString(), task["Target"]["SenderDescription"].ToString()),
                                    Subject = Alert["EmailSubject"].ToString(),
                                    PlainTextContent = _plainTextContent,
                                    HtmlContent = _htmlContent
                                };
                                msg.AddTo(new EmailAddress(Alert["EmailRecepient"].ToString(), Alert["EmailRecepientName"].ToString()));
                                var res = client.SendEmailAsync(msg).Result;
                            }
                        }
                    }

                    TMD.LogTaskInstanceCompletion(System.Convert.ToInt64(task["TaskInstanceId"]), Guid.Parse(task["ExecutionUid"].ToString()), TaskMetaData.BaseTasks.TaskStatus.Complete, System.Guid.Empty, "");
                }
            }
            catch (Exception e)
            {
                logging.LogErrors(e);                
                TMD.LogTaskInstanceCompletion(System.Convert.ToInt64(task["TaskInstanceId"]), Guid.Parse(task["ExecutionUid"].ToString()),TaskMetaData.BaseTasks.TaskStatus.FailedNoRetry, System.Guid.Empty, "Failed to send email");
            }

            
            

        }
    }

}







