/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
using AdsGoFast.SqlServer;
using Dapper;
using FormatWith;
using Microsoft.Azure.Management.AppService.Fluent.Models;
using Microsoft.Azure.Management.Compute.Fluent.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Numerics;
using System.Xml;
using static AdsGoFast.TaskMetaData.BaseTasks;

namespace AdsGoFast.TaskMetaData
{

    public class TaskInstance
    {

    }

    public static class TaskInstancesStatic
    {
        /// <summary>
        /// Returns the JSON object representation of TaskInstance as requried by Azure Data Factory
        /// </summary>
        /// <param name="log"></param>
        public static JArray GetActive_ADFJSON(Guid ExecutionUid, short TaskRunnerId, Logging logging)
        {
            TaskMetaDataDatabase TMD = new TaskMetaDataDatabase();
            //Get All Task Instance Objects for the current Framework Task Runner
            IEnumerable<AdsGoFast.GetTaskInstanceJSON.BaseTask> TIs = TMD.GetSqlConnection().Query<AdsGoFast.GetTaskInstanceJSON.BaseTask>(string.Format("Exec [dbo].[GetTaskInstanceJSON] {0}, '{1}'", TaskRunnerId.ToString(), ExecutionUid.ToString()));
            JArray TIsJson = new JArray();

            //Instantiate the Collections that contain the JSON Schemas 
            using TaskTypeMappings ttm = new TaskTypeMappings();
            using SourceAndTargetSystem_JsonSchemas system_schemas = new SourceAndTargetSystem_JsonSchemas();

            //Set up table to Store Invalid Task Instance Objects
            DataTable InvalidTIs = new DataTable();
            InvalidTIs.Columns.Add("ExecutionUid", System.Type.GetType("System.Guid"));
            InvalidTIs.Columns.Add("TaskInstanceId", System.Type.GetType("System.Int64"));
            InvalidTIs.Columns.Add("LastExecutionComment", System.Type.GetType("System.String"));
                      
            foreach (AdsGoFast.GetTaskInstanceJSON.BaseTask TBase in TIs)
            {
                try
                {
                    bool TaskIsValid = true;

                    //Add Task Ids to Logging Object
                    logging.DefaultActivityLogItem.TaskInstanceId = TBase.TaskInstanceId;
                    logging.DefaultActivityLogItem.TaskMasterId = TBase.TaskMasterId;

                    AdsGoFast.GetTaskInstanceJSON.ADFJsonBaseTask T = new GetTaskInstanceJSON.ADFJsonBaseTask(TBase, logging);
                    //Set the base properties using data stored in non-json columns of the database
                    T.CreateJsonObjectForADF(ExecutionUid);
                    JObject Root = T.GetJsonObjectForADF();

                    if (T.ADFPipeline.StartsWith("AZ-Storage-Binary-AZ-Storage-Binary") || T.ADFPipeline.StartsWith("AZ-Storage-Cache-File-List") || T.ADFPipeline == "Cache-File-List-To-Email-Alert" || T.TaskExecutionType == "AF") /*|| T.ADFPipeline.Contains("SQL-AZ-Storage-Parquet") || T.ADFPipeline.Contains("AZ-SQL-StoredProcedure")*/
                    {
                        Root = T.ProcessRoot(ttm,system_schemas);
                        goto FinalTaskValidation;
                    }

                    //Create the Default JSON Objects for data stored in JSON fields in the database
                    JObject TaskMasterJson = new JObject();
                    JObject TaskMasterJSONSource = new JObject();
                    if (Shared.JsonHelpers.IsValidJson(T.TaskMasterJson))
                    {
                        TaskMasterJson = JObject.Parse(T.TaskMasterJson);
                        if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Source", JObject.Parse(T.TaskMasterJson)))
                        {
                            TaskMasterJSONSource = (JObject)TaskMasterJson["Source"];
                        }
                    }
                    JObject TaskMasterJSONTarget = new JObject();
                    if (Shared.JsonHelpers.IsValidJson(T.TaskMasterJson))
                    {
                        TaskMasterJson = JObject.Parse(T.TaskMasterJson);
                        if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Target", JObject.Parse(T.TaskMasterJson)))
                        {
                            TaskMasterJSONTarget = (JObject)TaskMasterJson["Target"];
                        }
                    }
                    JObject TargetSystemJson = new JObject();
                    if (Shared.JsonHelpers.IsValidJson(T.TargetSystemJSON))
                    {
                        TargetSystemJson = JObject.Parse(T.TargetSystemJSON);
                    }
                    JObject SourcesystemJson = new JObject();
                    if (Shared.JsonHelpers.IsValidJson(T.SourceSystemJSON))
                    {
                        SourcesystemJson = JObject.Parse(T.SourceSystemJSON);
                    }

                    /**Start of branching based on specific Source Systems**/
                    JObject Source = new JObject
                    {
                        ["Type"] = T.SourceSystemType
                    };
                    
                    //Source of ADLS or BLOB 
                    if (T.SourceSystemType == "ADLS" || T.SourceSystemType == "Azure Blob" || T.SourceSystemType == "File")
                    {
                        //Properties on Source System
                        Source["SystemId"] = T.SourceSystemId;
                        Source["StorageAccountName"] = T.SourceSystemServer;
                        Source["StorageAccountAccessMethod"] = T.SourceSystemAuthType;

                        //Todo: Check if this is legacy
                        if (Source["StorageAccountAccessMethod"].ToString() == "SASURI")
                        {
                            Source["StorageAccountSASUriKeyVaultSecretName"] = JObject.Parse(T.SourceSystemJSON)["SASUriKeyVaultSecretName"];
                        }
                        Source["StorageAccountContainer"] = JObject.Parse(T.SourceSystemJSON)["Container"];

                        //Properties on Task Master
                        if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Source", JObject.Parse(T.TaskMasterJson)))
                        {
                            Source["DataFileName"] = TaskMasterJSONSource["DataFileName"];
                            Source["SchemaFileName"] = TaskMasterJSONSource["SchemaFileName"];
                            Source["FirstRowAsHeader"] = TaskMasterJSONSource["FirstRowAsHeader"];
                            Source["SheetName"] = TaskMasterJSONSource["SheetName"];
                            Source["SkipLineCount"] = TaskMasterJSONSource["SkipLineCount"];
                            Source["MaxConcorrentConnections"] = TaskMasterJSONSource["MaxConcorrentConnections"];
                            Source["Recursively"] = TaskMasterJSONSource["Recursively"];
                            Source["DeleteAfterCompletion"] = TaskMasterJSONSource["DeleteAfterCompletion"];
                            Source["UserId"] = TaskMasterJSONSource["UserId"];
                            Source["Host"] = TaskMasterJSONSource["Host"];
                            Source["PasswordKeyVaultSecretName"] = TaskMasterJSONSource["PasswordKeyVaultSecretName"];

                            //Cache Azure Storage File List Task Type 
                            if (T.TaskType == "Cache Azure Storage File List")
                            {
                                Source["StorageAccountToken"] = TaskMasterJSONSource["StorageAccountToken"];
                            }

                            //SAS Uri
                            if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Type", TaskMasterJSONSource))
                            {
                                if (TaskMasterJSONSource["Type"].Value<string>() == "SASUri")
                                {
                                    Source["SasURIDaysValid"] = TaskMasterJSONSource["SasURIDaysValid"];
                                    Source["TargetSystemUidInPHI"] = TaskMasterJSONSource["TargetSystemUidInPHI"];
                                    Source["FileUploaderWebAppURL"] = TaskMasterJSONSource["FileUploaderWebAppURL"];
                                }
                            }

                        }

                        //Properties on Task Instance
                        if (T.TaskInstanceJson != "")
                        {
                            Source["RelativePath"] = Shared.JsonHelpers.GetStringValueFromJSON(logging, "SourceRelativePath", JObject.Parse(T.TaskInstanceJson), "", false);
                        }


                    } //End of ADLS, BLOB and File Branch

                    //Source Azure SQL
                    if (T.SourceSystemType == "Azure SQL" || T.SourceSystemType == "SQL Server")
                    {
                        JObject Database = new JObject
                        {
                            //Properties on Source System
                            ["SystemName"] = T.SourceSystemServer,
                            ["Name"] = JObject.Parse(T.SourceSystemJSON)["Database"],
                            ["AuthenticationType"] = T.SourceSystemAuthType
                        };
                        if (Database["AuthenticationType"].ToString() == "Username/Password")
                        {
                            Database["UsernameKeyVaultSecretName"] = JObject.Parse(T.SourceSystemJSON)["UsernameKeyVaultSecretName"];
                            Database["PasswordKeyVaultSecretName"] = JObject.Parse(T.SourceSystemJSON)["PasswordKeyVaultSecretName"];
                        }
                        if (Database["AuthenticationType"].ToString() == "SQLAuth")
                        {
                            Database["Username"] = T.SourceSystemUserName;
                            Database["PasswordKeyVaultSecretName"] = T.SourceSystemSecretName;
                        }
                        Source["Database"] = Database;

                        JObject Extraction = new JObject
                        {
                            ["Type"] = JObject.Parse(T.TaskMasterJson)["Source"]["Type"],
                            ["IncrementalType"] = IncrementalType(JObject.Parse(T.TaskMasterJson)),

                            ["IncrementalField"] = JObject.Parse(T.TaskInstanceJson)["IncrementalField"],
                            ["IncrementalColumnType"] = JObject.Parse(T.TaskInstanceJson)["IncrementalColumnType"]
                        };

                        if (JObject.Parse(T.TaskInstanceJson)["IncrementalColumnType"] != null)
                        {
                            if (JObject.Parse(T.TaskInstanceJson)["IncrementalColumnType"].ToString() == "DateTime")
                            {
                                DateTime _IncrementalValue = (DateTime)JObject.Parse(T.TaskInstanceJson)["IncrementalValue"];
                                Extraction["IncrementalValue"] = _IncrementalValue.ToString("yyyy-MM-dd HH:mm:ss.fff");//JObject.Parse(T.TaskInstanceJson)["IncrementalValue"].ToString();       
                            }
                            else if (JObject.Parse(T.TaskInstanceJson)["IncrementalColumnType"].ToString() == "BigInt")
                            {
                                int _IncrementalValue = (int)JObject.Parse(T.TaskInstanceJson)["IncrementalValue"];
                                Extraction["IncrementalValue"] = _IncrementalValue.ToString();//JObject.Parse(T.TaskInstanceJson)["IncrementalValue"].ToString();
                                
                            }
                        }

                        Extraction["ChunkField"] = JObject.Parse(T.TaskMasterJson)["Source"]["ChunkField"];
                        Extraction["ChunkSize"] = JObject.Parse(T.TaskMasterJson)["Source"]["ChunkSize"];

                        Extraction["TableSchema"] = JObject.Parse(T.TaskMasterJson)["Source"]["TableSchema"];
                        Extraction["TableName"] = JObject.Parse(T.TaskMasterJson)["Source"]["TableName"];

                        Extraction["SQLStatement"] = CreateSQLStatement(JObject.Parse(T.TaskMasterJson), JObject.Parse(T.TaskInstanceJson), logging);

                        Extraction["IncrementalSQLStatement"] = CreateIncrementalSQLStatement(Extraction);

                        Source["Extraction"] = Extraction;

                        JObject Execute = new JObject();
                        if (Shared.JsonHelpers.CheckForJSONProperty(logging, "StoredProcedure", TaskMasterJSONSource))
                        {
                            string _storedProcedure = TaskMasterJSONSource["StoredProcedure"].ToString();
                            if (_storedProcedure.Length > 0)
                            {
                                string _spParameters = string.Empty;
                                if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Parameters", TaskMasterJSONSource))
                                {
                                    _spParameters = TaskMasterJSONSource["Parameters"].ToString();                                        
                                }
                                _storedProcedure = string.Format("Exec {0} {1} {2} {3}", _storedProcedure, _spParameters, Environment.NewLine, " Select 1");

                        }
                            Execute["StoredProcedure"] = _storedProcedure;
                        }
                        Source["Execute"] = Execute;

                    } //End of SQL Source Branch

                    Root["Source"] = Source;

                    //Start of Target Logic Branch
                    JObject Target = new JObject
                    {
                        ["Type"] = T.TargetSystemType
                    };

                    //Send Grid
                    if (T.TargetSystemType == "SendGrid")
                    {
                        Target["EmailRecipient"] = JObject.Parse(T.TaskMasterJson)["Target"]["Email Recipient"];
                        Target["EmailRecipientName"] = JObject.Parse(T.TaskMasterJson)["Target"]["Email Recipient Name"];
                        Target["EmailTemplateFileName"] = JObject.Parse(T.TaskMasterJson)["Target"]["Email Template File Name"];
                        Target["EmailSubject"] = JObject.Parse(T.TaskMasterJson)["Target"]["Email Subject"];
                        Target["SenderEmail"] = JObject.Parse(T.TargetSystemJSON)["SenderEmail"];
                        Target["SenderDescription"] = JObject.Parse(T.TargetSystemJSON)["SenderDescription"];

                    }

                    //Target of ADLS or BLOB
                    if (T.TargetSystemType == "ADLS" || T.TargetSystemType == "Azure Blob")
                    {
                        //Properties on Source System
                        Target["StorageAccountName"] = T.TargetSystemServer;
                        Target["StorageAccountContainer"] = JObject.Parse(T.TargetSystemJSON)["Container"];
                        Target["StorageAccountAccessMethod"] = T.TargetSystemAuthType;
                        if (Target["StorageAccountAccessMethod"].ToString() == "SASURI")
                        {
                            Target["StorageAccountSASUriKeyVaultSecretName"] = JObject.Parse(T.TargetSystemJSON)["SASUriKeyVaultSecretName"];
                        }

                        //Properties on Task Master

                        if (T.TaskType == "Generate Task Masters")
                        {
                            Target["RelativePath"] = null;
                        }
                        else
                        {
                            Target["RelativePath"] = JObject.Parse(T.TaskInstanceJson)["TargetRelativePath"].ToString();
                        }
                        Target["DataFileName"] = JObject.Parse(T.TaskMasterJson)["Target"]["DataFileName"];
                        Target["SchemaFileName"] = JObject.Parse(T.TaskMasterJson)["Target"]["SchemaFileName"];
                        Target["FirstRowAsHeader"] = JObject.Parse(T.TaskMasterJson)["Target"]["FirstRowAsHeader"];
                        Target["SheetName"] = JObject.Parse(T.TaskMasterJson)["Target"]["SheetName"];
                        Target["SkipLineCount"] = JObject.Parse(T.TaskMasterJson)["Target"]["SkipLineCount"];
                        Target["MaxConcorrentConnections"] = JObject.Parse(T.TaskMasterJson)["Target"]["MaxConcorrentConnections"];
                    }

                    //Taget Azure SQL
                    if (T.TargetSystemType == "Azure SQL")
                    {
                        JObject Database = new JObject
                        {
                            //Properties on Target System
                            ["SystemName"] = T.TargetSystemServer,
                            ["AuthenticationType"] = T.TargetSystemAuthType

                        };

                        if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Database", TargetSystemJson))
                        {
                            Database["Name"] = JObject.Parse(T.TargetSystemJSON)["Database"];
                            if (Database["AuthenticationType"].ToString() == "Username/Password")
                            {
                                if (Shared.JsonHelpers.CheckForJSONProperty(logging, "UsernameKeyVaultSecretName", TargetSystemJson) && Shared.JsonHelpers.CheckForJSONProperty(logging, "PasswordKeyVaultSecretName", TargetSystemJson))
                                {
                                    Database["UsernameKeyVaultSecretName"] = TargetSystemJson["UsernameKeyVaultSecretName"];
                                    Database["PasswordKeyVaultSecretName"] = TargetSystemJson["PasswordKeyVaultSecretName"];
                                }
                                else
                                {
                                    MarkTaskAsInvalid(logging, T.TargetSystemId, ExecutionUid, "Target System with id of '{0}' is configured incorrectly. Authentication Type is Username/Password but UsernameKeyVaultSecretName and PasswordKeyVaultSecretName are not properties in SystemJson.", ref TaskIsValid);
                                }
                            }

                        }
                        else
                        {
                            MarkTaskAsInvalid(logging, T.TargetSystemId, ExecutionUid, "Target System with id of '{0}' is configured incorrectly. The Database property is missing from SystemJson.", ref TaskIsValid);
                        }

                        Target["Database"] = Database;

                        //Properties on Task Master
                        if (TaskMasterJson.Properties().Count() > 0)
                        {
                            Shared.JsonHelpers.JsonObjectPropertyList pl_TargetBase = new Shared.JsonHelpers.JsonObjectPropertyList() {
                                    {   "Type"          }
                        };
                        TaskIsValid = Shared.JsonHelpers.BuildJsonObjectWithValidation(logging, ref pl_TargetBase, TaskMasterJson["Target"].ToString(), ref Target);
                            if (TaskIsValid)
                            {
                                if (Target["Type"].Value<string>() == "Table")
                                {
                                    Shared.JsonHelpers.JsonObjectPropertyList pl_SQLTable = new Shared.JsonHelpers.JsonObjectPropertyList() {
                                    {   "Type"          },
                                    {   "TableSchema"   },
                                    {   "TableName"     },
                                    {   "StagingTableSchema" },
                                    {   "StagingTableName" },
                                    {   "AutoCreateTable" },
                                    {   "PreCopySQL" },
                                    {   "PostCopySQL" },
                                    {   "MergeSQL" },
                                    {   "AutoGenerateMerge" },
                                    {   "DynamicMapping", false, false},
                                };

                                TaskIsValid = Shared.JsonHelpers.BuildJsonObjectWithValidation(logging, ref pl_SQLTable, TaskMasterJson["Target"].ToString(), ref Target);

                                }
                            }
                        }
                    }

                    Root["Target"] = Target;

                    if (T.TaskType == "Generate Task Masters")
                    {
                        Root["TaskMasterTemplate"] = JObject.Parse(T.TaskMasterJson);
                    }

                    FinalTaskValidation:
                    if (TaskIsValid)
                    {
                        TIsJson.Add(Root);
                    }
                    else
                    {
                        DataRow dr = InvalidTIs.NewRow();
                        dr["TaskInstanceId"] = T.TaskInstanceId;
                        dr["ExecutionUid"] = ExecutionUid;
                        dr["LastExecutionComment"] = "Task structure is invalid. Check activity level logs for details.";
                        InvalidTIs.Rows.Add(dr);
                    }
                    
                
                } //End Try

                catch (Exception e)
                {
                    logging.LogErrors(e);
                    //ToDo: Convert to bulk insert                    
                    TMD.LogTaskInstanceCompletion(TBase.TaskInstanceId, ExecutionUid, TaskStatus.FailedNoRetry, System.Guid.Empty, "Uncaught error building Task Instance JSON object.");
                    DataRow dr = InvalidTIs.NewRow();
                    dr["TaskInstanceId"] = TBase.TaskInstanceId;
                    dr["ExecutionUid"] = ExecutionUid;
                    dr["LastExecutionComment"] = "Task structure is invalid. Check activity level logs for details.";
                    InvalidTIs.Rows.Add(dr);

                }
            } // End For Each

            //
            foreach (DataRow dr in InvalidTIs.Rows)
            {
                //ToDo: Convert to bulk insert    
                TMD.LogTaskInstanceCompletion(System.Convert.ToInt64(dr["TaskInstanceId"]), ExecutionUid, TaskStatus.FailedNoRetry, System.Guid.Empty, dr["LastExecutionComment"].ToString());
            }

            return TIsJson;
        }


        

