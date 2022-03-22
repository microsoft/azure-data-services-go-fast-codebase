


--Add Additional Task Type Mapping

/***********************************************************
Update Mapping Names
***********************************************************/
-- AzureBlobStorage_Excel_AzureSqlTable
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Excel_AzureSqlTable_NA'
    where TaskTypeId = 1
    and MappingName = 'AZ_Storage_Excel_AZ_SQL'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Excel'
    and TargetType = 'Table';
-- AzureBlobStorage_CSV_AzureSqlTable
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_CSV_AzureSqlTable_NA'
    where TaskTypeId = 1
    and MappingName = 'AZ_Storage_CSV_AZ_SQL'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Csv'
    and TargetType = 'Table';
-- AzureBlobStorage_Json_AzureSqlTable
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Json_AzureSqlTable_NA'
    where TaskTypeId = 1
    and MappingName = 'AZ_Storage_JSON_AZ_SQL'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Json'
    and TargetType = 'Table';
-- AzureBlobStorage_Excel_AzureBlobStorage_DelimitedText
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Excel_AzureBlobStorage_DelimitedText'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Excel_AZ_Storage_CSV'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Excel'
    and TargetType = 'Csv';
-- AzureBlobFS_Excel_AzureBlobFS_DelimitedText
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobFS_Excel_AzureBlobFS_DelimitedText'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Excel_AZ_Storage_CSV'
    and SourceSystemType = 'ADLS'
    and TargetSystemType = 'ADLS'
    and SourceType = 'Excel'
    and TargetType = 'Csv';
-- AzureSqlTable_NA_AzureBlobStorage_Parquet
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureSqlTable_NA_AzureBlobStorage_Parquet'
    where TaskTypeId = 3
    and MappingName = 'AZ_SQL_AZ_Storage_Parquet'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- AzureSqlTable_NA_AzureBlobFS_Parquet
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureSqlTable_NA_AzureBlobFS_Parquet'
    where TaskTypeId = 3
    and MappingName = 'AZ_SQL_AZ_Storage_Parquet'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'ADLS'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- AzureBlobStorage_Json_AzureSqlTable
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Json_AzureSqlTable_NA'
    where TaskTypeId = 3
    and MappingName = 'AZ_Storage_JSON_AZ_SQL'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Json'
    and TargetType = 'Table';
-- AzureBlobStorage_Parquet_AzureSqlTable
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Parquet_AzureSqlTable_NA'
    where TaskTypeId = 1
    and MappingName = 'AZ_Storage_Parquet_AZ_SQL'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Parquet'
    and TargetType = 'Table';
-- AzureBlobFS_Parquet_AzureSqlTable
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobFS_Parquet_AzureSqlTable_NA'
    where TaskTypeId = 1
    and MappingName = 'AZ_Storage_Parquet_AZ_SQL'
    and SourceSystemType = 'ADLS'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Parquet'
    and TargetType = 'Table';
-- GEN_File_Binary_AZ_Storage_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'GEN_File_Binary_AZ_Storage_Binary'
    where TaskTypeId = 2
    and MappingName = 'GEN_File_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'File'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Binary'
    and TargetType = 'Binary';
-- GEN_File_Binary_AZ_Storage_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'GEN_File_Binary_AZ_Storage_Binary'
    where TaskTypeId = 2
    and MappingName = 'GEN_File_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'File'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Binary'
    and TargetType = 'Binary';
-- OnP_SQL_AZ_Storage_Parquet
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'OnP_SQL_AZ_Storage_Parquet'
    where TaskTypeId = 3
    and MappingName = 'OnP_SQL_AZ_Storage_Parquet'
    and SourceSystemType = 'SQL Server'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- OnP_SQL_GEN_File_Parquet
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'OnP_SQL_GEN_File_Parquet'
    where TaskTypeId = 3
    and MappingName = 'OnP_SQL_GEN_File_Parquet'
    and SourceSystemType = 'SQL Server'
    and TargetSystemType = 'File'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- Create_Task_Master_AZ_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Create_Task_Master_AZ_SQL'
    where TaskTypeId = 8
    and MappingName = 'Create_Task_Master_AZ_SQL'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- Create_Task_Master_AZ_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Create_Task_Master_AZ_SQL'
    where TaskTypeId = 8
    and MappingName = 'Create_Task_Master_AZ_SQL'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Parquet'
    and TargetType = 'Table';
