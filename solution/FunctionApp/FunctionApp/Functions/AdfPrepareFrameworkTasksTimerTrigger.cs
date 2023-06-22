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
    public class AdfPrepareFrameworkTasksTimerTrigger
    {
        private readonly IOptions<ApplicationOptions> _appOptions;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly DataFactoryPipelineProvider _dataFactoryPipelineProvider;
        private readonly TaskTypeMappingProvider _taskTypeMappingProvider;
        private readonly IntegrationRuntimeMappingProvider _integrationRuntimeMappingProvider;
        private readonly IHttpClientFactory _httpClientFactory;    

        public string HeartBeatFolder { get; set; }
        public ILogger Log { get; set; }


        public AdfPrepareFrameworkTasksTimerTrigger(IOptions<ApplicationOptions> appOptions, TaskMetaDataDatabase taskMetaDataDatabase, DataFactoryPipelineProvider dataFactoryPipelineProvider, TaskTypeMappingProvider taskTypeMappingProvider, IHttpClientFactory httpClientFactory, IntegrationRuntimeMappingProvider integrationRuntimeMappingProvider)
        {
            _appOptions = appOptions;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _dataFactoryPipelineProvider = dataFactoryPipelineProvider;
            _taskTypeMappingProvider = taskTypeMappingProvider;
            _httpClientFactory = httpClientFactory;
            _integrationRuntimeMappingProvider = integrationRuntimeMappingProvider;            
        }

        [FunctionName("PrepareFrameworkTasksTimerTrigger")]
        public async Task Run([TimerTrigger("0 */2 * * * *")] TimerInfo myTimer, ILogger log, ExecutionContext context)
        {
            Guid executionId = context.InvocationId;
            this.HeartBeatFolder = context.FunctionAppDirectory;
            this.Log = log;
            if (_appOptions.Value.TimerTriggers.EnablePrepareFrameworkTasks)
            {
                FrameworkRunner fr = new FrameworkRunner(log, executionId);
                FrameworkRunnerWorker worker = PrepareFrameworkTasksCore;
                await fr.Invoke("PrepareFrameworkTasksHttpTrigger", worker);
            }
        }

        public async Task<dynamic> PrepareFrameworkTasksCore(Logging.Logging logging)
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
       
        private async Task CreateScheduleAndTaskInstances(Logging.Logging logging)
        {
            logging.LogInformation("Create ScheduleInstance called.");
            DateTimeOffset date = DateTimeOffset.Now;

            // Generate the upcoming Schedule Instance for each of the schedule master records
            using var con = await _taskMetaDataDatabase.GetSqlConnection();
            using var dtScheduleInstance = new DataTable();
            dtScheduleInstance.Columns.Add(new DataColumn("ScheduleMasterId", typeof(long)));
            dtScheduleInstance.Columns.Add(new DataColumn("ScheduledDateUtc", typeof(DateTime)));
            dtScheduleInstance.Columns.Add(new DataColumn("ScheduledDateTimeOffset", typeof(DateTimeOffset)));
            dtScheduleInstance.Columns.Add(new DataColumn("ActiveYN", typeof(bool)));

            dynamic resScheduleInstance = con.QueryWithRetry(@"
                Select 
	                SM.ScheduleMasterId, 
	                SM.ScheduleCronExpression, 
	                Coalesce(SI.MaxScheduledDateTimeOffset,dateadd(minute, -1, sysdatetimeoffset())) as MaxScheduledDateTimeOffset
                from
                    ScheduleMaster SM 
	                join ( 
	                Select distinct ScheduleMasterId from TaskMaster TM where TM.ActiveYN = 1) TM on TM.ScheduleMasterId = SM.ScheduleMasterId
	                left outer join
                    (
		                Select ScheduleMasterId, Max(ScheduledDateTimeOffset) MaxScheduledDateTimeOffset
		                From ScheduleInstance
		                Where ActiveYN = 1
		                Group By ScheduleMasterId
                    ) SI on SM.ScheduleMasterId = SI.ScheduleMasterId
                Where SM.ActiveYN = 1");

            foreach (dynamic row in resScheduleInstance)
            {
                DateTimeOffset? nextUtc;
                if (row.ScheduleCronExpression.ToString() == "N/A")
                {
                    nextUtc = DateTimeOffset.Now.AddMinutes(-1); 
                }
                else
                {
                    CronExpression cronExpression = CronExpression.Parse(row.ScheduleCronExpression.ToString(), CronFormat.IncludeSeconds);
                    
                    nextUtc = cronExpression.GetNextOccurrence(row.MaxScheduledDateTimeOffset, TimeZoneInfo.Utc);
                    
                }
                
                if (nextUtc?.DateTime <= date)
                {
                    DateTimeOffset SetDate = nextUtc ?? date;

                    DataRow dr = dtScheduleInstance.NewRow();

                    dr["ScheduleMasterId"] = row.ScheduleMasterId;
                    dr["ScheduledDateUtc"] = SetDate.Date;
                    dr["ScheduledDateTimeOffset"] = SetDate;
                    dr["ActiveYN"] = true;

                    dtScheduleInstance.Rows.Add(dr);
                }
            }

            //Persist TEMP ScheduleInstance
            SqlTable tmpScheduleInstanceTargetSqlTable = new SqlTable
            {
                Name = "#Temp" + Guid.NewGuid().ToString()
            };
            TaskMetaDataDatabase.BulkInsert(dtScheduleInstance, tmpScheduleInstanceTargetSqlTable, true, con);

            //Create TaskInstance 
            logging.LogInformation("Create TaskInstance called.");

            using var dtTaskInstance = new DataTable();
            dtTaskInstance.Columns.Add(new DataColumn("ExecutionUid", typeof(Guid)));
            dtTaskInstance.Columns.Add(new DataColumn("TaskMasterId", typeof(long)));
            dtTaskInstance.Columns.Add(new DataColumn("ScheduleInstanceId", typeof(long)));
            dtTaskInstance.Columns.Add(new DataColumn("ADFPipeline", typeof(string)));
            dtTaskInstance.Columns.Add(new DataColumn("TaskInstanceJson", typeof(string)));
            dtTaskInstance.Columns.Add(new DataColumn("LastExecutionStatus", typeof(string)));
            dtTaskInstance.Columns.Add(new DataColumn("ActiveYN", typeof(bool)));

            // Get a list of task masters that need Task Instance records created
            dynamic taskMasters = con.QueryWithRetry(@"Exec dbo.GetTaskMaster");
            // Get a list of Active task type mappings
            var taskTypeMappings = await _taskTypeMappingProvider.GetAllActive();
            var integrationRuntimeMappings = await _integrationRuntimeMappingProvider.GetAllActive();
            foreach (dynamic row in taskMasters)
            {
                DataRow drTaskInstance = dtTaskInstance.NewRow();
                logging.DefaultActivityLogItem.TaskInstanceId = row.TaskInstanceId;
                logging.DefaultActivityLogItem.TaskMasterId = row.TaskMasterId;
                var instanceGenerationErrorMessage = "";
                try
               {
                    dynamic taskMasterJson = JsonConvert.DeserializeObject(row.TaskMasterJSON);
                    string sourceSystemId = row.SourceSystemId.ToString();
                    string sourceSystem = row.SourceSystemType.ToString();
                    string targetSystem = row.TargetSystemType.ToString();
                    string targetSystemId = row.TargetSystemId.ToString();
                    string sourceType = taskMasterJson?.Source.Type.ToString();
                    string targetType = taskMasterJson?.Target.Type.ToString();
                    string integrationRuntime = row.TaskDatafactoryIR.ToString();
                    string taskExecutionType = row.TaskExecutionType.ToString();
                    Int64 taskTypeId = row.TaskTypeId;

                    //Check whether our Source / IR mapping is valid
                    //If invalid we throw an error
                    IntegrationRuntimeMappingProvider.CheckValidTaskMasterMapping(integrationRuntimeMappings, sourceSystemId, targetSystemId, integrationRuntime);


                    // Determine the pipeline that we need to call 
                    var adfPipeline = TaskTypeMappingProvider.LookupMappingForTaskMaster(taskTypeMappings,
                        sourceSystem,
                        targetSystem,
                        sourceType, 
                        targetType,
                        taskTypeId,
                        taskExecutionType);
                    
                    drTaskInstance["TaskMasterId"] = row.TaskMasterId ?? DBNull.Value;
                    drTaskInstance["ScheduleInstanceId"] = 0;//_row.ScheduleInstanceId == null ? DBNull.Value : _row.ScheduleInstanceId;
                    drTaskInstance["ExecutionUid"] = logging.DefaultActivityLogItem.ExecutionUid;
                    drTaskInstance["ADFPipeline"] = $"{adfPipeline.MappingName}_{integrationRuntime}";
                    drTaskInstance["LastExecutionStatus"] = "Untried";
                    drTaskInstance["ActiveYN"] = true;

                    // Perform some transformations on the task master Json to support parameterisable Json templates
                    JObject root = new JObject();
                    if (row.SourceSystemType == "ADLS" || row.SourceSystemType == "Azure Blob" || row.SourceSystemType == "FileServer")
                    {
                        if (taskMasterJson?.Source.Type.ToString() != "Filelist")
                        {
                            root["SourceRelativePath"] = TransformRelativePath(JObject.Parse(row.TaskMasterJSON)["Source"]["RelativePath"].ToString(), date.DateTime);
                        }
                    }

                    if (row.TargetSystemType == "ADLS" || row.TargetSystemType == "Azure Blob" || row.TargetSystemType == "FileServer")
                    {
                        if (JObject.Parse(row.TaskMasterJSON)["Target"]["RelativePath"] != null)
                        {
                            root["TargetRelativePath"] = TransformRelativePath(JObject.Parse(row.TaskMasterJSON)["Target"]["RelativePath"].ToString(), date.DateTime);
                        }
                    }

                    if (JObject.Parse(row.TaskMasterJSON)["Source"]["IncrementalType"] == "Watermark")
                    {
                        root["IncrementalField"] = row.TaskMasterWaterMarkColumn;
                        root["IncrementalColumnType"] = row.TaskMasterWaterMarkColumnType;
                        if (row.TaskMasterWaterMarkColumnType == "DateTime")
                        {
                            root["IncrementalValue"] = row.TaskMasterWaterMark_DateTime ?? "1900-01-01";
                        }
                        else if (row.TaskMasterWaterMarkColumnType == "BigInt")
                        {
                            root["IncrementalValue"] = row.TaskMasterWaterMark_BigInt ?? -1;
                        }
                        else if (row.TaskMasterWaterMarkColumnType == "lsn")
                        {
                            root["IncrementalValue"] = row.TaskMasterWaterMark_String ?? "NO_WATERMARK_STRING";
                        }
                        if ((root["IncrementalField"] == null) || (string.IsNullOrEmpty(root["IncrementalField"].ToString())))
                        {
                            instanceGenerationErrorMessage +=
                                $"TaskMasterId '{logging.DefaultActivityLogItem.TaskInstanceId}' has an IncrementalType of Watermark but does not have any entry in the TaskWatermark table. ";
                        }
                    }

                   //here 

                    if (root == null)
                    {
                        drTaskInstance["TaskInstanceJson"] = DBNull.Value;
                    }
                    else
                    {
                        drTaskInstance["TaskInstanceJson"] = root;
                    }

                    if (string.IsNullOrEmpty(instanceGenerationErrorMessage))
                    {
                        dtTaskInstance.Rows.Add(drTaskInstance);
                    }
                    else
                    {
                        throw new Exception(instanceGenerationErrorMessage);
                    }
                }
                catch (Exception e)
                {
                    logging.LogErrors(new Exception(
                        $"Failed to create new task instances for TaskMasterId '{logging.DefaultActivityLogItem.TaskInstanceId}'."));
                    logging.LogErrors(e);
                }
            }

            //Persist TMP TaskInstance
            SqlTable tmpTaskInstanceTargetSqlTable = new SqlTable
            {
                Name = "#Temp" + Guid.NewGuid().ToString()
            };
            TaskMetaDataDatabase.BulkInsert(dtTaskInstance, tmpTaskInstanceTargetSqlTable, true, con);

            Dictionary<string, string> sqlParams = new Dictionary<string, string>
            {
                { "tmpScheduleInstance", tmpScheduleInstanceTargetSqlTable.QuotedSchemaAndName() },
                { "tmpTaskInstance", tmpTaskInstanceTargetSqlTable.QuotedSchemaAndName() }
            };
            // Save the Schedule and Task Instances
            string insertSql = GenerateSqlStatementTemplates.GetSql(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(), _appOptions.Value.LocalPaths.SQLTemplateLocation), "InsertScheduleInstance_TaskInstance", sqlParams);
            con.ExecuteWithRetry(insertSql);
            con.Close();
        }

        //TODO: Move this to a data access layer
        public async Task<List<TaskGroup>> GetActiveTaskGroups()
        {
            using var con = await _taskMetaDataDatabase.GetSqlConnection();
            List<TaskGroup> res = con.QueryWithRetry<TaskGroup>("Exec dbo.GetTaskGroups").ToList();
            return res;
        }

        public async Task<short> CountRunnningPipelines(Logging.Logging logging)
        {
            return await _dataFactoryPipelineProvider.CountActivePipelines(logging);
        }


        /// <summary>
        /// Checks for long running pipelines and updates their status in the database
        /// </summary>
        /// <param name="logging"></param>
        /// <returns></returns>
        public async Task<short> CheckLongRunningPipelines(Logging.Logging logging)
        {
            dynamic activePipelines = await _dataFactoryPipelineProvider.GetLongRunningPipelines(logging);

            short runningPipelines = 0;
            using var dt = new DataTable();
            dt.Columns.Add(new DataColumn("TaskInstanceId", typeof(string)));
            dt.Columns.Add(new DataColumn("ExecutionUid", typeof(Guid)));
            dt.Columns.Add(new DataColumn("PipelineName", typeof(string)));
            dt.Columns.Add(new DataColumn("EngineSubscriptionUid", typeof(Guid)));
            dt.Columns.Add(new DataColumn("EngineResourceGroup", typeof(string)));
            dt.Columns.Add(new DataColumn("EngineName", typeof(string)));
            dt.Columns.Add(new DataColumn("RunUid", typeof(Guid)));
            dt.Columns.Add(new DataColumn("Status", typeof(string)));
            dt.Columns.Add(new DataColumn("SimpleStatus", typeof(string)));

            //Check Each Running Pipeline
            foreach (dynamic pipeline in activePipelines)
            {
                var pipelineStatus = await _dataFactoryPipelineProvider.CheckPipelineStatus(pipeline.EngineSubscriptionUid.ToString(), pipeline.EngineResourceGroup.ToString(), pipeline.EngineName.ToString(), pipeline.PipelineName.ToString(), pipeline.AdfRunUid.ToString(), logging);

                if (pipelineStatus["SimpleStatus"].ToString() == "Runnning")
                {
                    runningPipelines += 1;
                }
                
                DataRow dr = dt.NewRow();

                dr["TaskInstanceId"] = pipeline.TaskInstanceId;
                dr["ExecutionUid"] = pipeline.ExecutionUid;
                dr["EngineSubscriptionUid"] = pipeline.EngineSubscriptionUid;
                dr["EngineResourceGroup"] = pipeline.EngineResourceGroup;
                dr["EngineName"] = pipeline.EngineName;

                dr["Status"] = pipelineStatus["Status"];
                dr["SimpleStatus"] = pipelineStatus["SimpleStatus"];
                dr["RunUid"] = (Guid)pipelineStatus["RunId"];
                dr["PipelineName"] = pipelineStatus["PipelineName"];
                dt.Rows.Add(dr);

            }

            string tempTableName = $"#Temp{Guid.NewGuid()}";
            //Todo: Update both the TaskInstanceExecution and the TaskInstance;
            await _taskMetaDataDatabase.AutoBulkInsertAndMerge(dt, tempTableName, "TaskInstanceExecution");

            return runningPipelines;
        }



        public static string TransformRelativePath(string RelativePath, DateTime ExecutionDateTime)
        {
            //Replace YYYY
            string relativePath = RelativePath.Replace("{yyyy}", ExecutionDateTime.Year.ToString());

            //Replace MMM
            relativePath = relativePath.Replace("{MM}", ExecutionDateTime.Month.ToString());

            //Replace DD
            relativePath = relativePath.Replace("{dd}", ExecutionDateTime.Day.ToString());

            //Replace HH
            relativePath = relativePath.Replace("{hh}", ExecutionDateTime.Hour.ToString());

            //Replace HH
            relativePath = relativePath.Replace("{mm}", ExecutionDateTime.Minute.ToString());

            return relativePath;
        }




    }

}