        public static void MarkTaskAsInvalid(Logging logging, Int64 TargetSystemId, Guid ExecutionId, string comment, ref bool TaskIsValid)
        {
            Dictionary<string,string> p = new Dictionary<string, string> {
                { "TargetSystemId", TargetSystemId.ToString() },
                { "ExecutionId", ExecutionId.ToString() }
            };

            comment = comment.FormatWith(p);
            logging.LogErrors(new Exception(comment));
            TaskIsValid = false;
        }


        public static string CreateSQLStatement(JObject TaskMasterJSON, JObject TaskInstanceJson, Logging logging)
        {
            string _SQLStatement = "";
            JObject TmSource = (JObject)TaskMasterJSON["Source"];
            if (TaskMasterJSON["Source"]["IncrementalType"] != null)
            {
                JToken _IncrementalType = TaskMasterJSON["Source"]["IncrementalType"];
                JToken _IncrementalField = TaskInstanceJson["IncrementalField"];
                JToken _IncrementalColumnType = TaskInstanceJson["IncrementalColumnType"];
                JToken _ChunkField = TaskMasterJSON["Source"]["ChunkField"];
                JToken _TableSchema = TaskMasterJSON["Source"]["TableSchema"];
                JToken _TableName = TaskMasterJSON["Source"]["TableName"];
                string _ExtractionSQL = Shared.JsonHelpers.GetStringValueFromJSON(logging, "ExtractionSQL", TmSource, "",false);
                dynamic _ChunkSize = Shared.JsonHelpers.GetDynamicValueFromJSON(logging, "ChunkSize", TmSource, "", false);

                //If Extraction SQL Explicitly set then overide _SQLStatement with that explicit value
                if (!string.IsNullOrWhiteSpace(_ExtractionSQL.ToString()))
                {
                    _SQLStatement = _ExtractionSQL.ToString();
                    goto EndOfSQLStatementSet;
                }


                //Chunk branch
                if (TaskMasterJSON["Source"]["ChunkSize"] != null && TaskMasterJSON["Source"]["ChunkSize"].ToString() != "0")
                {
                    if (_IncrementalType.ToString() == "Full" && string.IsNullOrWhiteSpace(TaskMasterJSON["Source"]["ChunkSize"].ToString()))
                    {
                        _SQLStatement = string.Format("SELECT * FROM {0}.{1}", _TableSchema, _TableName);
                    }
                    else if (_IncrementalType.ToString() == "Full" && !string.IsNullOrWhiteSpace(TaskMasterJSON["Source"]["ChunkSize"].ToString()))
                    {
                        _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE CAST({2} AS BIGINT) %  <batchcount> = <item> -1. ", _TableSchema, _TableName, _ChunkField);
                    }
                    else if (_IncrementalType.ToString() == "Watermark" && string.IsNullOrWhiteSpace(TaskMasterJSON["Source"]["ChunkSize"].ToString()))
                    {
                        if (_IncrementalColumnType.ToString() == "DateTime")
                        {
                            DateTime _IncrementalValueDateTime = (DateTime)TaskInstanceJson["IncrementalValue"];
                            _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE {2} > Cast('{3}' as datetime) AND {2} <= Cast('<newWatermark>' as datetime)", _TableSchema, _TableName, _IncrementalField, _IncrementalValueDateTime.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                        }
                        else if (_IncrementalColumnType.ToString() == "BigInt")
                        {
                            int _IncrementalValueBigInt = (int)TaskInstanceJson["IncrementalValue"];
                            _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE {2} > Cast('{3}' as bigint) AND {2} <= cast('<newWatermark>' as bigint)", _TableSchema, _TableName, _IncrementalField, _IncrementalValueBigInt);
                        }
                    }
                    else if (_IncrementalType.ToString() == "Watermark" && !string.IsNullOrWhiteSpace(TaskMasterJSON["Source"]["ChunkSize"].ToString()))
                    {
                        if (_IncrementalColumnType.ToString() == "DateTime")
                        {
                            DateTime _IncrementalValueDateTime = (DateTime)TaskInstanceJson["IncrementalValue"];
                            _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE {2} > Cast('{3}' as datetime) AND {2} <= Cast('<newWatermark>' as datetime) AND CAST({4} AS BIGINT) %  <batchcount> = <item> -1.", _TableSchema, _TableName, _IncrementalField, _IncrementalValueDateTime.ToString("yyyy-MM-dd HH:mm:ss.fff"), _ChunkField);
                        }
                        else if (_IncrementalColumnType.ToString() == "BigInt")
                        {
                            int _IncrementalValueBigInt = (int)TaskInstanceJson["IncrementalValue"];
                            _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE {2} > Cast('{3}' as bigint) AND {2} <= Cast('<newWatermark>' as bigint) AND CAST({4} AS BIGINT) %  <batchcount> = <item> -1.", _TableSchema, _TableName, _IncrementalField, _IncrementalValueBigInt, _ChunkField);
                        }
                    }
                }
                else
                //Non Chunk
                {
                    if (_IncrementalType.ToString() == "Full")
                    {
                        _SQLStatement = string.Format("SELECT * FROM {0}.{1}", _TableSchema, _TableName);
                    }
                    else if (_IncrementalType.ToString() == "Watermark")
                    {
                        if (_IncrementalColumnType.ToString() == "DateTime")
                        {
                            DateTime _IncrementalValueDateTime = (DateTime)TaskInstanceJson["IncrementalValue"];
                            _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE {2} > Cast('{3}' as datetime) AND {2} <= Cast('<newWatermark>' as datetime)", _TableSchema, _TableName, _IncrementalField, _IncrementalValueDateTime.ToString("yyyy-MM-dd HH:mm:ss.fff"));
                        }
                        else if (_IncrementalColumnType.ToString() == "BigInt")
                        {
                            int _IncrementalValueBigInt = (int)TaskInstanceJson["IncrementalValue"];
                            _SQLStatement = string.Format("SELECT * FROM {0}.{1} WHERE {2} > Cast('{3}' as bigint) AND {2} <= cast('<newWatermark>' as bigint)", _TableSchema, _TableName, _IncrementalField, _IncrementalValueBigInt);
                        }
                    }
                }
                
            }

            EndOfSQLStatementSet:
                return _SQLStatement;
        }

        public static string CreateIncrementalSQLStatement(JObject Extraction)
        {
            string _SQLStatement = "";

            if (Extraction["IncrementalType"] != null)
            {

                if (Extraction["IncrementalType"].ToString().ToLower() == "full")
                {
                    _SQLStatement = "";
                }

                if (Extraction["IncrementalType"].ToString().ToLower() == "full-chunk")
                {
                    _SQLStatement = @$"
                       SELECT 
		                    CAST(CEILING(count(*)/{Extraction["ChunkSize"]} + 0.00001) as int) as  batchcount
	                    FROM [{Extraction["TableSchema"]}].[{Extraction["TableName"]}] 
                    ";
                }

                if (Extraction["IncrementalType"].ToString().ToLower() == "watermark" && Extraction["IncrementalColumnType"].ToString().ToLower() == "datetime")
                {
                    _SQLStatement = @$"
                        SELECT 
	                        MAX([{Extraction["IncrementalField"]}]) AS newWatermark
                        FROM 
	                        [{Extraction["TableSchema"]}].[{Extraction["TableName"]}] 
                        WHERE [{Extraction["IncrementalField"]}] > CAST('{Extraction["IncrementalValue"]}' as datetime)
                    ";
                }

                if (Extraction["IncrementalType"].ToString().ToLower() == "watermark" && Extraction["IncrementalColumnType"].ToString().ToLower() != "datetime")
                {
                    _SQLStatement = @$"
                        SELECT 
	                        MAX({Extraction["IncrementalField"]}]) AS newWatermark
                        FROM 
	                        [{Extraction["TableSchema"]}].[{Extraction["TableName"]}] 
                        WHERE [{Extraction["IncrementalField"]}] > {Extraction["IncrementalValue"]}
                    ";
                }

                if (Extraction["IncrementalType"].ToString().ToLower() == "watermark-chunk" && Extraction["IncrementalColumnType"].ToString().ToLower() == "datetime")
                {
                    _SQLStatement = @$"
                        SELECT MAX([{Extraction["IncrementalField"]}]) AS newWatermark, 
		                       CAST(CASE when count(*) = 0 then 0 else CEILING(count(*)/{Extraction["ChunkSize"]} + 0.00001) end as int) as  batchcount
	                    FROM  [{Extraction["TableSchema"]}].[{Extraction["TableName"]}] 
	                    WHERE [{Extraction["IncrementalField"]}] > CAST('{Extraction["IncrementalValue"]}' as datetime)
                    ";
                }

                if (Extraction["IncrementalType"].ToString().ToLower() == "watermark-chunk" && Extraction["IncrementalColumnType"].ToString().ToLower() != "datetime")
                {
                    _SQLStatement = @$"
                        SELECT MAX([{Extraction["IncrementalField"]}]) AS newWatermark, 
		                       CAST(CASE when count(*) = 0 then 0 else CEILING(count(*)/{Extraction["ChunkSize"]} + 0.00001) end as int) as  batchcount
	                    FROM  [{Extraction["TableSchema"]}].[{Extraction["TableName"]}] 
	                    WHERE [{Extraction["IncrementalField"]}] > {Extraction["IncrementalValue"]}
                    ";
                }

            }

            return _SQLStatement;
        }

