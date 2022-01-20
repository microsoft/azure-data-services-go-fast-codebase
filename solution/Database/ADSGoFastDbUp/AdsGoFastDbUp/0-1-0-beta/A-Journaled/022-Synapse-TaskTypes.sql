INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) 
VALUES (1, N'Sample - Azure Synapse', N'Azure Synapse', N'Sample Azure Synapse Source', N'adsgofastdatakakeaccelsqlsvr.database.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Database" : "AWSample"
    }
', 1, 0)


insert into [dbo].[SourceAndTargetSystems_JsonSchema]
Select SystemType,JsonSchema  from 
(
Select 'Azure Synapse' as SystemType, '{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {    "Database": {      "type": "string"    }  },  "required": [    "Database"  ]}' as JsonSchema
) a


SET IDENTITY_INSERT [dbo].[TaskType] ON
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (12, N'Azure Storage to Azure Synapse', N'ADF', NULL, 1)
SET IDENTITY_INSERT [dbo].[TaskType] OFF


INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureSqlDWTable_NA', N'Azure Blob', N'Parquet', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you dont provide a schema file then the schema will be automatically inferred based on the source data.",
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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
}')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobStorage_Json_AzureSqlDWTable_NA', N'Azure Blob', N'Json', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
            "MaxConcorrentConnections": {
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you dont provide a schema file then the schema will be automatically inferred based on the source data.",
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
            "MaxConcorrentConnections"
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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
')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureSqlDWTable_NA', N'Azure Blob', N'Excel', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you don''t provide a schema file then the schema will be automatically inferred based on the source data.",
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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
')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureSqlDWTable_NA', N'Azure Blob', N'Csv', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
            "MaxConcorrentConnections": {
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you don''t provide a schema file then the schema will be automatically inferred based on the source data.",
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
            "MaxConcorrentConnections"
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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

')

INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureSqlDWTable_NA', N'ADLS', N'Parquet', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you dont provide a schema file then the schema will be automatically inferred based on the source data.",
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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

')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobFS_Json_AzureSqlDWTable_NA', N'ADLS', N'Json', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
            "MaxConcorrentConnections": {
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you don''t provide a schema file then the schema will be automatically inferred based on the source data.",
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
            "MaxConcorrentConnections"
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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

')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobFS_Excel_AzureSqlDWTable_NA', N'ADLS', N'Excel', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you don''t provide a schema file then the schema will be automatically inferred based on the source data.",
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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

')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema]) VALUES (12, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureSqlDWTable_NA', N'ADLS', N'Csv', N'Azure Synapse', N'Table', NULL, 1, N'
{
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
            "MaxConcorrentConnections": {
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
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you don''t provide a schema file then the schema will be automatically inferred based on the source data.",
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
            "MaxConcorrentConnections"
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if ''AutoGenerateMerge'' is true. Click in the box below to view or edit "
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
}')
