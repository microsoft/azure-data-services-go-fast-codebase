/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using FunctionApp.Helpers;
using FunctionApp.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;

namespace FunctionApp.Services
{
    public delegate dynamic FrameworkRunnerWorker(Logging.Logging LogHelper1);

    public delegate dynamic FrameworkRunnerWorkerWithHttpRequest(HttpRequest req, Logging.Logging LogHelper);

    public class FrameworkRunner
    {
        private Logging.Logging LogHelper { get; set; }

        public FrameworkRunner(ILogger log, Guid executionUid)
        {
            LogHelper = new Logging.Logging();
            var activityLogItem = new ActivityLogItem
            {
                LogSource = "AF",
                ExecutionUid = executionUid
            };
            LogHelper.InitializeLog(log, activityLogItem);

        }

        public FrameworkRunnerResult Invoke(string CallingMethodName, FrameworkRunnerWorker WorkerFunction)
        {
            FrameworkRunnerResult r = FrameworkRunnerCore(null, CallingMethodName, WorkerFunction, null);
            return r;
        }

        public FrameworkRunnerResult Invoke(HttpRequest req, string CallingMethodName, FrameworkRunnerWorkerWithHttpRequest WorkerFunction)
        {
            FrameworkRunnerResult r = FrameworkRunnerCore(req, CallingMethodName, null, WorkerFunction);
            return r;

        }

        private FrameworkRunnerResult FrameworkRunnerCore(HttpRequest req, string CallingMethodName, FrameworkRunnerWorker WorkerFunction, FrameworkRunnerWorkerWithHttpRequest WorkerFunctionWithHttp)
        {
            LogHelper.DefaultActivityLogItem.StartDateTimeOffset = DateTimeOffset.UtcNow;
            LogHelper.DefaultActivityLogItem.EndDateTimeOffset = DateTimeOffset.UtcNow;
            FrameworkRunnerResult r = new FrameworkRunnerResult();
            LogHelper.DefaultActivityLogItem.ActivityType = CallingMethodName;

            if (req != null)
            {
                if (req.Body != null)
                {
                    req.EnableBuffering();

                    // Leave the body open so the next middleware can read it.
                    using System.IO.StreamReader reader = new System.IO.StreamReader(req.Body, encoding: System.Text.Encoding.UTF8, detectEncodingFromByteOrderMarks: false, leaveOpen: true);
                    string requestBody = reader.ReadToEndAsync().Result;
                    // Reset the request body stream position so the next middleware can read it
                    req.Body.Position = 0;
                    if (requestBody.Length > 0)
                    {
                        dynamic data = JsonConvert.DeserializeObject(requestBody);

                        LogHelper.DefaultActivityLogItem.TaskInstanceId = Convert.ToInt64(JsonHelpers.GetDynamicValueFromJson(LogHelper, "TaskInstanceId", data, null, false));

                        LogHelper.DefaultActivityLogItem.AdfRunUid = Guid.Parse(JsonHelpers.GetDynamicValueFromJson(LogHelper, "AdfRunUid", data, "00000000-0000-0000-0000-000000000000", false));

                        if (LogHelper.DefaultActivityLogItem.AdfRunUid == Guid.Parse("00000000-0000-0000-0000-000000000000"))
                        {
                            LogHelper.DefaultActivityLogItem.AdfRunUid = Guid.Parse(JsonHelpers.GetDynamicValueFromJson(LogHelper, "RunId", data, "00000000-0000-0000-0000-000000000000", false));
                        }

                        LogHelper.DefaultActivityLogItem.ExecutionUid = Guid.Parse(JsonHelpers.GetDynamicValueFromJson(LogHelper, "ExecutionUid", data, "00000000-0000-0000-0000-000000000000", false));


                    }

                }
            }

            LogHelper.LogInformation($"Azure Function '{CallingMethodName}' started.");
            try
            {
                if (WorkerFunctionWithHttp == null)
                {
                    dynamic result = WorkerFunction.Invoke(LogHelper);
                    if (result.GetType().FullName.Contains("Task"))
                    {
                        r.ReturnObject = JsonConvert.SerializeObject(result.Result).ToString();
                    }
                    else
                    {
                        r.ReturnObject = JsonConvert.SerializeObject(result).ToString();
                    }
                }
                else
                {
                    dynamic result = WorkerFunctionWithHttp.Invoke(req, LogHelper);
                    if (result.GetType().FullName.Contains("Task"))
                    {
                        r.ReturnObject = JsonConvert.SerializeObject(result.Result).ToString();
                    }
                    else
                    {
                        r.ReturnObject = JsonConvert.SerializeObject(result).ToString();
                    }
                }
                LogHelper.LogInformation($"Azure Function '{CallingMethodName}' finished.");
                EndProcessAndPersistLog(CallingMethodName);
                r.Succeeded = true;
                return r;

            }
            catch (Exception e)
            {
                LogHelper.LogErrors(new Exception($"Azure Function '{CallingMethodName}' finished with Errors."));
                LogHelper.LogErrors(e);
                EndProcessAndPersistLog(CallingMethodName);
                r.Succeeded = false;
                r.ReturnObject = JsonConvert.SerializeObject(new { }).ToString();
                return r;
            }

        }

        public void EndProcessAndPersistLog(string CallingMethodName)
        {
            LogHelper.DefaultActivityLogItem.EndDateTimeOffset = DateTimeOffset.UtcNow;
            TimeSpan duration = LogHelper.DefaultActivityLogItem.EndDateTimeOffset - LogHelper.DefaultActivityLogItem.StartDateTimeOffset;
            LogHelper.LogPerformance(
                $"Azure Function '{CallingMethodName}' - Execution Time: {duration.TotalSeconds.ToString()} seconds.");

        }
    }
}
