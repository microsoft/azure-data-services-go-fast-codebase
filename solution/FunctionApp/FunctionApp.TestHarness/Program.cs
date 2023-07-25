using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Reflection;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Linq;
using Dapper;
using FunctionApp.Authentication;
using FunctionApp.DataAccess;
using FunctionApp.Models;
using FunctionApp.Models.GetTaskInstanceJSON;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Microsoft.AspNetCore.Http;
using System.Net.Http;
using Microsoft.ApplicationInsights.Extensibility;
using Microsoft.ApplicationInsights;
using System.Security.Cryptography;
using Azure;
using Azure.Communication.Email;

namespace FunctionApp.TestHarness
{
    public class Program
    {        

        static async Task Main(string[] args)
        {
            IServiceCollection services = new ServiceCollection();

            var config = new ConfigurationBuilder()
                .AddJsonFile("appsettings.json", optional: false, reloadOnChange: true)
                .AddUserSecrets(Assembly.GetExecutingAssembly(), true)
                .AddEnvironmentVariables()
                .Build();

            Startup.ConfigureServices(services, config);
            services.AddTransient<App>();

            services.AddLogging(builder => builder.AddConsole().AddFilter(level => level >= LogLevel.Information));
            //services.AddApplicationInsightsTelemetry(config["APPINSIGHTS_INSTRUMENTATIONKEY"]);
            //services.AddSingleton(provider =>
            //{                                               
            //        var newConfig = new TelemetryConfiguration(config["APPINSIGHTS_INSTRUMENTATIONKEY"]);
            //        return newConfig;             
            //});
            //services.AddApplicationInsightsTelemetry(config["APPINSIGHTS_INSTRUMENTATIONKEY"]);
            using ServiceProvider serviceProvider = services.BuildServiceProvider();
            var app = serviceProvider.GetService<App>();
            await app.Run();            
        }
        
    }

    public class App
    {
        private readonly ILogger<App> _logger;
        private readonly TaskTypeMappingProvider _taskTypeMappingProvider;
        private readonly IntegrationRuntimeMappingProvider _integrationRuntimeMappingProvider;
        private readonly SourceAndTargetSystemJsonSchemasProvider _schemasProvider;
        private readonly IOptions<ApplicationOptions> _options;
        private readonly IAzureAuthenticationProvider _authProvider;
        private readonly MicrosoftAzureServicesAppAuthenticationProvider _microsoftAzureServicesAppAuthenticationProvider;
        private Logging.Logging _funcAppLogger = new Logging.Logging();
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly DataFactoryPipelineProvider _dataFactoryPipelineProvider;
        private readonly DataFactoryClientFactory _dataFactoryClientFactory;
        private readonly ISecurityAccessProvider _sap;
        private readonly AzureSynapseService _azureSynapseService;
        private readonly PurviewService _purviewService;
        private readonly IHttpClientFactory _httpClientFactory;
        private readonly KeyVaultService _keyVaultService;
        private readonly PowerBIService _powerBIService;
        private readonly AzureDataLakeService _azureDataLakeService;
        //private readonly TelemetryClient _telemetryClient;
        //private readonly TelemetryConfiguration _telemetryConfiguration;

        public App(ILogger<App> logger,
            TaskTypeMappingProvider taskTypeMappingProvider,
            IntegrationRuntimeMappingProvider integrationRuntimeMappingProvider,
            SourceAndTargetSystemJsonSchemasProvider schemasProvider,
            IOptions<ApplicationOptions> options,
            IAzureAuthenticationProvider authProvider,
            MicrosoftAzureServicesAppAuthenticationProvider microsoftAzureServicesAppAuthenticationProvider,
            TaskMetaDataDatabase taskMetaDataDatabase,
            DataFactoryPipelineProvider dataFactoryPipelineProvider,
            DataFactoryClientFactory dataFactoryClientFactory,
            ISecurityAccessProvider sap,
            AzureSynapseService azureSynapseService,
            PurviewService purviewService,
            IHttpClientFactory httpClientFactory,
            KeyVaultService keyVaultService,
            PowerBIService powerBIService,
            AzureDataLakeService azureDataLakeService
            //TelemetryConfiguration telemetryConfiguration
            )
        {
            _logger = logger;
            _taskTypeMappingProvider = taskTypeMappingProvider;
            _integrationRuntimeMappingProvider = integrationRuntimeMappingProvider;
            _schemasProvider = schemasProvider;
            _options = options;
            _authProvider = authProvider;
            _microsoftAzureServicesAppAuthenticationProvider = microsoftAzureServicesAppAuthenticationProvider;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _dataFactoryPipelineProvider = dataFactoryPipelineProvider;
            _dataFactoryClientFactory = dataFactoryClientFactory;
            _sap = sap;
            _azureSynapseService = azureSynapseService;
            _purviewService = purviewService;
            _httpClientFactory = httpClientFactory;
            _keyVaultService = keyVaultService;
            _powerBIService = powerBIService;
            _azureDataLakeService = azureDataLakeService;
           // _telemetryConfiguration = telemetryConfiguration;
           // _telemetryClient = new TelemetryClient(telemetryConfiguration);
        }