-- Create_Task_Master_AZ_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Create_Task_Master_AZ_SQL'
    where TaskTypeId = 8
    and MappingName = 'Create_Task_Master_AZ_SQL'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'ADLS'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- Create_Task_Master_AZ_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Create_Task_Master_AZ_SQL'
    where TaskTypeId = 8
    and MappingName = 'Create_Task_Master_AZ_SQL'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'ADLS'
    and SourceType = 'Parquet'
    and TargetType = 'Table';
-- Create_Task_Master_AZ_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Create_Task_Master_AZ_SQL'
    where TaskTypeId = 8
    and MappingName = 'Create_Task_Master_AZ_SQL'
    and SourceSystemType = 'SQL Server'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Table'
    and TargetType = 'Parquet';
-- Create_Task_Master_AZ_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Create_Task_Master_AZ_SQL'
    where TaskTypeId = 8
    and MappingName = 'Create_Task_Master_AZ_SQL'
    and SourceSystemType = 'SQL Server'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Parquet'
    and TargetType = 'Table';
-- AzureBlobStorage_Binary_AzureBlobStorage_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Binary_AzureBlobStorage_Binary'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Parquet'
    and TargetType = 'Parquet';
-- AzureBlobStorage_Binary_AzureBlobFS_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Binary_AzureBlobFS_Binary'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'ADLS'
    and SourceType = 'Parquet'
    and TargetType = 'Parquet';
-- AzureBlobFS_Binary_AzureBlobStorage_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobFS_Binary_AzureBlobStorage_Binary'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'ADLS'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'Parquet'
    and TargetType = 'Parquet';
-- AzureBlobFS_Binary_AzureBlobFS_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobFS_Binary_AzureBlobFS_Binary'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'ADLS'
    and TargetSystemType = 'ADLS'
    and SourceType = 'Parquet'
    and TargetType = 'Parquet';
-- AzureSqlSource_SQL
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureSqlSource_SQL'
    where TaskTypeId = 7
    and MappingName = 'AZ_SQL_StoredProcedure'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'StoredProcedure'
    and TargetType = 'StoredProcedure';
-- AZ_Storage_SAS_Uri_SMTP_Email
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AZ_Storage_SAS_Uri_SMTP_Email'
    where TaskTypeId = 9
    and MappingName = 'AZ_Storage_SAS_Uri_SMTP_Email'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'SendGrid'
    and SourceType = 'SASUri'
    and TargetType = 'Email';
-- AZ_Storage_Cache_File_List
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AZ_Storage_Cache_File_List'
    where TaskTypeId = 10
    and MappingName = 'AZ_Storage_Cache_File_List'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure SQL'
    and SourceType = 'Filelist'
    and TargetType = 'Table';
-- AzureBlobStorage_Binary_AzureBlobStorage_Binary
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureBlobStorage_Binary_AzureBlobStorage_Binary'
    where TaskTypeId = 2
    and MappingName = 'AZ_Storage_Binary_AZ_Storage_Binary'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'Azure Blob'
    and SourceType = '*'
    and TargetType = '*';
-- Cache_File_List_To_Email_Alert
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'Cache_File_List_To_Email_Alert'
    where TaskTypeId = 11
    and MappingName = 'Cache_File_List_To_Email_Alert'
    and SourceSystemType = 'Azure Blob'
    and TargetSystemType = 'SendGrid'
    and SourceType = '*'
    and TargetType = '*';
-- AzureSqlTable_NA_AzureBlobStorage_Parquet
    Update [dbo].[TaskTypeMapping]
    Set MappingName = 'AzureSqlTable_NA_AzureBlobStorage_Parquet'
    where TaskTypeId = 3
    and MappingName = 'AZ_SQL_AZ_Storage_Parquet'
    and SourceSystemType = 'Azure SQL'
    and TargetSystemType = 'Azure Blob'
    and SourceType = 'SQL'
    and TargetType = 'Parquet';


--Update Task Instance Json Shcemas
Update [dbo].[TaskTypeMapping] 
Set TaskInstanceJsonSchema = '
{
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
    "TargetRelativePath"
  ]
}'
where mappingname in ('AzureSqlTable_NA_AzureBlobStorage_Parquet', 'AzureSqlTable_NA_AzureBlobFS_Parquet')

INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (1, N'ADF', N'AzureBlobFS_Excel_AzureSqlTable_NA', N'ADLS', N'Excel', N'Azure SQL', N'Table', N'IRA', NULL, 1, N'{
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
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if `AutoGenerateMerge` is true. Click in the box below to view or edit "
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
',NULL 
)

Select * from [dbo].[TaskTypeMapping] where sourcetype = 'excel' and targetsystemtype = 'Azure SQL'