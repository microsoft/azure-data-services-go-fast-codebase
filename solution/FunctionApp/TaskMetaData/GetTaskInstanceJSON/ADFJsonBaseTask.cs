/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
using Dapper;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Text;
using System.Reflection;
using Namotion.Reflection;

namespace AdsGoFast.GetTaskInstanceJSON
{
   
    /// <summary>
    /// Handles creation of Base Object that needs to be sent to ADF or AF includes internal properties etc that are not in the POCO
    /// </summary>
    partial class ADFJsonBaseTask : BaseTask
    {
        private Logging logging { get; set; }

        private JObject _JsonObjectForADF { get; set; }
        private JObject _TaskMasterJson { get; set; }
        private JObject _SourceSystemJson { get; set; }
        private JObject _TargetSystemJson { get; set; }
        private JObject _TaskMasterJsonSource { get; set; }
        private JObject _TaskMasterJsonTarget { get; set; }
        private JObject _TaskInstanceJson { get; set; }

        private bool _TaskIsValid { get; set; }

        public ADFJsonBaseTask(BaseTask T, Logging logging)
        {
            this.logging = logging;
            foreach (PropertyInfo SourcePropertyInfo in T.GetType()
                                .GetProperties(
                                        BindingFlags.Public
                                        | BindingFlags.Instance))
            {                
                PropertyInfo TargetPropertyInfo = this.GetType().GetProperty(SourcePropertyInfo.Name, BindingFlags.Public | BindingFlags.Instance);
                if (null != TargetPropertyInfo && TargetPropertyInfo.CanWrite)
                {
                    TargetPropertyInfo.SetValue(this, SourcePropertyInfo.GetValue(T), null);
                }
            }
        }

        /// <summary>
        /// Adds the default attributes common across all task types
        /// </summary>
        /// <param name="ExecutionUid"></param>
        public void CreateJsonObjectForADF(Guid ExecutionUid)
        {
            _JsonObjectForADF = new JObject
            {
                ["TaskInstanceId"] = this.TaskInstanceId,
                ["TaskMasterId"] = this.TaskMasterId,
                ["TaskStatus"] = this.TaskStatus,
                ["TaskType"] = this.TaskType,
                ["Enabled"] = 1,
                ["ExecutionUid"] = ExecutionUid,
                ["NumberOfRetries"] = this.NumberOfRetries,
                ["DegreeOfCopyParallelism"] = this.DegreeOfCopyParallelism,
                ["KeyVaultBaseUrl"] = this.SourceKeyVaultBaseUrl == null ? this.TargetKeyVaultBaseUrl : this.SourceKeyVaultBaseUrl,
                ["ScheduleMasterId"] = this.ScheduleMasterId,
                ["TaskGroupConcurrency"] = this.TaskGroupConcurrency,
                ["TaskGroupPriority"] = this.TaskGroupPriority,
                ["TaskExecutionType"] = this.TaskExecutionType
            };

            JObject DataFactory = new JObject
            {
                ["Id"] = this.DataFactoryId,
                ["Name"] = this.DataFactoryName,
                ["ResourceGroup"] = this.DataFactoryResourceGroup,
                ["SubscriptionId"] = this.DataFactorySubscriptionId,
                ["ADFPipeline"] = this.ADFPipeline,
                ["TaskDatafactoryIR"] = this.TaskDatafactoryIR
            };
            _JsonObjectForADF["DataFactory"] = DataFactory;           

        }

        public JObject GetJsonObjectForADF()
        {
            return _JsonObjectForADF;
        }

        public void CreateInternalObjectsForProcessingJsonFields()
        {
            this._TaskMasterJson = new JObject();

            this._TaskMasterJsonSource = new JObject();
            if (Shared.JsonHelpers.IsValidJson(this.TaskMasterJson))
            {
                _TaskMasterJson = JObject.Parse(this.TaskMasterJson);
                if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Source", JObject.Parse(this.TaskMasterJson)))
                {
                    _TaskMasterJsonSource = (JObject)_TaskMasterJson["Source"];
                }
            }

            this._TaskMasterJsonTarget = new JObject();            
            if (Shared.JsonHelpers.IsValidJson(this.TaskMasterJson))
            {
                _TaskMasterJson = JObject.Parse(this.TaskMasterJson);
                if (Shared.JsonHelpers.CheckForJSONProperty(logging, "Target", JObject.Parse(this.TaskMasterJson)))
                {
                    _TaskMasterJsonTarget = (JObject)_TaskMasterJson["Target"];
                }
            }

            _TargetSystemJson = new JObject();
            if (Shared.JsonHelpers.IsValidJson(this.TargetSystemJSON))
            {
                _TargetSystemJson = JObject.Parse(this.TargetSystemJSON);
            }

            _SourceSystemJson = new JObject();
            if (Shared.JsonHelpers.IsValidJson(this.SourceSystemJSON))
            {
                _SourceSystemJson = JObject.Parse(this.SourceSystemJSON);
            }


            _TaskInstanceJson = new JObject();
            if (Shared.JsonHelpers.IsValidJson(this.TaskInstanceJson))
            {
                _TaskInstanceJson = JObject.Parse(this.TaskInstanceJson);
            }
        }