        public static string IncrementalType(JObject JSONValue)
        {
            string _Type = "";
            if (JSONValue["Source"]["IncrementalType"] != null)
            {
                JToken _IncrementalType = JSONValue["Source"]["IncrementalType"];

                if (JSONValue["Source"]["ChunkSize"] != null)
                {
                    if (_IncrementalType.ToString() == "Full" && (string.IsNullOrWhiteSpace(JSONValue["Source"]["ChunkSize"].ToString()) || JSONValue["Source"]["ChunkSize"].ToString() == "0"))
                    {
                        _Type = "Full";
                    }
                    else if (_IncrementalType.ToString() == "Full" && !string.IsNullOrWhiteSpace(JSONValue["Source"]["ChunkSize"].ToString()) && JSONValue["Source"]["ChunkSize"].ToString() != "0")
                    {
                        _Type = "Full-Chunk";
                    }
                    else if (_IncrementalType.ToString() == "Watermark" && string.IsNullOrWhiteSpace(JSONValue["Source"]["ChunkSize"].ToString()))
                    {
                        _Type = "Watermark";
                    }
                    else if (_IncrementalType.ToString() == "Watermark" && !string.IsNullOrWhiteSpace(JSONValue["Source"]["ChunkSize"].ToString()))
                    {
                        _Type = "Watermark-Chunk";
                    }
                }
                else
                {
                    _Type = _IncrementalType.ToString();
                }


            }

            return _Type;
        }

