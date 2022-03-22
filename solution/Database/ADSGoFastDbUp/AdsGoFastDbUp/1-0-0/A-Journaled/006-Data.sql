SET IDENTITY_INSERT [dbo].[ExecutionEngine] ON 
GO
INSERT [dbo].[ExecutionEngine] ([EngineId], [EngineName], [SystemType], [ResourceGroup], [SubscriptionUid], [DefaultKeyVaultURL], [EngineJson], [LogAnalyticsWorkspaceId]) VALUES (-2, N'Synapse', 'Synapse', N'placeholdeResourceGroup', N'00000000-0000-0000-0000-000000000000', N'https://$KeyVaultName$.vault.azure.net/', N'
{
    "endpoint": "placeholderendpoint"
}
', N'00000000-0000-0000-0000-000000000000')
GO
INSERT [dbo].[ExecutionEngine] ([EngineId], [EngineName], [SystemType], [ResourceGroup], [SubscriptionUid], [DefaultKeyVaultURL], [EngineJson], [LogAnalyticsWorkspaceId]) VALUES (-1, N'Datafactory', 'Datafactory', N'placeholdeResourceGroup', N'00000000-0000-0000-0000-000000000000', N'https://$KeyVaultName$.vault.azure.net/', N'
{}
', N'00000000-0000-0000-0000-000000000000')
GO
SET IDENTITY_INSERT [dbo].[ExecutionEngine] OFF
GO
INSERT [dbo].[ExecutionEngine_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Datafactory', N'
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {},
    "required": []
}')
GO
INSERT [dbo].[ExecutionEngine_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Synapse', N'
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {
        "endpoint": {
            "type": "string"
        }
    },
    "required": [
        "endpoint"
    ]
}
')
GO
INSERT [dbo].[FrameworkTaskRunner] ([TaskRunnerId], [TaskRunnerName], [ActiveYN], [Status], [MaxConcurrentTasks], [LastExecutionStartDateTime], [LastExecutionEndDateTime]) VALUES (1, N'Runner 1', 1, N'Idle', NULL, CAST(N'2022-03-03T03:06:02.0166667+00:00' AS DateTimeOffset), CAST(N'2022-03-03T03:06:17.3433333+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FrameworkTaskRunner] ([TaskRunnerId], [TaskRunnerName], [ActiveYN], [Status], [MaxConcurrentTasks], [LastExecutionStartDateTime], [LastExecutionEndDateTime]) VALUES (2, N'Runner 2', 1, N'Idle', NULL, CAST(N'2022-03-03T03:06:02.0166667+00:00' AS DateTimeOffset), CAST(N'2022-03-03T03:06:17.3433333+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FrameworkTaskRunner] ([TaskRunnerId], [TaskRunnerName], [ActiveYN], [Status], [MaxConcurrentTasks], [LastExecutionStartDateTime], [LastExecutionEndDateTime]) VALUES (3, N'Runner 3', 1, N'Idle', NULL, CAST(N'2022-03-03T03:06:02.0166667+00:00' AS DateTimeOffset), CAST(N'2022-03-03T03:06:17.3433333+00:00' AS DateTimeOffset))
GO
INSERT [dbo].[FrameworkTaskRunner] ([TaskRunnerId], [TaskRunnerName], [ActiveYN], [Status], [MaxConcurrentTasks], [LastExecutionStartDateTime], [LastExecutionEndDateTime]) VALUES (4, N'Runner 4', 1, N'Idle', NULL, CAST(N'2022-03-03T03:06:02.0166667+00:00' AS DateTimeOffset), CAST(N'2022-03-03T03:06:17.3433333+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[IntegrationRuntime] ON 
GO
INSERT [dbo].[IntegrationRuntime] ([IntegrationRuntimeId], [IntegrationRuntimeName], [EngineId], [ActiveYN]) VALUES (1, N'Azure', 1, 1)
GO
INSERT [dbo].[IntegrationRuntime] ([IntegrationRuntimeId], [IntegrationRuntimeName], [EngineId], [ActiveYN]) VALUES (2, N'OnPrem', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[IntegrationRuntime] OFF
GO
SET IDENTITY_INSERT [dbo].[ScheduleMaster] ON 
GO
INSERT [dbo].[ScheduleMaster] ([ScheduleMasterId], [ScheduleCronExpression], [ScheduleDesciption], [ActiveYN]) VALUES (-5, N'0 0 1 */3 * *', N'At 00:00 on day-of-month 1 in every 3rd month', 1)
GO
INSERT [dbo].[ScheduleMaster] ([ScheduleMasterId], [ScheduleCronExpression], [ScheduleDesciption], [ActiveYN]) VALUES (-4, N'N/A', N'Run Once Only', 1)
GO
INSERT [dbo].[ScheduleMaster] ([ScheduleMasterId], [ScheduleCronExpression], [ScheduleDesciption], [ActiveYN]) VALUES (-3, N'0 * * * * *', N'Every Minute', 1)
GO
INSERT [dbo].[ScheduleMaster] ([ScheduleMasterId], [ScheduleCronExpression], [ScheduleDesciption], [ActiveYN]) VALUES (-2, N'0 0 * * * *', N'Every Hour', 1)
GO
INSERT [dbo].[ScheduleMaster] ([ScheduleMasterId], [ScheduleCronExpression], [ScheduleDesciption], [ActiveYN]) VALUES (-1, N'* * * * * *', N'Every Second', 1)
GO
SET IDENTITY_INSERT [dbo].[ScheduleMaster] OFF
GO
SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON 
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-16, 'N/A', 'N/A', 'N/A', 'N/A', N'MSI', NULL, NULL, 'N/A', N'{}', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-15, N'Sample - File Server ', N'FileServer', N'Sample File Server Source', N'(local)', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{}', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-14, N'Sample - External SQL Server ', N'Azure SQL', N'Sample Azure SQL Server Source', N'(local)', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{         "Database" : "msdb"  , "Username" : "adminuser", "PasswordKeyVaultSecretName":"selfhostedsqlpw"   }', 1, 1, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-10, N'Sample - Azure Synapse ', N'Azure Synapse', N'Sample Azure Synapse Source', N'arkstgsynwadsbcar.database.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Workspace" : "Dummy" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-9, N'arkstgdlsadsbcarblob\transientin', N'Azure Blob', N'Azure Data Lake - ADS Go Fast TransientIn Container', N'https://arkstgdlsadsbcarblob.blob.core.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Container" : "transientin" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-8, N'arkstgdlsadsbcaradsl\datalakelanding', N'ADLS', N'Azure Data Lake - ADS Go Fast DataLakeLandingZone Container', N'https://arkstgdlsadsbcaradsl.dfs.core.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Container" : "datalakelanding" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-7, N'arkstgdlsadsbcarblob\datalakelanding', N'Azure Blob', N'Azure Blob - ADS Go Fast DataLakeLandingZone Container', N'https://arkstgdlsadsbcarblob.blob.core.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Container" : "datalakelanding" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-4, N'arkstgdlsadsbcaradsl\datalakeraw', N'ADLS', N'Azure Data Lake - ADS Go Fast DataLakeLRaw Container', N'https://arkstgdlsadsbcaradsl.dfs.core.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Container" : "datalakeraw" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-3, N'arkstgdlsadsbcarblob\datalakeraw', N'Azure Blob', N'Azure Blob - ADS Go Fast DataLakeLRaw Container', N'https://arkstgdlsadsbcarblob.blob.core.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Container" : "datalakeraw" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-2, N'ark-stg-sql-ads-bcar\Staging', N'Azure SQL', N'Azure SQL Database - ADS Go Fast Staging Db', N'ark-stg-sql-ads-bcar.database.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Database" : "Staging" }', 1, 0, NULL)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-1, N'ark-stg-sql-ads-bcar\Samples', N'Azure SQL', N'Azure SQL Database - ADS Go Fast Samples Db', N'ark-stg-sql-ads-bcar.database.windows.net', N'MSI', NULL, NULL, N'https://ark-stg-kv-ads-bcar.vault.azure.net/', N'{ "Database" : "Samples" }', 1, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'N/A', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {},  "required": []}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'ADLS', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Container": {      "type": "string"    }  },  "required": [    "Container"  ]}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Azure Blob', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Container": {      "type": "string"    }  },  "required": [    "Container"  ]}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Azure SQL', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Database": {      "type": "string"    }  },  "required": [    "Database"  ]}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Azure Synapse', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Workspace": {      "type": "string"    }  },  "required": [    "Workspace"  ]}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'AzureVM', N'{     "$schema": "http://json-schema.org/draft-04/schema#",     "type": "object",     "properties": {         "SubscriptionUid": {             "type": "string"         },         "VMname": {           "type": "string"       },       "ResourceGroup": {         "type": "string"     }     },     "required": [         "SubscriptionUid",         "VMname",         "ResourceGroup"      ] }')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'SendGrid', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "SenderEmail": {      "type": "string"    },    "SenderDescription": {      "type": "string"    }  },  "required": [    "SenderEmail",    "SenderDescription"  ]}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'SQL Server', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Database": {      "type": "string"    }  },  "required": [    "Database"  ]}')
GO
INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'FileServer', N'{ }')
GO
SET IDENTITY_INSERT [dbo].[SubjectArea] ON 
GO
INSERT [dbo].[SubjectArea] ([SubjectAreaId], [SubjectAreaName], [ActiveYN], [SubjectAreaFormId], [DefaultTargetSchema], [UpdatedBy]) VALUES (1, N'Sample Subject Area', 1, NULL, N'N/A', N'system@microsoft.com')
GO
SET IDENTITY_INSERT [dbo].[SubjectArea] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskGroup] ON 
GO
INSERT [dbo].[TaskGroup] ([TaskGroupId], [SubjectAreaId], [TaskGroupName], [TaskGroupPriority], [TaskGroupConcurrency], [TaskGroupJSON], [MaximumTaskRetries], [ActiveYN]) VALUES (10, 1, N'Sample Task Group', 0, 10, N'{}', 3, 1)
GO
SET IDENTITY_INSERT [dbo].[TaskGroup] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskMaster] ON 
GO
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) VALUES (-206, N'Excel Import NY Taxi Data into DelimitedText', -2, 10, -2, -3, -3, 1, 0, N'Azure', N'
{
    "Source": {
        "Type": "Excel",               
        "RelativePath": "/",
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SheetName": "AFS_LIC_202006"
    },
    "Target": {
        "Type": "Csv",
        "RelativePath": "/",
        "DataFileName": "yellow_tripdata_2017-03_converted.csv",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True"
    }
}
', 0, NULL, -1)
GO
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) VALUES (-41, N'Azure SQL ErrorLog Extract to Data Lake', -3, 10, -2, -1, -4, 1, 0, N'Azure', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "ErrorLog"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/ErrorLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.ErrorLog.parquet",
    "SchemaFileName": "dbo.ErrorLog.json"
  }
}', 0, N'dbo.adls_ErrorLog', -1)
GO
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) VALUES (-10, N'Azure SQL SalesLT.Customer Extract to Data Lake', -3, 10, -2, -1, -3, 1, 0, N'Azure', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "Customer"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Customer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Customer.parquet",
    "SchemaFileName": "SalesLT.Customer.json"
  }
}', 0, N'SalesLT.Customer', -1)
GO
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) VALUES (-2, N'CSV Import NY Taxi Data into Azure SQL', -1, 10, -2, -3, -2, 1, 0, N'Azure', N'
{
    "Source": {
        "Type": "Csv",        
        "RelativePath": "/",
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SkipLineCount": "0",
        "MaxConcorrentConnections" : "10"
    },
    "Target": {
        "Type": "Table",
        "TableSchema": "dbo",
        "TableName": "NYTaxiYellowTripData",
        "StagingTableSchema": "dbo",
        "StagingTableName": "stg_NYTaxiYellowTripData",
        "AutoCreateTable": "True",
        "PreCopySQL": "IF OBJECT_ID(''dbo.stg_NYTaxiYellowTripData'') IS NOT NULL \r\n Truncate Table dbo.stg_NYTaxiYellowTripData",
        "PostCopySQL": "",
        "MergeSQL": "",
        "AutoGenerateMerge": "False",
        "DynamicMapping": {
        }
    }
}
', 0, NULL, -1)
GO
SET IDENTITY_INSERT [dbo].[TaskMaster] OFF
GO
INSERT [dbo].[TaskMasterWaterMark] ([TaskMasterId], [TaskMasterWaterMarkColumn], [TaskMasterWaterMarkColumnType], [TaskMasterWaterMark_DateTime], [TaskMasterWaterMark_BigInt], [TaskWaterMarkJSON], [ActiveYN], [UpdatedOn]) VALUES (10, N'ModifiedDate', N'DateTime', CAST(N'2009-05-16T16:33:33.123' AS DateTime), NULL, NULL, 1, CAST(N'2020-08-07T04:03:23.2200000+00:00' AS DateTimeOffset))
GO
SET IDENTITY_INSERT [dbo].[TaskType] ON 
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-6, N'Start/Pause Dedicated Synapse SQL Pool', N'DLL', NULL, 1)
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-5, N'Execute Synapse Notebook', N'ADF', NULL, 1)
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-4, N'Execute ADF Pipeline', N'ADF', NULL, 1)
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-3, N'SQL Database to Azure Storage', N'ADF', NULL, 1)
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-2, N'Azure Storage to Azure Storage', N'ADF', NULL, 1)
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-1, N'Azure Storage to SQL Database', N'ADF', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[TaskType] OFF
GO
SET IDENTITY_INSERT [dbo].[TaskTypeMapping] ON 
GO
SET IDENTITY_INSERT [dbo].[TaskTypeMapping] ON 
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (1, -1, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureSqlTable_NA', N'Azure Blob', N'Excel', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (2, -1, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureSqlTable_NA', N'Azure Blob', N'Csv', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (3, -1, N'ADF', N'GPL_AzureBlobStorage_Json_AzureSqlTable_NA', N'Azure Blob', N'Json', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 10,
               "options": {
                  "infoText": ""
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (4, -2, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobStorage_DelimitedText', N'Azure Blob', N'Excel', N'Azure Blob', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (5, -2, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobFS_DelimitedText', N'ADLS', N'Excel', N'ADLS', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (6, -3, N'ADF', N'GPL_AzureSqlTable_NA_AzureBlobStorage_Parquet', N'Azure SQL', N'Table', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (7, -3, N'ADF', N'GPL_AzureSqlTable_NA_AzureBlobFS_Parquet', N'Azure SQL', N'Table', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (8, -1, N'ADF', N'GPL_AzureBlobFS_Json_AzureSqlTable_NA', N'ADLS', N'Json', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 10,
               "options": {
                  "infoText": ""
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (9, -1, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureSqlTable_NA', N'ADLS', N'Parquet', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (10, -1, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureSqlTable_NA', N'Azure Blob', N'Parquet', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (11, -2, N'ADF', N'TBD', N'File', N'Binary', N'Azure Blob', N'Binary', NULL, 1, N'{     "$schema": "http://json-schema.org/draft-04/schema#",     "type": "object",     "properties": {         "Source": {             "type": "object",             "properties": {                 "Type": {                     "type": "string",                     "enum": [                         "Binary"                     ],                     "default": "Binary",                     "options": {                         "infoText": "Only Binary is supported this time. ",                         "hidden":true                     }                 },                 "RelativePath": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"                         },                         "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"                     }                 },                 "DataFileName": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. *.parquet"                         },                         "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"                     }                 },                 "Recursively": {                     "type": "string",                     "enum": [                         "true",                         "false"                     ],                     "default": "true",                     "options": {                         "infoText": "Set to true if you want the framework to copy files from subfolders."                     }                 },                 "DeleteAfterCompletion": {                     "type": "string",                     "enum": [                         "true",                         "false"                     ],                     "default": "true",                     "options": {                         "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."                     }                 }             },             "required": [                 "Type",                 "RelativePath",                 "DataFileName",                 "Recursively",                 "DeleteAfterCompletion"             ]         },         "Target": {             "type": "object",             "properties": {                 "Type": {                     "type": "string",                     "enum": [                         "Binary"                     ],                     "default": "Binary",                     "options": {                         "infoText": "Only Binary is supported this time. ",                          "hidden": true                     }                 },                 "RelativePath": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"                         },                         "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"                     }                 },                 "DataFileName": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. Customer.parquet"                         },                         "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."                     }                 }             },             "required": [                 "Type",                 "RelativePath",                 "DataFileName"             ]         }     },     "required": [         "Source",         "Target"     ] }', NULL)
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (12, -2, N'ADF', N'TBD', N'File', N'Binary', N'Azure Blob', N'Binary', NULL, 1, N'{     "$schema": "http://json-schema.org/draft-04/schema#",     "type": "object",     "properties": {         "Source": {             "type": "object",             "properties": {                 "Type": {                     "type": "string",                     "enum": [                         "Binary"                     ],                     "default": "Binary",                     "options": {                         "infoText": "Only Binary is supported this time. ",                         "hidden": true                     }                 },                 "RelativePath": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"                         },                         "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"                     }                 },                 "DataFileName": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. *.parquet"                         },                         "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"                     }                 },                 "Recursively": {                     "type": "string",                     "enum": [                         "true",                         "false"                     ],                     "default": "true",                     "options": {                         "infoText": "Set to true if you want the framework to copy files from subfolders."                     }                 },                 "DeleteAfterCompletion": {                     "type": "string",                     "enum": [                         "true",                         "false"                     ],                     "default": "true",                     "options": {                         "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."                     }                 }             },             "required": [                 "Type",                 "RelativePath",                 "DataFileName",                 "Recursively",                 "DeleteAfterCompletion"             ]         },         "Target": {             "type": "object",             "properties": {                 "Type": {                     "type": "string",                     "enum": [                         "Binary"                     ],                     "default": "Binary",                     "options": {                         "infoText": "Only Binary is supported this time. ",                          "hidden": true                     }                 },                 "RelativePath": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"                         },                         "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"                     }                 },                 "DataFileName": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "eg. Customer.parquet"                         },                         "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."                     }                 }             },             "required": [                 "Type",                 "RelativePath",                 "DataFileName"             ]         }     },     "required": [         "Source",         "Target"     ] }', NULL)
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (13, -3, N'ADF', N'GPL_SqlServerTable_NA_AzureBlobStorage_Parquet', N'SQL Server', N'Table', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (14, -3, N'ADF', N'TBD', N'SQL Server', N'Table', N'File', N'Parquet', NULL, 1, N'{     "$schema": "http://json-schema.org/draft-04/schema#",     "type": "object",     "properties": {         "Source": {             "type": "object",             "properties": {                 "Type": {                     "type": "string",                     "enum": [                         "Table",                         "SQL"                     ],                     "options": {                         "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data.",                          "hidden": true                     }                 },                 "IncrementalType": {                     "type": "string",                     "description": "Full Extraction or Incremental based on a Watermark Column",                     "enum": [                         "Full",                         "Watermark"                     ],                     "options": {                         "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"                     }                 },                 "ExtractionSQL": {                     "type": "string",                     "options": {                                             }                 },                 "TableSchema": {                     "type": "string",                     "options": {                                                 "inputAttributes": {                             "placeholder": "eg. dbo"                         }                     }                 },                 "TableName": {                     "type": "string",                     "options": {                                                 "inputAttributes": {                             "placeholder": "eg. Customer"                         }                     }                 },                 "ChunkField": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "Column to use for chunking. Only use for very large tables. Otherwise leave blank."                         },                         "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank."                     }                 },                 "ChunkSize": {                     "type": "integer",                     "options": {                         "inputAttributes": {                             "placeholder": ""                         },                         "infoText": "Number of rows to use for each ''chunk'' of data"                     }                 }             },             "required": [                 "Type",                 "IncrementalType"             ]         },         "Target": {             "type": "object",             "properties": {                 "Type": {                     "type": "string",                     "enum": [                         "Parquet"                     ],                     "options": {                         "infoText": "Presently only Parquet is supported",                          "hidden": true                     }                 },                 "RelativePath": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"                         },                         "infoText": "The path of the directory into which you want your extracted data to be written."                     }                 },                 "DataFileName": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "dbo.Customer.parquet"                         },                         "infoText": "Name of the file that will hold the extracted data"                     }                 },                 "SchemaFileName": {                     "type": "string",                     "options": {                         "inputAttributes": {                             "placeholder": "dbo.Customer.json"                         },                         "infoText": "Name of the file that will hold the schema associated with the extracted data."                     }                 }             },             "required": [                 "Type",                 "RelativePath",                 "DataFileName",                 "SchemaFileName"             ]         }     },     "required": [         "Source",         "Target"     ] }', N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "TargetRelativePath": {
      "type": "string"
    },
    "IncrementalField": {
      "type": "string"
    },
    "IncrementalColumnType": {
      "type": "string"
    },
    "IncrementalValue": {
      "type": "string"
    }
  },
  "required": [
    "TargetRelativePath",
    "IncrementalField",
    "IncrementalColumnType",
    "IncrementalValue"
  ]
}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (21, -2, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobStorage_Binary', N'Azure Blob', N'Parquet', N'Azure Blob', N'Parquet', NULL, 1, N'{   "$schema": "http://json-schema.org/draft-04/schema#",   "type": "object",   "title": "TaskMasterJson",   "properties": {     "Source": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",             "hidden": true           }         },         "RelativePath": {           "type": "string",           "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. *.parquet"             },             "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "Recursively": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to copy files from subfolders."           }         },         "DeleteAfterCompletion": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."           }         },         "TriggerUsingAzureStorageCache": {           "type": "boolean",           "format": "checkbox",           "enum": [             true,             false           ],           "default": true,           "options": {             "infoText": "Set to true if you want the framework to use the storage cache rather than poll the storage account every time."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName",         "Recursively",         "DeleteAfterCompletion"       ]     },     "Target": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",              "hidden": true           }         },         "RelativePath": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. Customer.parquet"             },             "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName"       ]     }   },   "required": [     "Source",     "Target"   ] }', NULL)
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (22, -2, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobFS_Binary', N'Azure Blob', N'Parquet', N'ADLS', N'Parquet', NULL, 1, N'{   "$schema": "http://json-schema.org/draft-04/schema#",   "type": "object",   "title": "TaskMasterJson",   "properties": {     "Source": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",             "hidden": true           }         },         "RelativePath": {           "type": "string",           "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. *.parquet"             },             "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "Recursively": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to copy files from subfolders."           }         },         "DeleteAfterCompletion": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."           }         },         "TriggerUsingAzureStorageCache": {           "type": "boolean",           "format": "checkbox",           "enum": [             true,             false           ],           "default": true,           "options": {             "infoText": "Set to true if you want the framework to use the storage cache rather than poll the storage account every time."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName",         "Recursively",         "DeleteAfterCompletion"       ]     },     "Target": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",              "hidden": true           }         },         "RelativePath": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. Customer.parquet"             },             "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName"       ]     }   },   "required": [     "Source",     "Target"   ] }', NULL)
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (23, -2, N'ADF', N'GPL_AzureBlobFS_Binary_AzureBlobStorage_Binary', N'ADLS', N'Parquet', N'Azure Blob', N'Parquet', NULL, 1, N'{   "$schema": "http://json-schema.org/draft-04/schema#",   "type": "object",   "title": "TaskMasterJson",   "properties": {     "Source": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",             "hidden": true           }         },         "RelativePath": {           "type": "string",           "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. *.parquet"             },             "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "Recursively": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to copy files from subfolders."           }         },         "DeleteAfterCompletion": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."           }         },         "TriggerUsingAzureStorageCache": {           "type": "boolean",           "format": "checkbox",           "enum": [             true,             false           ],           "default": true,           "options": {             "infoText": "Set to true if you want the framework to use the storage cache rather than poll the storage account every time."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName",         "Recursively",         "DeleteAfterCompletion"       ]     },     "Target": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",              "hidden": true           }         },         "RelativePath": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. Customer.parquet"             },             "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName"       ]     }   },   "required": [     "Source",     "Target"   ] }', NULL)
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (24, -2, N'ADF', N'GPL_AzureBlobFS_Binary_AzureBlobFS_Binary', N'ADLS', N'Parquet', N'ADLS', N'Parquet', NULL, 1, N'{   "$schema": "http://json-schema.org/draft-04/schema#",   "type": "object",   "title": "TaskMasterJson",   "properties": {     "Source": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",             "hidden": true           }         },         "RelativePath": {           "type": "string",           "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. *.parquet"             },             "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "Recursively": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to copy files from subfolders."           }         },         "DeleteAfterCompletion": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."           }         },         "TriggerUsingAzureStorageCache": {           "type": "boolean",           "format": "checkbox",           "enum": [             true,             false           ],           "default": true,           "options": {             "infoText": "Set to true if you want the framework to use the storage cache rather than poll the storage account every time."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName",         "Recursively",         "DeleteAfterCompletion"       ]     },     "Target": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",              "hidden": true           }         },         "RelativePath": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. Customer.parquet"             },             "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName"       ]     }   },   "required": [     "Source",     "Target"   ] }', NULL)
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (29, -2, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobStorage_Binary', N'Azure Blob', N'*', N'Azure Blob', N'*', NULL, 1, N'{   "$schema": "http://json-schema.org/draft-04/schema#",   "type": "object",   "title": "TaskMasterJson",   "properties": {     "Source": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",             "hidden": true           }         },         "RelativePath": {           "type": "string",           "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",           "options": {             "inputAttributes": {               "placeholder": "eg. *.parquet"             },             "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "Recursively": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to copy files from subfolders."           }         },         "DeleteAfterCompletion": {           "type": "string",           "enum": [             "true",             "false"           ],           "default": "true",           "options": {             "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."           }         },         "TriggerUsingAzureStorageCache": {           "type": "boolean",           "format": "checkbox",           "enum": [             true,             false           ],           "default": true,           "options": {             "infoText": "Set to true if you want the framework to use the storage cache rather than poll the storage account every time."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName",         "Recursively",         "DeleteAfterCompletion"       ]     },     "Target": {       "type": "object",       "properties": {         "Type": {           "type": "string",           "enum": [             "*"           ],           "default": "*",           "options": {             "infoText": "Only * is supported this time. ",              "hidden": true           }         },         "RelativePath": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"             },             "infoText": "Path of the target directory. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"           }         },         "DataFileName": {           "type": "string",           "options": {             "inputAttributes": {               "placeholder": "eg. Customer.parquet"             },             "infoText": "Name of the target file. Leave this blank if your are using pattern matching to copy multiple files from source."           }         }       },       "required": [         "Type",         "RelativePath",         "DataFileName"       ]     }   },   "required": [     "Source",     "Target"   ] }', N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "SourceRelativePath": {
      "type": "string"
    },
    "TargetRelativePath": {
      "type": "string"
    }
  },
  "required": [
    "SourceRelativePath",
    "TargetRelativePath"
  ]
}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (31, -3, N'ADF', N'GPL_AzureSqlTable_NA_AzureBlobStorage_Parquet', N'Azure SQL', N'SQL', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (33, -1, N'ADF', N'GPL_AzureBlobFS_Excel_AzureSqlTable_NA', N'ADLS', N'Excel', N'Azure SQL', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (34, -1, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureSqlTable_NA', N'ADLS', N'Csv', N'Azure SQL', N'Table', N'{}', 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (35, -1, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureSqlDWTable_NA', N'ADLS', N'Parquet', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (36, -1, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureSqlDWTable_NA', N'Azure Blob', N'Parquet', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (37, -1, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureSqlDWTable_NA', N'Azure Blob', N'Excel', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (38, -1, N'ADF', N'GPL_AzureBlobFS_Excel_AzureSqlDWTable_NA', N'ADLS', N'Excel', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (39, -1, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureSqlDWTable_NA', N'Azure Blob', N'Csv', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (40, -1, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureSqlDWTable_NA', N'ADLS', N'Csv', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (41, -1, N'ADF', N'GPL_AzureBlobStorage_Json_AzureSqlDWTable_NA', N'Azure Blob', N'Json', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 10,
               "options": {
                  "infoText": ""
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (42, -1, N'ADF', N'GPL_AzureBlobFS_Json_AzureSqlDWTable_NA', N'ADLS', N'Json', N'Azure Synapse', N'Table', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 10,
               "options": {
                  "infoText": ""
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "AutoCreateTable": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
               },
               "type": "string"
            },
            "AutoGenerateMerge": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
               },
               "type": "string"
            },
            "MergeSQL": {
               "format": "sql",
               "options": {
                  "ace": {
                     "tabSize": 2,
                     "useSoftTabs": true,
                     "wrap": true
                  },
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if [AutoGenerateMerge] is true. Click in the box below to view or edit "
               },
               "type": "string"
            },
            "PostCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  }
               },
               "type": "string"
            },
            "PreCopySQL": {
               "options": {
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table",
                  "inputAttributes": {
                     "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  }
               },
               "type": "string"
            },
            "StagingTableName": {
               "options": {
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. StgCustomer"
                  }
               },
               "type": "string"
            },
            "StagingTableSchema": {
               "options": {
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "TableName": {
               "options": {
                  "infoText": "Name of the final target table.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "options": {
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated.",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "StagingTableSchema",
            "StagingTableName",
            "AutoCreateTable",
            "TableSchema",
            "TableName",
            "PreCopySQL",
            "PostCopySQL",
            "AutoGenerateMerge",
            "MergeSQL"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (43, -2, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobStorage_Binary', N'Azure Blob', N'Binary', N'Azure Blob', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (44, -2, N'ADF', N'GPL_AzureBlobFS_Binary_AzureBlobFS_Binary', N'ADLS', N'Binary', N'ADLS', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (45, -2, N'ADF', N'GPL_AzureBlobFS_Binary_AzureBlobStorage_Binary', N'ADLS', N'Binary', N'Azure Blob', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (46, -2, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobFS_Binary', N'Azure Blob', N'Binary', N'ADLS', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (47, -2, N'ADF', N'GPL_FileServer_Binary_AzureBlobStorage_Binary', N'FileServer', N'Binary', N'Azure Blob', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (48, -2, N'ADF', N'GPL_FileServer_Binary_AzureBlobFS_Binary', N'FileServer', N'Binary', N'ADLS', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (49, -2, N'ADF', N'GPL_AzureBlobStorage_Binary_FileServer_Binary', N'Azure Blob', N'Binary', N'FileServer', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (50, -2, N'ADF', N'GPL_AzureBlobFS_Binary_FileServer_Binary', N'ADLS', N'Binary', N'FileServer', N'Binary', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (51, -2, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobStorage_Json', N'Azure Blob', N'Parquet', N'Azure Blob', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (52, -2, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobStorage_DelimitedText', N'Azure Blob', N'Parquet', N'Azure Blob', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (53, -2, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobStorage_Parquet', N'Azure Blob', N'Excel', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (54, -2, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobStorage_Json', N'Azure Blob', N'Excel', N'Azure Blob', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (55, -2, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobStorage_Parquet', N'Azure Blob', N'Csv', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (56, -2, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobStorage_Json', N'Azure Blob', N'Csv', N'Azure Blob', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (57, -2, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobStorage_Parquet', N'Azure Blob', N'Json', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (58, -2, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobStorage_DelimitedText', N'Azure Blob', N'Json', N'Azure Blob', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (59, -2, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobFS_Json', N'ADLS', N'Parquet', N'ADLS', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (60, -2, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobFS_DelimitedText', N'ADLS', N'Parquet', N'ADLS', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (61, -2, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobFS_Parquet', N'ADLS', N'Excel', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (62, -2, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobFS_Json', N'ADLS', N'Excel', N'ADLS', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (63, -2, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobFS_Parquet', N'ADLS', N'Csv', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (64, -2, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobFS_Json', N'ADLS', N'Csv', N'ADLS', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (65, -2, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobFS_Parquet', N'ADLS', N'Json', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (66, -2, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobFS_DelimitedText', N'ADLS', N'Json', N'ADLS', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (67, -2, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobStorage_Json', N'ADLS', N'Parquet', N'Azure Blob', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (68, -2, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobStorage_DelimitedText', N'ADLS', N'Parquet', N'Azure Blob', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (69, -2, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobStorage_Parquet', N'ADLS', N'Excel', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (70, -2, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobStorage_Json', N'ADLS', N'Excel', N'Azure Blob', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (71, -2, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobStorage_DelimitedText', N'ADLS', N'Excel', N'Azure Blob', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (72, -2, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobStorage_Parquet', N'ADLS', N'Csv', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (73, -2, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobStorage_Json', N'ADLS', N'Csv', N'Azure Blob', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (74, -2, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobStorage_Parquet', N'ADLS', N'Json', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (75, -2, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobStorage_DelimitedText', N'ADLS', N'Json', N'Azure Blob', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (76, -2, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobFS_Json', N'Azure Blob', N'Parquet', N'ADLS', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (77, -2, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobFS_DelimitedText', N'Azure Blob', N'Parquet', N'ADLS', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (78, -2, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobFS_Parquet', N'Azure Blob', N'Excel', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (79, -2, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobFS_Json', N'Azure Blob', N'Excel', N'ADLS', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (80, -2, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobFS_DelimitedText', N'Azure Blob', N'Excel', N'ADLS', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (81, -2, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobFS_Parquet', N'Azure Blob', N'Csv', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (82, -2, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobFS_Json', N'Azure Blob', N'Csv', N'ADLS', N'Json', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (83, -2, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobFS_Parquet', N'Azure Blob', N'Json', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (84, -2, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobFS_DelimitedText', N'Azure Blob', N'Json', N'ADLS', N'Csv', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "SkipLineCount",
            "FirstRowAsHeader",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (85, -3, N'ADF', N'GPL_SqlServerTable_NA_AzureBlobStorage_Parquet', N'SQL Server', N'Sql', N'Azure Blob', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (86, -3, N'ADF', N'GPL_AzureSqlTable_NA_AzureBlobFS_Parquet', N'Azure SQL', N'Sql', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (87, -3, N'ADF', N'GPL_SqlServerTable_NA_AzureBlobFS_Parquet', N'SQL Server', N'Sql', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (88, -3, N'ADF', N'GPL_SqlServerTable_NA_AzureBlobFS_Parquet', N'SQL Server', N'Table', N'ADLS', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (89, -3, N'ADF', N'GPL_AzureSqlTable_NA_FileServer_Parquet', N'Azure SQL', N'Table', N'FileServer', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (90, -3, N'ADF', N'GPL_SqlServerTable_NA_FileServer_Parquet', N'SQL Server', N'Table', N'FileServer', N'Parquet', NULL, 1, N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "ChunkField": {
               "default": "",
               "options": {
                  "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer Id"
                  }
               },
               "type": "string"
            },
            "ChunkSize": {
               "default": 0,
               "options": {
                  "infoText": "Number of rows to use for each [chunk] of data.",
                  "inputAttributes": {
                     "placeholder": 0
                  }
               },
               "type": "integer"
            },
            "ExtractionSQL": {
               "default": "",
               "options": {
                  "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is [Table]",
                  "inputAttributes": {
                     "placeholder": "eg. Select top 100 * from Customer"
                  }
               },
               "type": "string"
            },
            "IncrementalType": {
               "default": "Table",
               "description": "Full Extraction or Incremental based on a Watermark Column",
               "enum": [
                  "Full",
                  "Watermark"
               ],
               "options": {
                  "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
               },
               "type": "string"
            },
            "TableName": {
               "default": "",
               "options": {
                  "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. Customer"
                  }
               },
               "type": "string"
            },
            "TableSchema": {
               "default": "",
               "options": {
                  "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is [SQL]",
                  "inputAttributes": {
                     "placeholder": "eg. dbo"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Table",
                  "SQL"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "IncrementalType"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the extracted data",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.parquet"
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "The path of the directory into which you want your extracted data to be written. You can use placeholders such (eg. {yyyy}/{MM}/{dd}/{hh}/). ",
                  "inputAttributes": {
                     "placeholder": "AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the file that will hold the schema associated with the extracted data.",
                  "inputAttributes": {
                     "placeholder": "dbo.Customer.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true,
                  "infoText": "Presently only Parquet is supported"
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
', N'{}')
GO
SET IDENTITY_INSERT [dbo].[TaskTypeMapping] OFF
GO