        //Processing Core ***/
        public JObject ProcessRoot(TaskTypeMappings ttm,SourceAndTargetSystem_JsonSchemas system_schemas)
        {
            CreateInternalObjectsForProcessingJsonFields();
            ProcessSourceSystem(system_schemas);
            ProcessTargetSystem(system_schemas);
            ProcessTaskInstance(ttm);
            ProcessTaskMaster(ttm);
            return _JsonObjectForADF; 

        }

        /***** Process Source *****/
        public void ProcessSourceSystem(SourceAndTargetSystem_JsonSchemas schemas)
        {
            bool Processed = false;
            JObject Source = new JObject
            {
                ["Type"] = this.SourceSystemType
            };
            //Validate SourceSystemJson based on JSON Schema
            string sourcesystem_schema = schemas.GetBySystemType(this.SourceSystemType).JsonSchema;
            _TaskIsValid = Shared.JsonHelpers.ValidateJsonUsingSchema(logging, sourcesystem_schema, this.SourceSystemJSON, "Failed to validate SourceSystem JSON for System Type: " + this.SourceSystemType + ". ");


            if (SourceSystemType == "ADLS" || SourceSystemType == "Azure Blob" || SourceSystemType == "File")
            {
                ProcessSourceSystem_TypeIsStorage(ref Source);
                Processed = true;
            }

            if (SourceSystemType == "Azure SQL" || SourceSystemType == "SQL Server")
            {
                ProcessSourceSystem_TypeIsSQL(ref Source);
                Processed = true;
            }

            if (!Processed)
            {
                ProcessSourceSystem_Default(ref Source);                
            }
            _JsonObjectForADF["Source"] = Source;

        }

        public void ProcessSourceSystem_Default(ref JObject Source)
        {          
            Source.Merge(_SourceSystemJson, new JsonMergeSettings
            {
                // union array values together to avoid duplicates
                MergeArrayHandling = MergeArrayHandling.Union
            });                      
        }
        

        public void ProcessSourceSystem_TypeIsStorage(ref JObject Source)
        {
            AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsStorage SourceSystemObject = JsonConvert.DeserializeObject<AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsStorage>(JsonConvert.SerializeObject(_SourceSystemJson));

            //Properties on Source System
            Source["SystemId"] = this.SourceSystemId;
            Source["StorageAccountName"] = this.SourceSystemServer;
            Source["StorageAccountAccessMethod"] = this.SourceSystemAuthType;
            if (Source["StorageAccountAccessMethod"].ToString() == "SASURI")
            {
                //ToDo Raise error if null
                Source["StorageAccountSASUriKeyVaultSecretName"] = SourceSystemObject.SASUriKeyVaultSecretName;
            }
            Source["StorageAccountContainer"] = SourceSystemObject.Container;

        }

        public void ProcessSourceSystem_TypeIsSQL(ref JObject Source)
        {
            AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsSQL SourceSystemObject = JsonConvert.DeserializeObject<AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsSQL>(JsonConvert.SerializeObject(_SourceSystemJson));

            JObject Database = new JObject
            {
                //Properties on Source System
                ["SystemName"] = this.SourceSystemServer,
                ["Name"] = SourceSystemObject.Database,
                ["AuthenticationType"] = this.SourceSystemAuthType
            };
            if (Database["AuthenticationType"].ToString() == "Username/Password")
            {
                //ToDo Raise Error if these are null
                Database["UsernameKeyVaultSecretName"] = SourceSystemObject.UsernameKeyVaultSecretName;
                Database["PasswordKeyVaultSecretName"] = SourceSystemObject.PasswordKeyVaultSecretName;
            }
            if (Database["AuthenticationType"].ToString() == "SQLAuth")
            {
                //ToDo Raise Error if these are null
                Database["Username"] = this.SourceSystemUserName;
                Database["PasswordKeyVaultSecretName"] = this.SourceSystemSecretName;
            }

            Source["Database"] = Database;

        }


        /***** Process Target *****/
        public void ProcessTargetSystem(SourceAndTargetSystem_JsonSchemas schemas)
        {
            JObject Target = new JObject
            {
                ["Type"] = this.TargetSystemType
            };
            //Validate SourceSystemJson based on JSON Schema
            string targetsystem_schema = schemas.GetBySystemType(this.TargetSystemType).JsonSchema;
            _TaskIsValid = Shared.JsonHelpers.ValidateJsonUsingSchema(logging, targetsystem_schema, this.TargetSystemJSON, "Failed to validate TargetSystem JSON for System Type: " + this.TargetSystemId + ". ");

            if (TargetSystemType == "ADLS" || TargetSystemType == "Azure Blob" || TargetSystemType == "File")
            {
                ProcessTargetSystem_TypeIsStorage(ref Target);
                goto ProcessTargetSystemEnd;
            }

            if (TargetSystemType == "Azure SQL" || TargetSystemType == "SQL Server")
            {
                ProcessTargetSystem_TypeIsSQL(ref Target);
                goto ProcessTargetSystemEnd;
            }
        
            //Default Processing Branch
            Target.Merge(_TargetSystemJson, new JsonMergeSettings
            {
                // union array values together to avoid duplicates
                MergeArrayHandling = MergeArrayHandling.Union
            });

            ProcessTargetSystemEnd:
                _JsonObjectForADF["Target"] = Target;

        }