        public static string TransformRelativePath(string RelativePath, DateTime ExecutionDateTime)
        {
            //Replace YYYY
            string _RelativePath = RelativePath.Replace("{yyyy}", ExecutionDateTime.Year.ToString());

            //Replace MMM
            _RelativePath = _RelativePath.Replace("{MM}", ExecutionDateTime.Month.ToString());

            //Replace DD
            _RelativePath = _RelativePath.Replace("{dd}", ExecutionDateTime.Day.ToString());

            //Replace HH
            _RelativePath = _RelativePath.Replace("{hh}", ExecutionDateTime.Hour.ToString());

            //Replace HH
            _RelativePath = _RelativePath.Replace("{mm}", ExecutionDateTime.Minute.ToString());

            return _RelativePath;
        }

        public static string TransformParquetFileColName(string FieldName)
        {
            //Replace space
            string _fieldName = string.Concat(FieldName.Where(c => !char.IsWhiteSpace(c)));

            //Remove Special characters
            _fieldName = string.Concat(_fieldName.Select(c => "*!'\",_&#^@?".Contains(c) ? "" : c.ToString()));

            return _fieldName;
        }

        /// <summary>
        /// 
        /// https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql-server-data-type-mappings?redirectedfrom=MSDN
        /// </summary>
        /// <param name="DataType"></param>
        /// <returns></returns>
        public static string TransformSQLTypesToDotNetFramework(string DataType)
        {

            switch (DataType)
            {
                case "bigint": return "Int64";
                case "binary": return "Byte[]";
                case "bit": return "Boolean";
                case "char": return "String";
                case "date": return "DateTime";
                case "datetime": return "DateTime";
                case "datetime2": return "DateTime";
                case "datetimeoffset": return "DateTimeOffset";
                case "decimal": return "Decimal";
                case "FILESTREAM attribute (varbinary(max))": return "Byte[]";
                case "float": return "Double";
                case "image": return "Byte[]";
                case "int": return "Int32";
                case "money": return "Decimal";
                case "nchar": return "String";
                case "ntext": return "String";
                case "numeric": return "Decimal";
                case "nvarchar": return "String";
                case "real": return "Single";
                case "rowversion": return "Byte[]";
                case "smalldatetime": return "DateTime";
                case "smallint": return "Int16";
                case "smallmoney": return "Decimal";
                case "text": return "String";
                case "time": return "TimeSpan";
                case "timestamp": return "Byte[]";
                case "tinyint": return "Byte";
                case "uniqueidentifier": return "Guid";
                case "varbinary": return "Byte[]";
                case "varchar": return "String";
                case "xml": return "Xml";

                default:
                    throw new Exception(DataType.ToString() + " conversion not implemented. Please add conversion logic to TransformSQLTypesToDotNetFramework");
            }
        }

