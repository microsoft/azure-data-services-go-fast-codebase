


--Add Additional Task Type Mapping
INSERT [dbo].[TaskTypeMapping] ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (3, N'ADF', N'AZ_SQL_AZ_Storage_Parquet_IRA', N'Azure SQL', N'SQL', N'Azure Blob', N'Parquet', N'IRA', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "IncrementalType": {
          "type": "string"
        },
        "ExtractionSQL": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "ChunkField": {
          "type": ["string","null"]
        },
        "ChunkSize": {
          "type": ["number","null"]
        }
      },
      "required": [
        "Type",
        "IncrementalType",
        "ExtractionSQL",
        "TableSchema",
        "TableName"
      ]
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "RelativePath": {
          "type": "string"
        },
        "DataFileName": {
          "type": "string"
        },
        "SchemaFileName": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "SchemaFileName"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', N'{
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



Update  
[dbo].[TaskTypeMapping]
Set MappingName =  replace(replace(replace(MappingName, '-', '_'), 'OnP_SH_IR', 'IRB'), 'SH_IR', 'IRA') 


Update  
[dbo].[TaskTypeMapping]
Set TaskDataFactoryIR =  replace(replace(replace(TaskDataFactoryIR, '-', '_'), 'OnP SH IR', 'IRB'), 'SH IR', 'IRA') 

Update  
[dbo].[TaskMaster]
Set TaskDataFactoryIR =  replace(replace(replace(TaskDataFactoryIR, '-', '_'), 'OnP SH IR', 'IRB'), 'SH IR', 'IRA') 


Update [dbo].[TaskTypeMapping]
set SourceType = replace(replace(replace(SourceType,'csv', 'Csv'), 'json','Json'), 'JSON','Json')

Update [dbo].[TaskTypeMapping]
set TargetType = replace(replace(replace(TargetType,'csv', 'Csv'), 'json','Json'), 'JSON','Json')