        public void ProcessTargetSystem_TypeIsStorage(ref JObject Target)
        {
            AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsStorage TargetSystemObject = JsonConvert.DeserializeObject<AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsStorage>(JsonConvert.SerializeObject(_TargetSystemJson));

            //Properties on Source System
            Target["SystemId"] = this.TargetSystemId;
            Target["StorageAccountName"] = this.TargetSystemServer;
            Target["StorageAccountAccessMethod"] = this.TargetSystemAuthType;
            if (Target["StorageAccountAccessMethod"].ToString() == "SASURI")
            {
                //ToDo Raise error if null
                Target["StorageAccountSASUriKeyVaultSecretName"] = TargetSystemObject.SASUriKeyVaultSecretName;
            }
            Target["StorageAccountContainer"] = TargetSystemObject.Container;

        }

        public void ProcessTargetSystem_TypeIsSQL(ref JObject Target)
        {
            AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsSQL TargetSystemObject = JsonConvert.DeserializeObject<AdsGoFast.GetTaskInstanceJSON.SystemJson.TypeIsSQL>(JsonConvert.SerializeObject(_TargetSystemJson));

            JObject Database = new JObject
            {
                //Properties on Source System
                ["SystemName"] = this.TargetSystemServer,
                ["Name"] = TargetSystemObject.Database,
                ["AuthenticationType"] = this.TargetSystemAuthType
            };
            if (Database["AuthenticationType"].ToString() == "Username/Password")
            {
                //ToDo Raise Error if these are null
                Database["UsernameKeyVaultSecretName"] = TargetSystemObject.UsernameKeyVaultSecretName;
                Database["PasswordKeyVaultSecretName"] = TargetSystemObject.PasswordKeyVaultSecretName;
            }
            if (Database["AuthenticationType"].ToString() == "SQLAuth")
            {
                //ToDo Raise Error if these are null
                Database["Username"] = this.TargetSystemUserName;
                Database["PasswordKeyVaultSecretName"] = this.TargetSystemSecretName;
            }

            Target["Database"] = Database;

        }

    }

    //Generates the JSON array that needs to be iterated 
    class ADFJsonArray : IDisposable
    {
        private Logging logging { get; set; }
        private Guid ExecutionUid { get; set; }
        private short TaskRunnerId { get; set; }

        private DataTable InvalidTIs { get; set; }
        private IEnumerable<AdsGoFast.GetTaskInstanceJSON.BaseTask> TIs { get; set; }

        private JArray TIsJson {get; set;}

        public ADFJsonArray(Guid _ExecutionUid, short _TaskRunnerId, Logging _logging)
        {
            this.logging = _logging;
            this.ExecutionUid = _ExecutionUid;
            this.TaskRunnerId = _TaskRunnerId;

            TaskMetaDataDatabase TMD = new TaskMetaDataDatabase();
            //Get All Task Instance Objects for the current Framework Task Runner
            this.TIs = TMD.GetSqlConnection().Query<AdsGoFast.GetTaskInstanceJSON.BaseTask>(string.Format("Exec [dbo].[GetTaskInstanceJSON] {0}", TaskRunnerId.ToString()));
            this.TIsJson = new JArray();

            //Instantiate the Collections that contain the JSON Schemas 
            using TaskTypeMappings ttm = new TaskTypeMappings();
            using SourceAndTargetSystem_JsonSchemas system_schemas = new SourceAndTargetSystem_JsonSchemas();


            //Set up table to Store Invalid Task Instance Objects
            this.InvalidTIs = new DataTable();
            InvalidTIs.Columns.Add("ExecutionUid", System.Type.GetType("System.Guid"));
            InvalidTIs.Columns.Add("TaskInstanceId", System.Type.GetType("System.Int64"));
            InvalidTIs.Columns.Add("LastExecutionComment", System.Type.GetType("System.String"));

            foreach (AdsGoFast.GetTaskInstanceJSON.BaseTask TBase in TIs)
            {
                try
                {
                    bool TaskIsValid = true;
                    //Cast Raw Database Result into Base Class for ADF Json Creation
                    ADFJsonBaseTask T = (ADFJsonBaseTask)(TBase);
                    //T.logging = logging;

                    //Set the base properties using data stored in non-json columns of the database
                    T.CreateJsonObjectForADF(ExecutionUid);

                    JObject Root = T.GetJsonObjectForADF();

                    T.CreateInternalObjectsForProcessingJsonFields();

                    T.ProcessSourceSystem(system_schemas);

                    T.ProcessTargetSystem(system_schemas);

                    T.ProcessTaskMaster(ttm);


                }
                catch (Exception e)
                {

                }
            }
        }


        public void Dispose()
        {
            //ToDo Add Internal Object Disposal 
        }
    }
}