        /// <summary>
        /// 
        /// https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql-server-data-type-mappings?redirectedfrom=MSDN
        /// </summary>
        /// <param name="DataType"></param>
        /// <returns></returns>
        public static string TransformDotNetFrameworTypeToSQL(string DataType)
        {

            switch (DataType)
            {
                case "Int64": return "bigint";
                case "Byte[]": return "binary";
                case "Boolean": return "bit";
                case "DateTime": return "datetime2";
                case "DateTimeOffset": return "datetimeoffset";
                case "Decimal": return "decimal";
                case "Double": return "float";
                case "Int32": return "int";
                case "String": return "nvarchar";
                case "Single": return "real";
                case "Int16": return "smallint";
                case string s when s.StartsWith("Object*"): return "sql_variant";
                case "TimeSpan": return "time";
                case "Byte": return "tinyint";
                case "Guid": return "uniqueidentifier";
                case "Xml": return "xml";

                default:
                    throw new Exception(DataType.ToString() + " conversion not implemented. Please add conversion logic to TransformDotNetFrameworTypeToSQL");
            }
        }

        /// <summary>
        /// 
        /// https://drill.apache.org/docs/parquet-format/#sql-types-to-parquet-logical-types
        /// https://docs.microsoft.com/en-us/azure/data-factory/supported-file-formats-and-compression-codecs-legacy
        /// </summary>
        /// <param name="DataType"></param>
        /// <returns></returns>
        public static string TransformSQLTypesToParquet(string DataType)
        {

            switch (DataType)
            {
                case "bigint": return "Int64";
                case "binary": return "Binary";
                case "bit": return "Boolean";
                case "char": return "UTF8";
                case "nchar": return "UTF8";
                case "ntext": return "UTF8";
                case "nvarchar": return "UTF8";
                case "text": return "UTF8";
                case "varchar": return "UTF8";
                case "date": return "Int96";
                case "datetime": return "Int96";
                case "datetime2": return "Int96";
                case "datetimeoffset": return "Int96";
                case "smalldatetime": return "Int96";
                case "time": return "TIME_MILLIS";
                case "timestamp": return "TIMESTAMP_MILLIS";
                case "decimal": return "DECIMAL";
                case "money": return "DECIMAL";
                case "numeric": return "DECIMAL";
                case "smallmoney": return "DECIMAL";
                case "float": return "DECIMAL";
                case "image": return "Binary";
                case "int": return "INT32";
                case "real": return "DECIMAL";
                case "rowversion": return "Binary";
                case "smallint": return "INT16";
                case "tinyint": return "INT8";
                case "uniqueidentifier": return "Binary";
                case "varbinary": return "Binary";
                case "xml": return "Binary";

                default:
                    throw new Exception(DataType.ToString() + " conversion not implemented. Please add conversion logic to TransformSQLTypesToParquet");
            }
        }
    }

