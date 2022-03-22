/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

/* 
Inserts Task Type and Task Type Mapping
*/

SET IDENTITY_INSERT [dbo].[TaskType] ON 

INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (1, N'Azure Storage to SQL Database', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (2, N'Azure Storage to Azure Storage', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (3, N'SQL Database to Azure Storage', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (4, N'Execute ADF Pipeline', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (5, N'Execute SSIS Pipeline', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (6, N'Execute Databricks Notebook', N'ADB', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (7, N'Execute SQL Statement', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (8, N'Generate Task Masters', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (9, N'Generate and Send SAS URI File Upload Link', N'AF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (10, N'Cache Azure Storage File List', N'AF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (11, N'Send Email Alert Triggered by File in FileList Cache', N'AF', NULL, 1)
SET IDENTITY_INSERT [dbo].[TaskType] OFF

/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

SET IDENTITY_INSERT [dbo].[TaskTypeMapping] ON 

INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (1, 1, N'ADF', N'AZ-Storage-Excel-AZ-SQL-SH-IR', N'Azure Blob', N'Excel', N'Azure SQL', N'Table', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        },
        "FirstRowAsHeader": {
          "type": "string"
        },
        "SheetName": {
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
      ]
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "StagingTableSchema": {
          "type": "string"
        },
        "StagingTableName": {
          "type": "string"
        },
        "AutoCreateTable": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "PreCopySQL": {
          "type": "string"
        },
        "PostCopySQL": {
          "type": "string"
        },
        "MergeSQL": {
          "type": "string"
        },
        "AutoGenerateMerge": {
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
        "MergeSQL",
        "AutoGenerateMerge"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (2, 1, N'ADF', N'AZ-Storage-CSV-AZ-SQL-SH-IR', N'Azure Blob', N'csv', N'Azure SQL', N'Table', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        },
        "FirstRowAsHeader": {
          "type": "string"
        },
        "SkipLineCount": {
          "type": "string"
        },
        "MaxConcorrentConnections": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "SchemaFileName",
        "FirstRowAsHeader",
        "SkipLineCount",
        "MaxConcorrentConnections"
      ]
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "StagingTableSchema": {
          "type": "string"
        },
        "StagingTableName": {
          "type": "string"
        },
        "AutoCreateTable": {
          "type": "string"
        },
        "PreCopySQL": {
          "type": "string"
        },
        "PostCopySQL": {
          "type": "string"
        },
        "MergeSQL": {
          "type": "string"
        },
        "AutoGenerateMerge": {
          "type": "string"
        },
        "DynamicMapping": {
          "type": "object"
        }
      },
      "required": [
        "Type",
        "TableSchema",
        "TableName",
        "StagingTableSchema",
        "StagingTableName",
        "AutoCreateTable",
        "PreCopySQL",
        "PostCopySQL",
        "MergeSQL",
        "AutoGenerateMerge",
        "DynamicMapping"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (3, 1, N'ADF', N'AZ-Storage-JSON-AZ-SQL-SH-IR', N'Azure Blob', N'json', N'Azure SQL', N'Table', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        },
        "MaxConcorrentConnections": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "SchemaFileName",
        "MaxConcorrentConnections"
      ]
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "StagingTableSchema": {
          "type": "string"
        },
        "StagingTableName": {
          "type": "string"
        },
        "AutoCreateTable": {
          "type": "string"
        },
        "PreCopySQL": {
          "type": "string"
        },
        "PostCopySQL": {
          "type": "string"
        },
        "MergeSQL": {
          "type": "string"
        },
        "AutoGenerateMerge": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "TableSchema",
        "TableName",
        "StagingTableSchema",
        "StagingTableName",
        "AutoCreateTable",
        "PreCopySQL",
        "PostCopySQL",
        "MergeSQL",
        "AutoGenerateMerge"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (4, 2, N'ADF', N'AZ-Storage-Excel-AZ-Storage-CSV-SH-IR', N'Azure Blob', N'Excel', N'Azure Blob', N'csv', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        },
        "FirstRowAsHeader": {
          "type": "string"
        },
        "SheetName": {
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
        },
        "FirstRowAsHeader": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "SchemaFileName",
        "FirstRowAsHeader"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (5, 2, N'ADF', N'AZ-Storage-Excel-AZ-Storage-CSV-SH-IR', N'ADLS', N'Excel', N'ADLS', N'csv', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        },
        "FirstRowAsHeader": {
          "type": "string"
        },
        "SheetName": {
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
        },
        "FirstRowAsHeader": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "SchemaFileName",
        "FirstRowAsHeader"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (6, 3, N'ADF', N'AZ-SQL-AZ-Storage-Parquet-SH-IR', N'Azure SQL', N'Table', N'Azure Blob', N'Parquet', N'SH IR', NULL, 1, N'{
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
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (7, 3, N'ADF', N'AZ-SQL-AZ-Storage-Parquet-SH-IR', N'Azure SQL', N'Table', N'ADLS', N'Parquet', N'SH IR', NULL, 1, N'{
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
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (8, 3, N'ADF', N'AZ-Storage-JSON-AZ-SQL-SH-IR', N'Azure Blob', N'JSON', N'Azure SQL', N'Table', N'SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (9, 1, N'ADF', N'AZ-Storage-Parquet-AZ-SQL-SH-IR', N'Azure Blob', N'Parquet', N'Azure SQL', N'Table', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "StagingTableSchema": {
          "type": "string"
        },
        "StagingTableName": {
          "type": "string"
        },
        "AutoCreateTable": {
          "type": "string"
        },
        "PreCopySQL": {
          "type": "string"
        },
        "PostCopySQL": {
          "type": "string"
        },
        "MergeSQL": {
          "type": "string"
        },
        "AutoGenerateMerge": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "TableSchema",
        "TableName",
        "StagingTableSchema",
        "StagingTableName",
        "AutoCreateTable",
        "PreCopySQL",
        "PostCopySQL",
        "MergeSQL",
        "AutoGenerateMerge"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (10, 1, N'ADF', N'AZ-Storage-Parquet-AZ-SQL-SH-IR', N'ADLS', N'Parquet', N'Azure SQL', N'Table', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "StagingTableSchema": {
          "type": "string"
        },
        "StagingTableName": {
          "type": "string"
        },
        "AutoCreateTable": {
          "type": "string"
        },
        "PreCopySQL": {
          "type": "string"
        },
        "PostCopySQL": {
          "type": "string"
        },
        "MergeSQL": {
          "type": "string"
        },
        "AutoGenerateMerge": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "TableSchema",
        "TableName",
        "StagingTableSchema",
        "StagingTableName",
        "AutoCreateTable",
        "PreCopySQL",
        "PostCopySQL",
        "MergeSQL",
        "AutoGenerateMerge"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (11, 2, N'ADF', N'GEN-File-Binary-AZ-Storage-Binary-SH-IR', N'File', N'Binary', N'Azure Blob', N'Binary', N'SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (12, 2, N'ADF', N'GEN-File-Binary-AZ-Storage-Binary-OnP-SH-IR', N'File', N'Binary', N'Azure Blob', N'Binary', N'OnP SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (13, 3, N'ADF', N'OnP-SQL-AZ-Storage-Parquet-OnP-SH-IR', N'SQL Server', N'Table', N'Azure Blob', N'Parquet', N'OnP SH IR', NULL, 1, N'{
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
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (14, 3, N'ADF', N'OnP-SQL-GEN-File-Parquet-OnP-SH-IR', N'SQL Server', N'Table', N'File', N'Parquet', N'OnP SH IR', NULL, 1, N'{
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
          "type": "string"
        },
        "ChunkSize": {
          "type": "number"
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
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (15, 8, N'ADF', N'Create-Task-Master-AZ-SQL-SH-IR', N'Azure SQL', N'Table', N'Azure Blob', N'Parquet', N'SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (16, 8, N'ADF', N'Create-Task-Master-AZ-SQL-SH-IR', N'Azure SQL', N'Parquet', N'Azure Blob', N'Table', N'SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (17, 8, N'ADF', N'Create-Task-Master-AZ-SQL-SH-IR', N'Azure SQL', N'Table', N'ADLS', N'Parquet', N'SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (18, 8, N'ADF', N'Create-Task-Master-AZ-SQL-SH-IR', N'Azure SQL', N'Parquet', N'ADLS', N'Table', N'SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (19, 8, N'ADF', N'Create-Task-Master-AZ-SQL-OnP-SH-IR', N'SQL Server', N'Table', N'Azure Blob', N'Parquet', N'OnP SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (20, 8, N'ADF', N'Create-Task-Master-AZ-SQL-OnP-SH-IR', N'SQL Server', N'Parquet', N'Azure Blob', N'Table', N'OnP SH IR', NULL, 1, NULL, NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (21, 2, N'ADF', N'AZ-Storage-Binary-AZ-Storage-Binary-SH-IR', N'Azure Blob', N'Parquet', N'Azure Blob', N'Parquet', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        "Recursively": {
          "type": "string"
        },
        "DeleteAfterCompletion": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "Recursively",
        "DeleteAfterCompletion"
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
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (22, 2, N'ADF', N'AZ-Storage-Binary-AZ-Storage-Binary-SH-IR', N'Azure Blob', N'Parquet', N'ADLS', N'Parquet', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        "Recursively": {
          "type": "string"
        },
        "DeleteAfterCompletion": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "Recursively",
        "DeleteAfterCompletion"
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
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (23, 2, N'ADF', N'AZ-Storage-Binary-AZ-Storage-Binary-SH-IR', N'ADLS', N'Parquet', N'Azure Blob', N'Parquet', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        "Recursively": {
          "type": "string"
        },
        "DeleteAfterCompletion": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "Recursively",
        "DeleteAfterCompletion"
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
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (24, 2, N'ADF', N'AZ-Storage-Binary-AZ-Storage-Binary-SH-IR', N'ADLS', N'Parquet', N'ADLS', N'Parquet', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        "Recursively": {
          "type": "string"
        },
        "DeleteAfterCompletion": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "Recursively",
        "DeleteAfterCompletion"
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
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (25, 7, N'ADF', N'AZ-SQL-StoredProcedure-SH-IR', N'Azure SQL', N'StoredProcedure', N'Azure SQL', N'StoredProcedure', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "TableSchema": {
          "type": "string"
        },
        "TableName": {
          "type": "string"
        },
        "StoredProcedure": {
          "type": "string"
        },
        "Parameters": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "TableSchema",
        "TableName",
        "StoredProcedure",
        "Parameters"
      ]
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        }
      },
      "required": [
        "Type"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (26, 9, N'AF', N'AZ-Storage-SAS-Uri-SMTP-Email', N'Azure Blob', N'SASUri', N'SendGrid', N'Email', N'N/A', NULL, 1, NULL, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "SourceRelativePath": {
      "type": "string"
    }
  },
  "required": [
    "SourceRelativePath"
  ]
}')
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (27, 10, N'AF', N'AZ-Storage-Cache-File-List', N'Azure Blob', N'Filelist', N'Azure SQL', N'Table', N'N/A', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        },
        "StorageAccountToken": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "StorageAccountToken"
      ]
    },
    "Target": {
      "type": "object",
      "properties": {
        "Type": {
          "type": "string"
        }
      },
      "required": [
        "Type"
      ]
    }
  },
  "required": [
    "Source",
    "Target"
  ]
}', NULL)
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (29, 2, N'ADF', N'AZ-Storage-Binary-AZ-Storage-Binary-SH-IR', N'Azure Blob', N'*', N'Azure Blob', N'*', N'SH IR', NULL, 1, N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "Source": {
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
        "Recursively": {
          "type": "string"
        },
        "TriggerUsingAzureStorageCache": {
          "type": "boolean"
        },
        "DeleteAfterCompletion": {
          "type": "string"
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "Recursively",
        "TriggerUsingAzureStorageCache",
        "DeleteAfterCompletion"
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
        }
      },
      "required": [
        "Type",
        "RelativePath",
        "DataFileName"
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
INSERT [dbo].[TaskTypeMapping] ([TaskTypeMappingId], [TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskDatafactoryIR], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema]) VALUES (30, 11, N'AF', N'Cache-File-List-To-Email-Alert', N'Azure Blob', N'*', N'SendGrid', N'*', N'*', NULL, 1, N'{
    "$schema": "http://json-schema.org/draft-07/schema",
    "type": "object",
    "required": [
        "Source",
        "Target"
    ],
    "properties": {
        "Source": {
            "type": "object",
            "required": [
                "Type",
                "RelativePath",
                "DataFileName",
                "Recursively",
                "TriggerUsingAzureStorageCache",
                "DeleteAfterCompletion"
            ],
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
                "Recursively": {
                    "type": "string"
                },
                "TriggerUsingAzureStorageCache": {
                    "type": "boolean"
                },
                "DeleteAfterCompletion": {
                    "type": "string"
                }
            },
            "additionalProperties": true
        },
        "Target": {
            "type": "object",
            "required": [
                "Type",
                "Alerts"
            ],
            "properties": {
                "Type": {
                    "type": "string"
                },
                "Alerts": {
                    "type": "array",
                    "additionalItems": true,
                    "items": {
                        "anyOf": [
                            {
                                "type": "object",
                                "required": [
                                    "AlertCategory",
                                    "EmailTemplateFileName",
                                    "EmailRecepient",
                                    "EmailSubject",
                                    "EmailRecepientName"
                                ],
                                "properties": {
                                    "AlertCategory": {
                                        "type": "string"
                                    },
                                    "EmailTemplateFileName": {
                                        "type": "string"
                                    },
                                    "EmailRecepient": {
                                        "type": "string"
                                    },
                                    "EmailSubject": {
                                        "type": "string"
                                    },
                                    "EmailRecepientName": {
                                        "type": "string"
                                    }
                                },
                                "additionalProperties": true
                            }
                        ]
                    }
                }
            },
            "additionalProperties": true
        }
    },
    "additionalProperties": true
}', N'{
  "$schema": "http://json-schema.org/draft-04/schema#",
  "type": "object",
  "properties": {
    "SourceRelativePath": {
      "type": "string"
    }
  },
  "required": [
    "SourceRelativePath"
  ]
}')
SET IDENTITY_INSERT [dbo].[TaskTypeMapping] OFF
