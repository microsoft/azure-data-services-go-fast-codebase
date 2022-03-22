/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Net.Http;
using FormatWith;
using FunctionApp.DataAccess;
using FunctionApp.Helpers;
using FunctionApp.Models;
using FunctionApp.Models.Options;
using FunctionApp.Services;
using Microsoft.Azure.WebJobs;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using Newtonsoft.Json.Linq;

namespace FunctionApp.Functions
{

    public class AppInsightsGetActivityLevelLogsTimerTrigger
    {
        private readonly IOptions<ApplicationOptions> _appOptions;
        private readonly TaskMetaDataDatabase _taskMetaDataDatabase;
        private readonly IHttpClientFactory _httpClientFactory;

        public AppInsightsGetActivityLevelLogsTimerTrigger(IOptions<ApplicationOptions> appOptions, TaskMetaDataDatabase taskMetaDataDatabase, IHttpClientFactory httpClientFactory)
        {
            _appOptions = appOptions;
            _taskMetaDataDatabase = taskMetaDataDatabase;
            _httpClientFactory = httpClientFactory;
        }

        [FunctionName("GetActivityLevelLogs")]
        public void Run([TimerTrigger("0 */5 * * * *")] TimerInfo myTimer, ILogger log, ExecutionContext context)
        {
            Guid executionId = context.InvocationId;

            if (_appOptions.Value.TimerTriggers.EnableGetADFStats)
            {
                FrameworkRunner fr = new FrameworkRunner(log, executionId);
                FrameworkRunnerWorker worker = GetActivityLevelLogsCore;
                FrameworkRunnerResult result = fr.Invoke("GetActivityLevelLogs", worker);
            }
        }

        public dynamic GetActivityLevelLogsCore(Logging.Logging logging)
        {
            string appInsightsWorkspaceId = _appOptions.Value.ServiceConnections.AppInsightsWorkspaceId;
            using var client = _httpClientFactory.CreateClient(HttpClients.AppInsightsHttpClientName);

            using SqlConnection conRead = _taskMetaDataDatabase.GetSqlConnection();

            //Get Last Request Date
            var maxTimesGenQuery = conRead.QueryWithRetry(@"
                                    select max([timestamp]) maxtimestamp from ActivityLevelLogs");        

            foreach (var executionengine in maxTimesGenQuery)
            {
                DateTimeOffset maxAllowedLogTimeGenerated = DateTimeOffset.UtcNow.AddDays(-1*_appOptions.Value.ServiceConnections.AppInsightsMaxNumberOfDaysToRequest);
                DateTimeOffset maxObservedLogTimeGenerated = DateTimeOffset.UtcNow.AddDays(-1*_appOptions.Value.ServiceConnections.AppInsightsMaxNumberOfDaysToRequest);
                if (executionengine.maxtimestamp != null)
                {
                    maxObservedLogTimeGenerated = ((DateTimeOffset)executionengine.maxtimestamp).AddMinutes(-1* _appOptions.Value.ServiceConnections.AppInsightsMinutesOverlap);
                    //Make sure that we don't get more than max to ensure we dont get timeouts etc.
                    if ((maxObservedLogTimeGenerated) <= maxAllowedLogTimeGenerated)
                    {
                        maxObservedLogTimeGenerated = maxAllowedLogTimeGenerated;
                    }
                }
                
                Dictionary<string, object> kqlParams = new Dictionary<string, object>
                {
                    {"MaxLogTimeGenerated", maxObservedLogTimeGenerated.ToString("yyyy-MM-dd HH:mm:ss.ff K") }
                };

                string kql = System.IO.File.ReadAllText(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(), _appOptions.Value.LocalPaths.KQLTemplateLocation, "GetActivityLevelLogs.kql"));
                kql = kql.FormatWith(kqlParams, MissingKeyBehaviour.ThrowException, null, '{', '}');

                JObject jsonContent = new JObject();
                jsonContent["query"] = kql;

                var postContent = new StringContent(jsonContent.ToString(), System.Text.Encoding.UTF8, "application/json");

                var response = client.PostAsync($"https://api.applicationinsights.io/v1/apps/{appInsightsWorkspaceId}/query", postContent).Result;
                if (response.StatusCode == System.Net.HttpStatusCode.OK)
                {
                    //Start to parse the response content
                    HttpContent responseContent = response.Content;
                    var content = response.Content.ReadAsStringAsync().Result;
                    var tables = ((JArray)(JObject.Parse(content)["tables"]));
                    if (tables.Count > 0)
                    {
                        using DataTable dt = new DataTable();

                        var rows = (JArray)(tables[0]["rows"]);
                        var columns = (JArray)(tables[0]["columns"]);
                        foreach (JObject c in columns)
                        {
                            DataColumn dc = new DataColumn();
                            dc.ColumnName = c["name"].ToString();
                            dc.DataType = KustoDataTypeMapper[c["type"].ToString()];
                            dt.Columns.Add(dc);
                        }


                        foreach (JArray r in rows)
                        {
                            DataRow dr = dt.NewRow();
                            for (int i = 0; i < columns.Count; i++)
                            {
                                if (((JValue)r[i]).Value != null)
                                {
                                    dr[i] = ((JValue)r[i]).Value;
                                }
                                else
                                {
                                    dr[i] = DBNull.Value;
                                }
                            }
                            dt.Rows.Add(dr);
                        }

                        SqlTable t = new SqlTable();
                        t.Schema = "dbo";
                        string tableGuid = Guid.NewGuid().ToString();
                        t.Name = "#ActivityLevelLogs{TableGuid}";
                        using (SqlConnection conWrite = _taskMetaDataDatabase.GetSqlConnection())
                        {
                            TaskMetaDataDatabase.BulkInsert(dt, t, true, conWrite);
                            Dictionary<string, string> sqlParams = new Dictionary<string, string>
                            {
                                { "TempTable", t.QuotedSchemaAndName() },
                                { "EngineId", "-1"}
                            };

                            string mergeSql = GenerateSqlStatementTemplates.GetSql(System.IO.Path.Combine(EnvironmentHelper.GetWorkingFolder(),_appOptions.Value.LocalPaths.SQLTemplateLocation), "MergeIntoActivityLevelLogs", sqlParams);
                            logging.LogInformation(mergeSql.ToString());
                            conWrite.ExecuteWithRetry(mergeSql);
                            conWrite.Close();
                            conWrite.Dispose();
                        }

                    }

                    else
                    {
                        logging.LogErrors(new Exception("Kusto query failed getting ADFPipeline Stats."));
                    }
                }
            }

            return new { };

        }


        private static Dictionary<string, Type> KustoDataTypeMapper
        {
            get
            {
                // Add the rest of your CLR Types to SQL Types mapping here
                Dictionary<string, Type> dataMapper = new Dictionary<string, Type>
                    {
                        { "int", typeof(int) },
                        { "string", typeof(string) },
                        { "real", typeof(double) },
                        { "long", typeof(long) },
                        { "datetime", typeof(DateTime) },
                        { "guid", typeof(Guid) }

                    };

                return dataMapper;
            }
        }
    }

 
}