        public async Task Run()
        {
            var executionId = Guid.NewGuid();            
            ActivityLogItem activityLogItem = new ActivityLogItem
            {
                LogSource = "AF",
                ExecutionUid = executionId
            };
            _funcAppLogger.InitializeLog(_logger, activityLogItem);

            //await DebugStopSynapseSessions();
            //Test_TaskExecutionSchemaFile(_funcAppLogger);
            //GenerateUnitTestResults();

            //_azureSynapseService.StartStopSynapseSqlPool("14f299e1-be54-43e9-bf5e-696840f86fc4", "dlzdev01", "arkstgsynwadsbcar", "TestPool", "Stop", _funcAppLogger).ConfigureAwait(true);
            //InsertTestTasksIntoDb();
            //Test_GetSourceTargetMapping(_funcAppLogger);
            //Test_GetSQLCreateStatementFromSchema(_funcAppLogger);
            //DebugPrepareFrameworkTasks();
            //_purviewService.TestPurview("adsgfpv", "get", ".purview.azure.com", "/account/collections", "2019-11-01-preview", _funcAppLogger);
            //var body = JObject.Parse(File.ReadAllText("PurviewSample_Entities.json"));
            //JObject res = JObject.Parse(_purviewService.ExecuteRequest(PurviewAccountName, "post", ".catalog.purview.azure.com", "/api/atlas/v2/entity", "2021-07-01", body, _funcAppLogger).Result);
            //PurviewCreateEntitiesTest();
            //await DebugPrepareFrameworkTasks();            
            //Functions.AdfRunFrameworkTasksTimerTrigger a = new Functions.AdfRunFrameworkTasksTimerTrigger(_options, _taskMetaDataDatabase, _httpClientFactory );
            //await a.Core(_logger);
            //await DebugRunFrameworkTasksTimerTrigger();

            //await DebugPrepareFrameworkTasks();            

            //await DebugRunFrameworkTasks();
            //int test = activeTasks.Count;
            //await PurviewCreateEntitiesTest();
            //DebugSynapsePipeline();
            //await DebugStartSynapseSessions();
            //Functions.AdfGetActivityErrorsTimerTrigger a = new Functions.AdfGetActivityErrorsTimerTrigger(_options, _taskMetaDataDatabase, _httpClientFactory);
            //await a.GetAdfActivityErrors(_funcAppLogger);

            //Functions.AdfGetPipelineRunsTimerTrigger a = new Functions.AdfGetPipelineRunsTimerTrigger(_options, _taskMetaDataDatabase, _httpClientFactory);
            //await a.GetAdfPipelineRuns(_funcAppLogger);
            //var con = await _taskMetaDataDatabase.GetSqlConnection();
            //this._taskMetaDataDatabase.GenerateMergeSql("dbo", "Stg_Customer-10","dbo", "Customer-10",con,false, _funcAppLogger);

            //var body = JObject.Parse("{\"SourceHttpPath\": \"https://datalakeraw/arkstgdlsadsirudadsl.dfs.core.windows.net/samples/SalesLT.Customer.chunk_1.parquet\", \"TargetHttpPath\": \"https://datalakelanding/arkstgdlsadsirudadsl.dfs.core.windows.net/TesstDelta\", \"SourceColumns\": [{\"name\": \"CustomerID\", \"type\": \"int\"}, {\"name\": \"NameStyle\", \"type\": \"boolean\"}, {\"name\": \"Title\", \"type\": \"string\"}, {\"name\": \"FirstName\", \"type\": \"string\"}, {\"name\": \"MiddleName\", \"type\": \"string\"}, {\"name\": \"LastName\", \"type\": \"string\"}, {\"name\": \"Suffix\", \"type\": \"string\"}, {\"name\": \"CompanyName\", \"type\": \"string\"}, {\"name\": \"SalesPerson\", \"type\": \"string\"}, {\"name\": \"EmailAddress\", \"type\": \"string\"}, {\"name\": \"Phone\", \"type\": \"string\"}, {\"name\": \"PasswordHash\", \"type\": \"string\"}, {\"name\": \"PasswordSalt\", \"type\": \"string\"}, {\"name\": \"rowguid\", \"type\": \"string\"}, {\"name\": \"ModifiedDate\", \"type\": \"timestamp\"}], \"TargetColumns\": [{\"name\": \"CustomerID\", \"type\": \"int\"}, {\"name\": \"NameStyle\", \"type\": \"boolean\"}, {\"name\": \"Title\", \"type\": \"string\"}, {\"name\": \"FirstName\", \"type\": \"string\"}, {\"name\": \"MiddleName\", \"type\": \"string\"}, {\"name\": \"LastName\", \"type\": \"string\"}, {\"name\": \"Suffix\", \"type\": \"string\"}, {\"name\": \"CompanyName\", \"type\": \"string\"}, {\"name\": \"SalesPerson\", \"type\": \"string\"}, {\"name\": \"EmailAddress\", \"type\": \"string\"}, {\"name\": \"Phone\", \"type\": \"string\"}, {\"name\": \"PasswordHash\", \"type\": \"string\"}, {\"name\": \"PasswordSalt\", \"type\": \"string\"}, {\"name\": \"rowguid\", \"type\": \"string\"}, {\"name\": \"ModifiedDate\", \"type\": \"timestamp\"}], \"TaskObject\": {\"TaskInstanceId\": 5, \"TaskMasterId\": 4, \"TaskStatus\": \"InProgress\", \"TaskType\": \"Azure Storage to Azure Storage\", \"Enabled\": 1, \"ExecutionUid\": \"6b9769c0-cfd0-462a-aeda-c75b842f56db\", \"NumberOfRetries\": 0, \"DegreeOfCopyParallelism\": 1, \"KeyVaultBaseUrl\": \"https://ark-stg-kv-ads-irud.vault.azure.net/\", \"ScheduleMasterId\": \"-4\", \"TaskGroupConcurrency\": \"10\", \"TaskGroupPriority\": 0, \"TaskExecutionType\": \"ADF\", \"ExecutionEngine\": {\"EngineId\": -2, \"EngineName\": \"arkstgsynwadsirud\", \"SystemType\": \"Synapse\", \"ResourceGroup\": \"dlzdev04\", \"SubscriptionId\": \"ed1206e0-17c7-4bc2-ad4b-f8d4dab9284f\", \"ADFPipeline\": \"GPL_SparkNotebookExecution_Azure\", \"EngineJson\": \"{\\r\\n             \\\"endpoint\\\": \\\"https://arkstgsynwadsirud.dev.azuresynapse.net\\\", \\\"DeltaProcessingNotebook\\\": \\\"DeltaProcessingNotebook\\\", \\\"PurviewAccountNameName\\\": \\\"dlzdev04purv\\\"\\r\\n        }\", \"TaskDatafactoryIR\": \"Azure\", \"JsonProperties\": {\"endpoint\": \"https://arkstgsynwadsirud.dev.azuresynapse.net\", \"DeltaProcessingNotebook\": \"DeltaProcessingNotebook\", \"PurviewAccountNameName\": \"dlzdev04purv\"}}, \"Source\": {\"System\": {\"SystemId\": -4, \"SystemServer\": \"https://arkstgdlsadsirudadsl.dfs.core.windows.net\", \"AuthenticationType\": \"MSI\", \"Type\": \"ADLS\", \"Username\": null, \"Container\": \"datalakeraw\"}, \"Instance\": {\"SourceRelativePath\": \"samples/\", \"TargetRelativePath\": \"\"}, \"DataFileName\": \"yooyoyo.parquet\", \"MaxConcurrentConnections\": 100, \"RelativePath\": \"samples/\", \"SchemaFileName\": \"SalesLT.Customer.json\", \"Type\": \"Parquet\", \"WriteSchemaToPurview\": \"Enabled\"}, \"Target\": {\"System\": {\"SystemId\": -8, \"SystemServer\": \"https://arkstgdlsadsirudadsl.dfs.core.windows.net\", \"AuthenticationType\": \"MSI\", \"Type\": \"ADLS\", \"Username\": null, \"Container\": \"datalakelanding\"}, \"Instance\": {\"SourceRelativePath\": \"samples/\", \"TargetRelativePath\": \"\"}, \"DataFileName\": \"Iwork\", \"MaxConcurrentConnections\": 100, \"RelativePath\": \"\", \"SchemaFileName\": \"\", \"Type\": \"Delta\", \"WriteSchemaToPurview\": \"Enabled\"}, \"TMOptionals\": {\"Purview\": \"Enabled\", \"QualifiedIDAssociation\": \"TaskMasterID\"}}}");
            //var test = await _powerBIService.RefreshDataflow("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "testSecret", "", "refreshTest", "ea6e65c7-8840-425b-a957-8c72609ac812", "https://ark-stg-kv-ads-aqye.vault.azure.net/", _funcAppLogger);
            //var test2 = await _powerBIService.CheckDataflowRefreshStatus("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "testSecret", "", "refreshTest", "ea6e65c7-8840-425b-a957-8c72609ac812", "https://ark-stg-kv-ads-aqye.vault.azure.net/", test, _funcAppLogger);
            //var test2 = await _powerBIService.CheckDataflowRefreshStatus("xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", "testSecret", "", "TaskMasterDF", "ea6e65c7-8840-425b-a957-8c72609ac812", "https://ark-stg-kv-ads-aqye.vault.azure.net/", "bla", _funcAppLogger);
            //await _azureDataLakeService.InjectInput("adsuatdlsadszjhsadsl", "dbt", "1001", "1", "2", "Command String", "/home/adminuser", _funcAppLogger);
            //await _azureDataLakeService.DetectOutput("adsuatdlsadszjhsadsl", "dbt", "1001", _funcAppLogger);



            //var body = JObject.Parse("{\"SourceHttpPath\": \"https://datalakeraw/arkstgdlsadsv6ciadsl.dfs.core.windows.net/samples/SalesLT.CustomerCDCPart2.parquet\", \"TargetHttpPath\": \"https://datalakelanding/arkstgdlsadsv6ciadsl.dfs.core.windows.net/CustomerCDCDeltaTest\", \"SourceColumns\": [{\"name\": \"__$start_lsn\", \"type\": \"binary\"}, {\"name\": \"__$seqval\", \"type\": \"binary\"}, {\"name\": \"__$operation\", \"type\": \"int\"}, {\"name\": \"__$update_mask\", \"type\": \"binary\"}, {\"name\": \"CustomerID\", \"type\": \"int\"}, {\"name\": \"NameStyle\", \"type\": \"boolean\"}, {\"name\": \"Title\", \"type\": \"string\"}, {\"name\": \"FirstName\", \"type\": \"string\"}, {\"name\": \"MiddleName\", \"type\": \"string\"}, {\"name\": \"LastName\", \"type\": \"string\"}, {\"name\": \"Suffix\", \"type\": \"string\"}, {\"name\": \"CompanyName\", \"type\": \"string\"}, {\"name\": \"SalesPerson\", \"type\": \"string\"}, {\"name\": \"EmailAddress\", \"type\": \"string\"}, {\"name\": \"Phone\", \"type\": \"string\"}, {\"name\": \"PasswordHash\", \"type\": \"string\"}, {\"name\": \"PasswordSalt\", \"type\": \"string\"}, {\"name\": \"rowguid\", \"type\": \"string\"}, {\"name\": \"ModifiedDate\", \"type\": \"timestamp\"}], \"TargetColumns\": [{\"name\": \"CustomerID\", \"type\": \"bigint\"}, {\"name\": \"NameStyle\", \"type\": \"boolean\"}, {\"name\": \"Title\", \"type\": \"string\"}, {\"name\": \"FirstName\", \"type\": \"string\"}, {\"name\": \"MiddleName\", \"type\": \"string\"}, {\"name\": \"LastName\", \"type\": \"string\"}, {\"name\": \"Suffix\", \"type\": \"string\"}, {\"name\": \"CompanyName\", \"type\": \"string\"}, {\"name\": \"SalesPerson\", \"type\": \"string\"}, {\"name\": \"EmailAddress\", \"type\": \"string\"}, {\"name\": \"Phone\", \"type\": \"string\"}, {\"name\": \"PasswordHash\", \"type\": \"string\"}, {\"name\": \"PasswordSalt\", \"type\": \"string\"}, {\"name\": \"rowguid\", \"type\": \"string\"}, {\"name\": \"ModifiedDate\", \"type\": \"timestamp\"}], \"TaskObject\": {\"TaskInstanceId\": 9, \"TaskMasterId\": 6, \"TaskStatus\": \"InProgress\", \"TaskType\": \"Azure Storage to Azure Storage\", \"Enabled\": 1, \"ExecutionUid\": \"13659322-9e3d-4083-9f44-87e695d06ed8\", \"NumberOfRetries\": 1, \"DegreeOfCopyParallelism\": 1, \"KeyVaultBaseUrl\": \"https://ark-stg-kv-ads-v6ci.vault.azure.net/\", \"ScheduleMasterId\": \"-4\", \"TaskGroupConcurrency\": \"10\", \"TaskGroupPriority\": 0, \"TaskExecutionType\": \"ADF\", \"ExecutionEngine\": {\"EngineId\": -2, \"EngineName\": \"arkstgsynwadsv6ci\", \"SystemType\": \"Synapse\", \"ResourceGroup\": \"dlzdev06\", \"SubscriptionId\": \"63cbc080-0220-46aa-a9c4-a50b36f1ff43\", \"ADFPipeline\": \"GPL_SparkNotebookExecution_Azure\", \"TaskDatafactoryIR\": \"Azure\", \"JsonProperties\": {\"endpoint\": \"https://arkstgsynwadsv6ci.dev.azuresynapse.net\", \"DeltaProcessingNotebook\": \"DeltaProcessingNotebook\", \"PurviewAccountNameName\": \"dlzdev06purv\"}}, \"Source\": {\"System\": {\"SystemId\": -4, \"SystemServer\": \"https://arkstgdlsadsv6ciadsl.dfs.core.windows.net\", \"AuthenticationType\": \"MSI\", \"Type\": \"ADLS\", \"Username\": null, \"Container\": \"datalakeraw\"}, \"Instance\": {\"SourceRelativePath\": \"samples/\", \"TargetRelativePath\": \"\"}, \"DataFileName\": \"SalesLT.CustomerCDCPart2.parquet\", \"MaxConcurrentConnections\": 100, \"RelativePath\": \"samples/\", \"SchemaFileName\": \"SalesLT.CustomerCDCPart2.json\", \"Type\": \"Parquet\", \"WriteSchemaToPurview\": \"Enabled\"}, \"Target\": {\"System\": {\"SystemId\": -8, \"SystemServer\": \"https://arkstgdlsadsv6ciadsl.dfs.core.windows.net\", \"AuthenticationType\": \"MSI\", \"Type\": \"ADLS\", \"Username\": null, \"Container\": \"datalakelanding\"}, \"Instance\": {\"SourceRelativePath\": \"samples/\", \"TargetRelativePath\": \"\"}, \"DataFileName\": \"CustomerCDCDeltaTest\", \"MaxConcurrentConnections\": 100, \"RelativePath\": \"\", \"SchemaFileName\": \"\", \"Type\": \"Delta\", \"WriteSchemaToPurview\": \"Enabled\"}, \"TMOptionals\": {\"CDCSource\": \"Enabled\", \"Purview\": \"Enabled\", \"QualifiedIDAssociation\": \"ExecutionId\", \"SparkTableCreate\": \"Enabled\", \"SparkTableDBName\": \"cdctestdb\", \"SparkTableName\": \"cdctesttable2\"}}}");
            //var result = ( _purviewService.PurviewMetaDataCheck(body, _funcAppLogger).Result);

            

            _funcAppLogger.LogInformation("End");
        }