    public class BaseTasks
    {
        

        public class TaskMaster
        {
            public ScheduleMaster Schedule { get; set; }
        }

        public class TaskInstance
        {
            public TaskMaster Master { get; set; }
            public ScheduleInstance Schedule { get; set; }

            private List<TaskInstanceExecution> Executions { get; set; }

            public TaskStatus Status { get; set; }

            public TaskType Type { get; set; }
        }

        public class TaskInstanceExecution
        {
            public DateTime ExecutedDate { get; set; }
            public string ExecutionCommment { get; set; }
            public TaskStatus ExecutionStatus { get; set; }

        }

        public enum TaskStatus { Untried, Complete, FailedRetry, FailedNoRetry, Expired}

        public enum TaskType { EmailReport }

        public class ScheduleMaster
        {
            public ScheduleIntervalTypes Type { get; set; }

            public int ScheduleMasterPkey { get; set; }

            public string UniqueName { get; set; }

            public string Description { get; set; }
            public DateTime StartDate { get; set; }

        }

        public class ScheduleInstance
        {
            public void SetMasterFromPKey(int ScheduleMasterPkey)
            {

            }
            public ScheduleMaster Master { get; set; }

            public DateTime ScheduledDate { get; set; }

        }

        public enum ScheduleIntervalTypes { Minute, Hour, Day, Week, Month, Year }
    }
}