        public IEnumerable<GetTaskInstanceJsonResult> GetTests()
        {
            string filePath = Path.GetDirectoryName(AppDomain.CurrentDomain.BaseDirectory) + "..\\..\\..\\..\\UnitTests\\tests.json";
            string tests;
            using (var r = new StreamReader(filePath))
            {
                tests = r.ReadToEnd();
            }
            
            var ts = JsonConvert.DeserializeObject<List<GetTaskInstanceJsonResult>>(tests);
            return ts;
        }


        public async Task InsertTestTasksIntoDb()
        {
            // Test_GetSQLCreateStatementFromSchema(LogHelper);

            var testTaskInstances = GetTests();

            var tmdb = new TaskMetaDataDatabase(_options,_authProvider);
            var con = await tmdb.GetSqlConnection();

            var @sql = @"

            delete from [dbo].[TaskGroup] where taskgroupid <=0;            
            
            SET IDENTITY_INSERT [dbo].[TaskGroup] ON
            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-1,'Test Tasks',1, 0,10,null,1)

            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-2,'Test Tasks2',1, 0,10,null,1)

            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-3,'Test Tasks3',1, 0,10,null,1)

            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-4,'Test Tasks4',1, 0,10,null,1)

            SET IDENTITY_INSERT [dbo].[TaskGroup] OFF
   
            ";

            var result = con.Query(sql);

            sql = @"
                    
                    delete from [dbo].[TaskMaster] where taskmasterid <=0;

                    delete from [dbo].[TaskInstance] where taskmasterid <=0;";

            result = con.Query(sql);

            foreach (var testTaskInstance in testTaskInstances)
            {
                JObject processedTaskObject = null;
                try
                {
                    var T = new AdfJsonBaseTask(testTaskInstance, _funcAppLogger, _options);


                    for (int i = 1; i < 5; i++)
                    {
                        var parameters = new
                        {
                            TaskMasterId = (T.TaskMasterId * -1) - (i*100),
                            TaskMasterName = T.AdfPipeline + T.TaskMasterId.ToString(),
                            TaskTypeId = T.TaskTypeId,
                            TaskGroupId = -1*i,
                            ScheduleMasterId = 4,
                            SourceSystemId = T.SourceSystemId,
                            TargetSystemId = T.TargetSystemId,
                            DegreeOfCopyParallelism = T.DegreeOfCopyParallelism,
                            AllowMultipleActiveInstances = 0,
                            TaskDatafactoryIR = "Azure",
                            TaskMasterJSON = T.TaskMasterJson,
                            ActiveYN = 1,
                            DependencyChainTag = "",
                            EngineId = T.EngineId
                        };
                        sql = @"
                                        
                    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
                    insert into [dbo].[TaskMaster]
                    (
                        [TaskMasterId]                          ,
                        [TaskMasterName]                        ,
                        [TaskTypeId]                            ,
                        [TaskGroupId]                           ,
                        [ScheduleMasterId]                      ,
                        [SourceSystemId]                        ,
                        [TargetSystemId]                        ,
                        [DegreeOfCopyParallelism]               ,
                        [AllowMultipleActiveInstances]          ,
                        [TaskDatafactoryIR]                     ,
                        [TaskMasterJSON]                        ,
                        [ActiveYN]                              ,
                        [DependencyChainTag]                    ,
                        [EngineId]                         
                    )
                    select 
                        @TaskMasterId                          ,
                        @TaskMasterName                        ,
                        @TaskTypeId                            ,
                        @TaskGroupId                           ,
                        @ScheduleMasterId                      ,
                        @SourceSystemId                        ,
                        @TargetSystemId                        ,
                        @DegreeOfCopyParallelism               ,
                        @AllowMultipleActiveInstances          ,
                        @TaskDatafactoryIR                     ,
                        @TaskMasterJSON                        ,
                        @ActiveYN                              ,
                        @DependencyChainTag                    ,
                        @EngineId;  
                    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;";

                        result = con.Query(sql, parameters);

                    }



                    //T.CreateJsonObjectForAdf(executionId);
                    //processedTaskObject = T.ProcessRoot(_taskTypeMappingProvider, _schemasProvider);
                }
                catch (Exception e)
                {
                    _funcAppLogger.LogErrors(e);
                }
                string FileFullPath = "../../../UnitTestResults/Todo/";
                // Determine whether the directory exists.
                if (!Directory.Exists(FileFullPath))
                {
                    // Try to create the directory.
                    var di = Directory.CreateDirectory(FileFullPath);
                }

                if (processedTaskObject != null)
                {
                    JObject obj = new JObject();
                    obj["TaskObject"] = processedTaskObject;

                    FileFullPath = $"{FileFullPath}{testTaskInstance.TaskType}_{testTaskInstance.AdfPipeline}_{testTaskInstance.TaskMasterId}.json";
                    System.IO.File.WriteAllText(FileFullPath, JsonConvert.SerializeObject(obj, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }));
                }
            }

        }

        public async Task GenerateTestTaskScript()
        {
            // Test_GetSQLCreateStatementFromSchema(LogHelper);

            var testTaskInstances = GetTests();

            var tmdb = new TaskMetaDataDatabase(_options, _authProvider);
            var con = await tmdb.GetSqlConnection();

            var @sql = @"

            delete from [dbo].[TaskGroup] where taskgroupid <=0;            
            
            SET IDENTITY_INSERT [dbo].[TaskGroup] ON
            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-1,'Test Tasks',1, 0,10,null,1)

            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-2,'Test Tasks2',1, 0,10,null,1)

            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-3,'Test Tasks3',1, 0,10,null,1)

            INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
            Values (-4,'Test Tasks4',1, 0,10,null,1)

            SET IDENTITY_INSERT [dbo].[TaskGroup] OFF
   
            ";

            var result = con.Query(sql);

            sql = @"
                    
                    delete from [dbo].[TaskMaster] where taskmasterid <=0;

                    delete from [dbo].[TaskInstance] where taskmasterid <=0;";

            result = con.Query(sql);

            foreach (var testTaskInstance in testTaskInstances)
            {
                JObject processedTaskObject = null;
                try
                {
                    var T = new AdfJsonBaseTask(testTaskInstance, _funcAppLogger, _options);


                    for (int i = 1; i < 5; i++)
                    {
                        var parameters = new
                        {
                            TaskMasterId = (T.TaskMasterId * -1) - (i * 100),
                            TaskMasterName = T.AdfPipeline + T.TaskMasterId.ToString(),
                            TaskTypeId = T.TaskTypeId,
                            TaskGroupId = -1 * i,
                            ScheduleMasterId = 4,
                            SourceSystemId = T.SourceSystemId,
                            TargetSystemId = T.TargetSystemId,
                            DegreeOfCopyParallelism = T.DegreeOfCopyParallelism,
                            AllowMultipleActiveInstances = 0,
                            TaskDatafactoryIR = "Azure",
                            TaskMasterJSON = T.TaskMasterJson,
                            ActiveYN = 1,
                            DependencyChainTag = "",
                            EngineId = T.EngineId
                        };
                        sql = @"
                                        
                    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
                    insert into [dbo].[TaskMaster]
                    (
                        [TaskMasterId]                          ,
                        [TaskMasterName]                        ,
                        [TaskTypeId]                            ,
                        [TaskGroupId]                           ,
                        [ScheduleMasterId]                      ,
                        [SourceSystemId]                        ,
                        [TargetSystemId]                        ,
                        [DegreeOfCopyParallelism]               ,
                        [AllowMultipleActiveInstances]          ,
                        [TaskDatafactoryIR]                     ,
                        [TaskMasterJSON]                        ,
                        [ActiveYN]                              ,
                        [DependencyChainTag]                    ,
                        [EngineId]                         
                    )
                    select 
                        @TaskMasterId                          ,
                        @TaskMasterName                        ,
                        @TaskTypeId                            ,
                        @TaskGroupId                           ,
                        @ScheduleMasterId                      ,
                        @SourceSystemId                        ,
                        @TargetSystemId                        ,
                        @DegreeOfCopyParallelism               ,
                        @AllowMultipleActiveInstances          ,
                        @TaskDatafactoryIR                     ,
                        @TaskMasterJSON                        ,
                        @ActiveYN                              ,
                        @DependencyChainTag                    ,
                        @EngineId;  
                    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;";

                        result = con.Query(sql, parameters);

                    }



                    //T.CreateJsonObjectForAdf(executionId);
                    //processedTaskObject = T.ProcessRoot(_taskTypeMappingProvider, _schemasProvider);
                }
                catch (Exception e)
                {
                    _funcAppLogger.LogErrors(e);
                }
                string FileFullPath = "../../../UnitTestResults/Todo/";
                // Determine whether the directory exists.
                if (!Directory.Exists(FileFullPath))
                {
                    // Try to create the directory.
                    var di = Directory.CreateDirectory(FileFullPath);
                }

                if (processedTaskObject != null)
                {
                    JObject obj = new JObject();
                    obj["TaskObject"] = processedTaskObject;

                    FileFullPath = $"{FileFullPath}{testTaskInstance.TaskType}_{testTaskInstance.AdfPipeline}_{testTaskInstance.TaskMasterId}.json";
                    System.IO.File.WriteAllText(FileFullPath, JsonConvert.SerializeObject(obj, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }));
                }
            }

        }

        public async Task DebugPrepareFrameworkTasks()
        {

            FunctionApp.Functions.AdfPrepareFrameworkTasksTimerTrigger c = new FunctionApp.Functions.AdfPrepareFrameworkTasksTimerTrigger( _options, _taskMetaDataDatabase, _dataFactoryPipelineProvider, _taskTypeMappingProvider, _httpClientFactory, _integrationRuntimeMappingProvider);
            c.HeartBeatFolder = "./heartbeats/";
            await c.PrepareFrameworkTasksCore(_funcAppLogger);
        }

        public void DebugSynapsePipeline()
        {
            JObject json = JObject.Parse("{ 'TaskInstanceId':20,'TaskMasterId':-2,'TaskStatus':'InProgress','TaskType':'Azure Storage to SQL Database','Enabled':1,'ExecutionUid':'b829721c-f297-49eb-8436-c33e27005971','NumberOfRetries':0,'DegreeOfCopyParallelism':1,'KeyVaultBaseUrl':'https://mst-stg-kv-ads-pnu0.vault.azure.net/','ScheduleMasterId':'4','TaskGroupConcurrency':'10','TaskGroupPriority':0,'TaskExecutionType':'ADF','DataFactory':{ 'Id':1,'Name':'mst-stg-adf-ads-pnu0','ResourceGroup':'adsgftera2','SubscriptionId':'035a1364-f00d-48e2-b582-4fe125905ee3','ADFPipeline':'GPL_AzureBlobFS_Parquet_AzureSqlTable_NA_Azure','TaskDatafactoryIR':'Azure'},'Source':{ 'System':{ 'SystemId':4,'SystemServer':'https://arkstgdlsadsbcaradsl.dfs.core.windows.net','AuthenticationType':'MSI','Type':'ADLS','Username':null,'Container':'datalakeraw'},'Instance':{ 'SourceRelativePath':'samples/'},'DataFileName':'SalesLT.Customer.chunk_1.parquet','SchemaFileName':'SalesLT.Customer.json','DeleteAfterCompletion':'false','MaxConcurrentConnections':0,'Recursively':'false','RelativePath':'samples/','Type':'Parquet'},'Target':{ 'System':{ 'SystemId':4,'SystemServer':'https://arkstgdlsadsbcaradsl.dfs.core.windows.net','AuthenticationType':'MSI','Type':'ADLS','Username':null,'Container':'datalakelanding'},'Instance':{ 'SourceRelativePath':'samples/'},'DataFileName':'SalesLT-Customer-Delta','DeleteAfterCompletion':'false','MaxConcurrentConnections':0,'Recursively':'false','RelativePath':'samples/','Type':'Delta'} }");
            Dictionary<string, object> testDict = new Dictionary<string, object> ();
            testDict.Add("TaskObject", json);
            _azureSynapseService.RunSynapsePipeline(new Uri("https://adsstgsynwadswkuy.dev.azuresynapse.net"), "Pipeline 1", testDict, _funcAppLogger);
        }

        public async Task DebugRunFrameworkTasks()
        {
            
            FunctionApp.Functions.AdfRunFrameworkTasksHttpTrigger c = new FunctionApp.Functions.AdfRunFrameworkTasksHttpTrigger(_sap,_taskMetaDataDatabase, _options, _authProvider, _dataFactoryClientFactory, _azureSynapseService, _microsoftAzureServicesAppAuthenticationProvider, _keyVaultService, _powerBIService, _azureDataLakeService);
            c.HeartBeatFolder = "./";
            await c.RunFrameworkTasksCore(1, _funcAppLogger);            
            _funcAppLogger.DefaultActivityLogItem.ExecutionUid = Guid.NewGuid();
            await c.RunFrameworkTasksCore(2, _funcAppLogger);

            _funcAppLogger.DefaultActivityLogItem.ExecutionUid = Guid.NewGuid();
            await c.RunFrameworkTasksCore(3, _funcAppLogger);

            _funcAppLogger.DefaultActivityLogItem.ExecutionUid = Guid.NewGuid();
            await c.RunFrameworkTasksCore(4, _funcAppLogger);

        }

        public async Task DebugRunFrameworkTasksTimerTrigger()
        {            
            FunctionApp.Functions.AdfRunFrameworkTasksTimerTrigger c = new FunctionApp.Functions.AdfRunFrameworkTasksTimerTrigger( _options, _taskMetaDataDatabase, _httpClientFactory);
            c.HeartBeatFolder = "./";
            await c.Core(_logger);
        }

        public async Task DebugStartSynapseSessions()
        {
            List<string> t = new List<string>();
            t.Add("1000");
            t.Add("1001");
            t.Add("1002");
            t.Add("1003");
            t.Add("1004");
            t.Add("1005");
            t.Add("1006");
            t.Add("1007");
            t.Add("1008");
            t.Add("1009");

            string TaskObjectStrTemplate = "{\"TaskInstanceId\":@taskinstanceid,\"TaskMasterId\":@taskinstanceid,\"TaskStatus\":\"InProgress\",\"TaskType\":\"Azure Storage to Azure Storage\",\"Enabled\":1,\"ExecutionUid\":\"cb49bd35-609c-4d0f-a8a2-ed53c2d61c56\",\"NumberOfRetries\":1,\"DegreeOfCopyParallelism\":1,\"KeyVaultBaseUrl\":\"https://ads-dev-kv-ads-we7y.vault.azure.net/\",\"ScheduleMasterId\":\"-4\",\"TaskGroupConcurrency\":\"10\",\"TaskGroupPriority\":0,\"TaskExecutionType\":\"ADF\",\"ExecutionEngine\":{\"EngineId\":-2,\"EngineName\":\"adsdevsynwadsnot5\",\"SystemType\":\"Synapse\",\"ResourceGroup\":\"gf6\",\"SubscriptionId\":\"035a1364-f00d-48e2-b582-4fe125905ee3\",\"ADFPipeline\":\"GPL_SparkNotebookExecution_Azure\",\"EngineJson\":\"{            \\\"endpoint\\\": \\\"https://adsdevsynwadswe7y.dev.azuresynapse.net\\\", \\\"DeltaProcessingNotebook\\\": \\\"DeltaProcessingNotebook\\\", \\\"PurviewAccountName\\\": \\\"adsdevpurads\\\" ,  \\\"DefaultSparkPoolName\\\": \\\"adsdevsynspads\\\"      }\",\"TaskDatafactoryIR\":\"Azure\",\"JsonProperties\":{\"endpoint\":\"https://adsdevsynwadswe7y.dev.azuresynapse.net\",\"DeltaProcessingNotebook\":\"DeltaProcessingNotebook\",\"PurviewAccountName\":\"adsdevpurads\",\"DefaultSparkPoolName\":\"adsdevsynspads\"}},\"Source\":{\"System\":{\"SystemId\":-4,\"SystemServer\":\"https://adsdevdlsadswe7yadsl.dfs.core.windows.net\",\"AuthenticationType\":\"MSI\",\"Type\":\"ADLS\",\"Username\":null,\"Container\":\"datalakeraw\"},\"Instance\":{\"SourceRelativePath\":\"samples/\",\"TargetRelativePath\":\"/Tests/Azure Storage to Azure Storage/-1000/\"},\"DataFileName\":\"SalesLT.Customer*.parquet\",\"MaxConcurrentConnections\":0,\"RelativePath\":\"samples/\",\"SchemaFileName\":\"SalesLT.Customer*.json\",\"Type\":\"Parquet\",\"WriteSchemaToPurview\":\"Disabled\",\"DeleteAfterCompletion\":\"false\",\"Recursively\":\"false\"},\"Target\":{\"System\":{\"SystemId\":-4,\"SystemServer\":\"https://adsdevdlsadswe7yadsl.dfs.core.windows.net\",\"AuthenticationType\":\"MSI\",\"Type\":\"ADLS\",\"Username\":null,\"Container\":\"datalakeraw\"},\"Instance\":{\"SourceRelativePath\":\"samples/\",\"TargetRelativePath\":\"/Tests/Azure Storage to Azure Storage/-1000/\"},\"DataFileName\":\"SalesLT.Customer\",\"MaxConcurrentConnections\":0,\"RelativePath\":\"/Tests/Azure Storage to Azure Storage/-1000/\",\"SchemaFileName\":\"SalesLT.Customer.json\",\"Type\":\"Delta\",\"WriteSchemaToPurview\":\"Disabled\",\"DeleteAfterCompletion\":\"false\",\"Recursively\":\"false\"},\"TMOptionals\":{\"CDCSource\":\"Disabled\",\"Purview\":\"Disabled\",\"QualifiedIDAssociation\":\"TaskMasterId\",\"SparkTableCreate\":\"Disabled\",\"SparkTableDBName\":\"\",\"SparkTableName\":\"\",\"UseNotebookActivity\":\"Disabled\"}}";

            List<Task<string>> Tasks = new List<Task<string>>();

            foreach (string str in t)
            {
                string TaskObjectStr = TaskObjectStrTemplate.Replace("@fld",str);
                TaskObjectStr = TaskObjectStr.Replace("@taskinstanceid", str);
                JObject TaskObject = JObject.Parse(TaskObjectStr);
                string SparkPoolName = JObject.Parse(TaskObject["ExecutionEngine"]["EngineJson"].ToString())["DefaultSparkPoolName"].ToString();
                string Endpoint = JObject.Parse(TaskObject["ExecutionEngine"]["EngineJson"].ToString())["endpoint"].ToString();
                string JobName = $"TaskInstance_{TaskObject["TaskInstanceId"].ToString()}";
                Tasks.Add(_azureSynapseService.ExecuteNotebook(new Uri(Endpoint), JobName, SparkPoolName, _funcAppLogger, "C:\\Users\\jrambo\\source\\gitms\\adsgf\\solution\\FunctionApp\\FunctionApp\\bin\\Debug\\net6.0\\", TaskObject));
                //System.Threading.Thread.Sleep(1000);
            }
            await Task.WhenAll(Tasks.ToArray());

            Parallel.ForEach(Tasks, task =>
            {
                bool taskComplete = false;
                while (!taskComplete)
                {
                    var res = _azureSynapseService.CheckStatementExecution(JObject.Parse(task.Result), _funcAppLogger).Result;
                    if (res == "available")
                    {
                        taskComplete = true;
                        _funcAppLogger.LogInformation($"Task Complete");
                    }
                    else
                    {
                       Task.Delay(10000).Wait();
                    }
                }

            });



        }

        public async Task DebugStopSynapseSessions()
        {
            string TaskObjectStr = "{\"TaskInstanceId\": 1,\"ExecutionEngine\": {\"EngineJson\": \"{ \\\"endpoint\\\": \\\"https://adsdevsynwadswe7y.dev.azuresynapse.net\\\", \\\"DeltaProcessingNotebook\\\": \\\"DeltaProcessingNotebook\\\", \\\"PurviewAccountName\\\": \\\"adsdevpuradswe7y\\\", \\\"DefaultSparkPoolName\\\":\\\"adsdevsynspads\\\"        }\"}}";

            JObject TaskObject = JObject.Parse(TaskObjectStr);
            string SparkPoolName = JObject.Parse(TaskObject["ExecutionEngine"]["EngineJson"].ToString())["DefaultSparkPoolName"].ToString();
            string Endpoint = JObject.Parse(TaskObject["ExecutionEngine"]["EngineJson"].ToString())["endpoint"].ToString();
            string JobName = $"TaskInstance_{TaskObject["TaskInstanceId"].ToString()}";                        

            await _azureSynapseService.StopIdleSessions(new Uri(Endpoint), SparkPoolName, _funcAppLogger, TaskObject);
   
        }


        public async Task PurviewCreateEntitiesTest() {


            // Test Purview Connectivity
            string PurviewAccountName = "adsdevpurads";
            JObject EmptyDatasetBody = new JObject();
            JObject datasetGuid0 = JObject.Parse(await _purviewService.ExecuteRequest(PurviewAccountName, "get", ".catalog.purview.azure.com", "/api/atlas/v2/types/typedefs", "2021-07-01", EmptyDatasetBody, _funcAppLogger));

            var testData = "{\"SourceHttpPath\": \"https://datalakelanding/arkstgdlsadsirudadsl.dfs.core.windows.net/TestFile.parquet\", \"TargetHttpPath\": \"https://datalakelanding/arkstgdlsadsirudadsl.dfs.core.windows.net/TestFile.parquet\", \"SourceColumns\": \"Invalid\", \"TargetColumns\": [{\"name\": \"CustomerID\", \"type\": \"int\"}, {\"name\": \"NameStyle\", \"type\": \"boolean\"}, {\"name\": \"Title\", \"type\": \"string\"}, {\"name\": \"FirstName\", \"type\": \"string\"}, {\"name\": \"MiddleName\", \"type\": \"string\"}, {\"name\": \"LastName\", \"type\": \"string\"}, {\"name\": \"Suffix\", \"type\": \"string\"}, {\"name\": \"CompanyName\", \"type\": \"string\"}, {\"name\": \"SalesPerson\", \"type\": \"string\"}, {\"name\": \"EmailAddress\", \"type\": \"string\"}, {\"name\": \"Phone\", \"type\": \"string\"}, {\"name\": \"PasswordHash\", \"type\": \"string\"}, {\"name\": \"PasswordSalt\", \"type\": \"string\"}, {\"name\": \"rowguid\", \"type\": \"string\"}, {\"name\": \"ModifiedDate\", \"type\": \"timestamp\"}], \"TaskObject\": {\"TaskInstanceId\": 1, \"TaskMasterId\": 2, \"TaskStatus\": \"InProgress\", \"TaskType\": \"TestTask Type Name\", \"Enabled\": 1, \"ExecutionUid\": \"8448eabb-9ba4-4779-865b-29e973431273\", \"NumberOfRetries\": 0, \"DegreeOfCopyParallelism\": 1, \"KeyVaultBaseUrl\": \"https://ark-stg-kv-ads-irud.vault.azure.net/\", \"ScheduleMasterId\": \"-4\", \"TaskGroupConcurrency\": \"10\", \"TaskGroupPriority\": 0, \"TaskExecutionType\": \"ADF\", \"ExecutionEngine\": {\"EngineId\": -1, \"EngineName\": \"ark-stg-adf-ads-irud\", \"SystemType\": \"Datafactory\", \"ResourceGroup\": \"dlzdev04\", \"SubscriptionId\": \"ed1206e0-17c7-4bc2-ad4b-f8d4dab9284f\", \"ADFPipeline\": \"GPL_AzureSqlTable_NA_AzureBlobFS_Parquet_Azure\", \"EngineJson\": \"{}\", \"TaskDatafactoryIR\": \"Azure\", \"JsonProperties\": {}}, \"Source\": {\"System\": {\"SystemId\": -8, \"SystemServer\": \"https://arkstgdlsadsirudadsl.dfs.core.windows.net\", \"AuthenticationType\": \"MSI\", \"Type\": \"ADLS\", \"Username\": null, \"Container\": \"datalakelanding\"}, \"Instance\": {\"SourceRelativePath\": \"\"}, \"WriteSchemaToPurview\": \"Enabled\", \"DataFileName\": \"Input.parquet\", \"RelativePath\": \"\", \"SchemaFileName\": \"TestFile.json\"}, \"Target\": {\"System\": {\"SystemId\": -8, \"SystemServer\": \"https://arkstgdlsadsirudadsl.dfs.core.windows.net\", \"AuthenticationType\": \"MSI\", \"Type\": \"ADLS\", \"Username\": null, \"Container\": \"datalakelanding\"}, \"Instance\": {\"TargetRelativePath\": \"\"}, \"WriteSchemaToPurview\": \"Enabled\", \"DataFileName\": \"TestFile.parquet\", \"RelativePath\": \"\", \"SchemaFileName\": \"TestFile.json\", \"Type\": \"Parquet\"}}}";
            JObject metadata = JsonConvert.DeserializeObject<JObject>(testData);


            List<String> datasets = new List<String>();
            string[] toIterate = { "SourceColumns", "TargetColumns" };

            for (int i = 0; i < toIterate.Length; i++)
            {
                string choice = Regex.Match(toIterate[i], @"^.*?(?=Columns)").ToString();
                string containerPartial = Regex.Match(metadata["TaskObject"][choice]["System"]["SystemServer"].ToString(), @"(?<=https://)(\w+)").ToString();

                // Setting up Input/Output Entities
                //Note - This will be expanded on as we expand more types to be read into purview. At the moment it assumes the items are read from a restricted set of sources
                string datasetType = "azure_datalake_gen2_resource_set";
                string datasetPath = "/azure_storage_account#" + containerPartial + ".core.windows.net/azure_datalake_gen2_service#" + metadata["TaskObject"][choice]["System"]["SystemServer"].ToString() + "/" + "azure_datalake_gen2_filesystem#" + metadata["TaskObject"][choice]["System"]["Container"].ToString() + "/azure_datalake_gen2_path#" + metadata["TaskObject"][choice]["RelativePath"].ToString() + "azure_datalake_gen2_resource_set#" + metadata["TaskObject"][choice]["DataFileName"].ToString();
                //string datasetName = "";
                string datasetQualifiedName = "";
                string modifiedRelativePath = "";
                //At the moment it only support resource sets -> This is for datalake gen2.
                switch (metadata["TaskObject"][choice]["System"]["Type"].ToString())
                {
                    case "Delta":
                        modifiedRelativePath = Regex.Replace(metadata["TaskObject"][choice]["Instance"][choice + "RelativePath"].ToString(), "[0-9]{2,}", "{N}");
                        datasetQualifiedName = metadata["TaskObject"][choice]["System"]["SystemServer"] + "/" + metadata["TaskObject"][choice]["System"]["Container"] + "/" + modifiedRelativePath + "/" + metadata["TaskObject"][choice]["DataFileName"] + "/{SparkPartitions}";
                        break;
                    default:
                        //datasetName = metadata["TaskObject"][choice]["DataFileName"].ToString().Split(new Char[] { ',', '.' })[0];
                        modifiedRelativePath =  Regex.Replace(metadata["TaskObject"][choice]["Instance"][choice+"RelativePath"].ToString(), "[0-9]{2,}", "{N}");
                        datasetQualifiedName = metadata["TaskObject"][choice]["System"]["SystemServer"] + "/" + metadata["TaskObject"][choice]["System"]["Container"] + "/" + modifiedRelativePath + "/" + metadata["TaskObject"][choice]["DataFileName"];
                        break;
                }
                JObject dataset = JObject.FromObject(new
                {
                    typeName = datasetType,
                    attributes = new
                    {
                        qualifiedName = datasetQualifiedName,
                        name = metadata["TaskObject"][choice]["DataFileName"],
                        path = datasetPath,
                        description = (String)null,
                        objectType = (String)null
                    },
                    status = "ACTIVE"
                });
                
                JObject datasetJson = new JObject(new JProperty("entity", dataset));
                var datasetConv = datasetJson.ToString();
                var datasetBody = JObject.Parse(datasetConv);
                JObject datasetGuid = JObject.Parse(_purviewService.ExecuteRequest("adsdevpurads", "post", ".catalog.purview.azure.com", "/api/atlas/v2/entity", "2021-07-01", datasetBody, _funcAppLogger).Result);
                //This is for the process at the end
               //datasets.Add(datasetGuid["guidAssignments"].First.Last.ToString());

                //If the dataset has columns at all, we need to create a schema, a dataset-schema relationship, columns and a schema-column relationship.
                if (metadata["TaskObject"][choice]["WriteSchemaToPurview"].ToString() == "Enabled")
                {
                    if (metadata[toIterate[i]].HasValues)
                    {

                        // Setting up Schema entity
                        JObject schema = JObject.FromObject(new
                        {
                            typeName = "tabular_schema",
                            attributes = new
                            {
                                owner = (String)null,
                                replicatedTo = (String)null,
                                replicatedFrom = (String)null,
                                qualifiedName = metadata[choice + "HttpPath"] + "#__tabular_schema",
                                name = metadata[choice + "HttpPath"] + "#__tabular_schema",
                                description = (String)null,
                            },
                            status = "ACTIVE"
                        });

                        JObject schemaJson = new JObject(new JProperty("entity", schema));
                        var schemaConv = schemaJson.ToString();
                        var schemaBody = JObject.Parse(schemaConv);
                        var schemaGuid = JObject.Parse(await _purviewService.ExecuteRequest(PurviewAccountName, "post", ".catalog.purview.azure.com", "/api/atlas/v2/entity", "2021-07-01", schemaBody, _funcAppLogger));


                        //Relationship for Dataset and schema
                        JObject dsRelationship = JObject.FromObject(new
                        {
                            typeName = "tabular_schema_datasets",
                            end1 = new
                            {
                                guid = datasetGuid["guidAssignments"].First.Last.ToString()
                            },
                            end2 = new
                            {
                                guid = schemaGuid["guidAssignments"].First.Last.ToString()
                            },
                            label = "r:" + datasetGuid["guidAssignments"].First.Last.ToString() + "_" + schemaGuid["guidAssignments"].First.Last.ToString(),
                            status = "ACTIVE"
                        });
                        //JObject dsRelJson = new JObject(new JProperty("relationship", dsRelationship));
                        var dsRelConv = dsRelationship.ToString();
                        var dsRelBody = JObject.Parse(dsRelConv);
                        JObject dsRelGuid = JObject.Parse(await _purviewService.ExecuteRequest(PurviewAccountName, "post", ".catalog.purview.azure.com", "/api/atlas/v2/relationship", "2021-07-01", dsRelBody, _funcAppLogger));





                        JArray entities = new JArray();
                        //Setting up Column entities
                        foreach (var column in metadata[toIterate[i]])
                        {
                            //Convert our dataframe datatype to atlas API compatible
                            string conversion;
                            switch (column["type"].ToString())
                            {
                                case "int":
                                    conversion = "INT32";
                                    break;
                                case "boolean":
                                    conversion = "BOOLEAN";
                                    break;
                                case "timestamp":
                                    conversion = "INT96";
                                    break;
                                default:
                                    conversion = "UTF8";
                                    break;
                            }
                            JObject entity = JObject.FromObject(new
                            {
                                typeName = "column",
                                attributes = new
                                {
                                    owner = (String)null,
                                    replicatedTo = (String)null,
                                    replicatedFrom = (String)null,
                                    qualifiedName = metadata[choice + "HttpPath"] + "#__tabular_schema//" + column["name"].ToString(),
                                    name = column["name"].ToString(),
                                    description = (String)null,
                                    type = conversion,
                                },
                                status = "ACTIVE"
                            });
                            entities.Add(entity);
                        }
                        JObject colJson = new JObject(new JProperty("entities", entities));
                        string colConv = colJson.ToString();
                        JObject colBody = JObject.Parse(colConv);
                        JObject colGuids = JObject.Parse(_purviewService.ExecuteRequest(PurviewAccountName, "post", ".catalog.purview.azure.com", "/api/atlas/v2/entity/bulk", "2021-07-01", colBody, _funcAppLogger).Result);
                        var cols = colGuids["guidAssignments"];
                        //Setting up Schema/Column Relationship
                        foreach (var col in cols)
                        {
                            JObject scRelationship = JObject.FromObject(new
                            {
                                typeName = "tabular_schema_columns",
                                end1 = new
                                {
                                    guid = schemaGuid["guidAssignments"].First.Last.ToString()
                                },
                                end2 = new
                                {
                                    guid = col.First.ToString()
                                },
                                label = "r:" + schemaGuid["guidAssignments"].First.Last.ToString() + "_" + col.First.ToString(),
                                status = "ACTIVE"
                            });
                            //JObject scRelJson = new JObject(new JProperty("relationship", scRelationship));
                            var scRelConv = scRelationship.ToString();
                            var scRelBody = JObject.Parse(scRelConv);
                            JObject scRelGuid = JObject.Parse(_purviewService.ExecuteRequest(PurviewAccountName, "post", ".catalog.purview.azure.com", "/api/atlas/v2/relationship", "2021-07-01", scRelBody, _funcAppLogger).Result);

                        }

                    }
                }

            }
            //Finally we want to link up the dataset objects to the process
            // Setting up the final process entity 
            JObject process = JObject.FromObject(new
            {
                typeName = "azure_synapse_pipeline",
                status = "ACTIVE",
                attributes = new
                {
                    inputs = new JArray(JObject.FromObject(new { guid = datasets[0] })),
                    outputs = new JArray(JObject.FromObject(new { guid = datasets[1] })),
                    qualifiedName = "Synapse_Pipeline_Execution_UID_" + metadata["TaskObject"]["ExecutionUid"],
                    name =  metadata["TaskObject"]["ExecutionEngine"]["ADFPipeline"] + "_" + DateTime.Now.ToString("dd/MM/yyyy HH:mm")
                },
            });

            JObject processJson = new JObject(new JProperty("entity", process));
            var processConv = processJson.ToString();
            var processBody = JObject.Parse(processConv);
            var processGuid = JObject.Parse(_purviewService.ExecuteRequest(PurviewAccountName, "post", ".catalog.purview.azure.com", "/api/atlas/v2/entity", "2021-07-01", processBody, _funcAppLogger).Result);

            //
        }

        /// <summary>
        /// 
        /// </summary>
        public async Task GenerateUnitTestResults()
        {            

            var testTaskInstances = GetTests();

            //Set up table to Store Invalid Task Instance Objects
            DataTable InvalidTIs = new DataTable();
            InvalidTIs.Columns.Add("ExecutionUid", typeof(Guid));
            InvalidTIs.Columns.Add("TaskInstanceId", typeof(long));
            InvalidTIs.Columns.Add("LastExecutionComment", typeof(string));
            EngineJsonSchemasProvider engineSchemas = new EngineJsonSchemasProvider(_taskMetaDataDatabase);

            foreach (var testTaskInstance in testTaskInstances)
            {
                JObject processedTaskObject = null;
                try
                {
                    var T = new AdfJsonBaseTask(testTaskInstance, _funcAppLogger, _options);
                    T.CreateJsonObjectForAdf((Guid)_funcAppLogger.DefaultActivityLogItem.ExecutionUid);
                    processedTaskObject = await T.ProcessRoot(_taskTypeMappingProvider, _schemasProvider, engineSchemas);
                }
                catch (Exception e)
                {
                    _funcAppLogger.LogErrors(e);
                }
                string FileFullPath = "../../../UnitTestResults/Todo/";
                // Determine whether the directory exists.
                if (!Directory.Exists(FileFullPath))
                {
                    // Try to create the directory.
                    var di = Directory.CreateDirectory(FileFullPath);
                }

                if (processedTaskObject != null)
                {
                    JObject obj = new JObject();
                    obj["TaskObject"] = processedTaskObject;

                    FileFullPath = $"{FileFullPath}{testTaskInstance.TaskType}_{testTaskInstance.AdfPipeline}_{testTaskInstance.TaskMasterId}.json";
                    File.WriteAllText(FileFullPath, JsonConvert.SerializeObject(obj, Formatting.Indented, new JsonSerializerSettings { NullValueHandling = NullValueHandling.Ignore }));
                }
            }

        }

        public void Test_GetSQLCreateStatementFromSchema(Logging.Logging _logging)
        {
            string _filePath = Path.GetDirectoryName(System.AppDomain.CurrentDomain.BaseDirectory) + "..\\..\\..\\..\\UnitTests\\GetSQLCreateStatementFromSchema.json";
            string tests = "";
            using (var r = new StreamReader(_filePath))
            {
                tests = r.ReadToEnd();
            }

            //var bytes = Convert.FromBase64String("eyJUYXNrSW5zdGFuY2VJZCI6ODY1LCJUYXNrTWFzdGVySWQiOjEwMiwiVGFza1N0YXR1cyI6IlVudHJpZWQiLCJUYXNrVHlwZSI6IlNRTCBEYXRhYmFzZSB0byBBenVyZSBTdG9yYWdlIiwiRW5hYmxlZCI6MSwiRXhlY3V0aW9uVWlkIjoiZDk1NGNmZWUtNDRjMS00MTlmLTgzZDUtNTFmNzVlYWY4MDljIiwiTnVtYmVyT2ZSZXRyaWVzIjowLCJEZWdyZWVPZkNvcHlQYXJhbGxlbGlzbSI6MSwiS2V5VmF1bHRCYXNlVXJsIjoiaHR0cHM6Ly9hZHNnb2Zhc3RrZXl2YXVsdC52YXVsdC5henVyZS5uZXQvIiwiU2NoZWR1bGVNYXN0ZXJJZCI6MiwiVGFza0dyb3VwQ29uY3VycmVuY3kiOjEwLCJUYXNrR3JvdXBQcmlvcml0eSI6MCwiU291cmNlIjp7IlR5cGUiOiJTUUwgU2VydmVyIiwiRGF0YWJhc2UiOnsiU3lzdGVtTmFtZSI6ImFkc2dvZmFzdC1vbnByZSIsIk5hbWUiOiJBZHZlbnR1cmVXb3JrczIwMTciLCJBdXRoZW50aWNhdGlvblR5cGUiOiJTUUxBdXRoIiwiVXNlcm5hbWUiOiJzcWxhZGZpciIsIlBhc3N3b3JkS2V5VmF1bHRTZWNyZXROYW1lIjoiYWRzZ29mYXN0LW9ucHJlLXNxbGFkZmlyLXBhc3N3b3JkIn0sIkV4dHJhY3Rpb24iOnsiVHlwZSI6IlRhYmxlIiwiRnVsbE9ySW5jcmVtZW50YWwiOiJGdWxsIiwiSW5jcmVtZW50YWxUeXBlIjpudWxsLCJUYWJsZVNjaGVtYSI6IlNhbGVzIiwiVGFibGVOYW1lIjoiU2FsZXNPcmRlckhlYWRlciJ9fSwiVGFyZ2V0Ijp7IlR5cGUiOiJBenVyZSBCbG9iIiwiU3RvcmFnZUFjY291bnROYW1lIjoiaHR0cHM6Ly9hZHNnb2Zhc3RkYXRhbGFrZWFjY2Vsc3QuYmxvYi5jb3JlLndpbmRvd3MubmV0IiwiU3RvcmFnZUFjY291bnRDb250YWluZXIiOiJkYXRhbGFrZXJhdyIsIlN0b3JhZ2VBY2NvdW50QWNjZXNzTWV0aG9kIjoiTVNJIiwiUmVsYXRpdmVQYXRoIjoiQWR2ZW50dXJlV29ya3MyMDE3L1NhbGVzL1NhbGVzT3JkZXJIZWFkZXIvMjAyMC83LzIzLzkvMC8iLCJEYXRhRmlsZU5hbWUiOiJTYWxlcy5TYWxlc09yZGVySGVhZGVyLnBhcnF1ZXQiLCJTY2hlbWFGaWxlTmFtZSI6IlNhbGVzLlNhbGVzT3JkZXJIZWFkZXIuanNvbiIsIkZpcnN0Um93QXNIZWFkZXIiOm51bGwsIlNoZWV0TmFtZSI6bnVsbCwiU2tpcExpbmVDb3VudCI6bnVsbCwiTWF4Q29uY29ycmVudENvbm5lY3Rpb25zIjpudWxsfSwiRGF0YUZhY3RvcnkiOnsiSWQiOjEsIk5hbWUiOiJhZHNnb2Zhc3RkYXRha2FrZWFjY2VsYWRmIiwiUmVzb3VyY2VHcm91cCI6IkFkc0dvRmFzdERhdGFMYWtlQWNjZWwiLCJTdWJzY3JpcHRpb25JZCI6IjAzNWExMzY0LWYwMGQtNDhlMi1iNTgyLTRmZTEyNTkwNWVlMyIsIkFERlBpcGVsaW5lIjoiT25QLVNRTC1BWi1TdG9yYWdlLVBhcnF1ZXQtT25QLVNILUlSIn19");
            //var s = System.Text.Encoding.UTF8.GetString(bytes);



            FunctionApp.Functions.GetSqlCreateStatementFromSchema c = new Functions.GetSqlCreateStatementFromSchema(_options, _authProvider);
            var r1 = c.GetSqlCreateStatementFromSchemaCore(JObject.Parse(tests), _logging).Result;
            //var r1 = c.GetSqlCreateStatementFromSchemaCore(JObject.Parse("{\"TaskObject\": \"eyJUYXNrSW5zdGFuY2VJZCI6ODY1LCJUYXNrTWFzdGVySWQiOjEwMiwiVGFza1N0YXR1cyI6IlVudHJpZWQiLCJUYXNrVHlwZSI6IlNRTCBEYXRhYmFzZSB0byBBenVyZSBTdG9yYWdlIiwiRW5hYmxlZCI6MSwiRXhlY3V0aW9uVWlkIjoiZDk1NGNmZWUtNDRjMS00MTlmLTgzZDUtNTFmNzVlYWY4MDljIiwiTnVtYmVyT2ZSZXRyaWVzIjowLCJEZWdyZWVPZkNvcHlQYXJhbGxlbGlzbSI6MSwiS2V5VmF1bHRCYXNlVXJsIjoiaHR0cHM6Ly9hZHNnb2Zhc3RrZXl2YXVsdC52YXVsdC5henVyZS5uZXQvIiwiU2NoZWR1bGVNYXN0ZXJJZCI6MiwiVGFza0dyb3VwQ29uY3VycmVuY3kiOjEwLCJUYXNrR3JvdXBQcmlvcml0eSI6MCwiU291cmNlIjp7IlR5cGUiOiJTUUwgU2VydmVyIiwiRGF0YWJhc2UiOnsiU3lzdGVtTmFtZSI6ImFkc2dvZmFzdC1vbnByZSIsIk5hbWUiOiJBZHZlbnR1cmVXb3JrczIwMTciLCJBdXRoZW50aWNhdGlvblR5cGUiOiJTUUxBdXRoIiwiVXNlcm5hbWUiOiJzcWxhZGZpciIsIlBhc3N3b3JkS2V5VmF1bHRTZWNyZXROYW1lIjoiYWRzZ29mYXN0LW9ucHJlLXNxbGFkZmlyLXBhc3N3b3JkIn0sIkV4dHJhY3Rpb24iOnsiVHlwZSI6IlRhYmxlIiwiRnVsbE9ySW5jcmVtZW50YWwiOiJGdWxsIiwiSW5jcmVtZW50YWxUeXBlIjpudWxsLCJUYWJsZVNjaGVtYSI6IlNhbGVzIiwiVGFibGVOYW1lIjoiU2FsZXNPcmRlckhlYWRlciJ9fSwiVGFyZ2V0Ijp7IlR5cGUiOiJBenVyZSBCbG9iIiwiU3RvcmFnZUFjY291bnROYW1lIjoiaHR0cHM6Ly9hZHNnb2Zhc3RkYXRhbGFrZWFjY2Vsc3QuYmxvYi5jb3JlLndpbmRvd3MubmV0IiwiU3RvcmFnZUFjY291bnRDb250YWluZXIiOiJkYXRhbGFrZXJhdyIsIlN0b3JhZ2VBY2NvdW50QWNjZXNzTWV0aG9kIjoiTVNJIiwiUmVsYXRpdmVQYXRoIjoiQWR2ZW50dXJlV29ya3MyMDE3L1NhbGVzL1NhbGVzT3JkZXJIZWFkZXIvMjAyMC83LzIzLzkvMC8iLCJEYXRhRmlsZU5hbWUiOiJTYWxlcy5TYWxlc09yZGVySGVhZGVyLnBhcnF1ZXQiLCJTY2hlbWFGaWxlTmFtZSI6IlNhbGVzLlNhbGVzT3JkZXJIZWFkZXIuanNvbiIsIkZpcnN0Um93QXNIZWFkZXIiOm51bGwsIlNoZWV0TmFtZSI6bnVsbCwiU2tpcExpbmVDb3VudCI6bnVsbCwiTWF4Q29uY29ycmVudENvbm5lY3Rpb25zIjpudWxsfSwiRGF0YUZhY3RvcnkiOnsiSWQiOjEsIk5hbWUiOiJhZHNnb2Zhc3RkYXRha2FrZWFjY2VsYWRmIiwiUmVzb3VyY2VHcm91cCI6IkFkc0dvRmFzdERhdGFMYWtlQWNjZWwiLCJTdWJzY3JpcHRpb25JZCI6IjAzNWExMzY0LWYwMGQtNDhlMi1iNTgyLTRmZTEyNTkwNWVlMyIsIkFERlBpcGVsaW5lIjoiT25QLVNRTC1BWi1TdG9yYWdlLVBhcnF1ZXQtT25QLVNILUlSIn19\",\"RunId\":d1c14fa6-abd9-4830-ab8f-56e27c1539ab}"), _logging).Result;

        }

        public void Test_TaskExecutionSchemaFile(Logging.Logging _logging)
        {
            string _filePath = Path.GetDirectoryName(System.AppDomain.CurrentDomain.BaseDirectory) + "..\\..\\..\\..\\UnitTests\\TaskExecutionSchemaFile.json";
            string tests = "";
            using (var r = new StreamReader(_filePath))
            {
                tests = r.ReadToEnd();
            }

            FunctionApp.Functions.TaskExecutionSchemaFile c = new Functions.TaskExecutionSchemaFile(_options, _authProvider);
            var r1 = c.TaskExecutionSchemaFileCore(JObject.Parse(tests), _logging).Result;

        }

        public void Test_GetSourceTargetMapping(Logging.Logging _logging)
        {
            string _filePath = Path.GetDirectoryName(System.AppDomain.CurrentDomain.BaseDirectory) + "..\\..\\..\\..\\UnitTests\\GetSourceTargetMapping.json";
            string tests = "";
            using (var r = new StreamReader(_filePath))
            {
                tests = r.ReadToEnd();
            }

            FunctionApp.Functions.AdfGetSourceTargetMapping c = new Functions.AdfGetSourceTargetMapping(_options, _authProvider);
            var r1 = c.GetSourceTargetMappingCore(JObject.Parse(tests), _logging).Result;

        }


    }
}
