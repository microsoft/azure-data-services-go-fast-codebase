function(GFPIR="IRA", SourceType="AzureSqlTable", SourceFormat="NA", TargetType="AzureBlobFS",TargetFormat="Parquet") 
local AzureBlobFS_Parquet_CopyActivity_Output = import './Full_Load_CopyActivity_AzureBlobFS_Parquet_Outputs.libsonnet';
local AzureBlobStorage_Parquet_CopyActivity_Output = import './Full_Load_CopyActivity_AzureBlobStorage_Parquet_Outputs.libsonnet';
local AzureSqlTable_NA_CopyActivity_Inputs = import './/Full_Load_CopyActivity_AzureSqlTable_NA_Inputs.libsonnet';
local SqlServerTable_NA_CopyActivity_Inputs = import './/Full_Load_CopyActivity_SqlServerTable_NA_Inputs.libsonnet';


if(SourceType=="AzureSqlTable"&&SourceFormat=="NA"&&TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "source": {
      "type": "AzureSqlSource",
      "sqlReaderQuery": {
        "value": "@variables('SQLStatement')",
        "type": "Expression"
      },
      "queryTimeout": "02:00:00"
    },
    "sink": {
      "type": "ParquetSink",
      "storeSettings": {
        "type": "AzureBlobFSWriteSettings"
      }
    },
    "enableStaging": false,
    "parallelCopies": {
      "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
      "type": "Expression"
    },
    "translator": {
      "value": "@pipeline().parameters.Mapping",
      "type": "Expression"
    }
  },
} + AzureBlobFS_Parquet_CopyActivity_Output(GFPIR)
  + AzureSqlTable_NA_CopyActivity_Inputs(GFPIR)
else if(SourceType=="AzureSqlTable"&&SourceFormat=="NA"&&TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "source": {
      "type": "AzureSqlSource",
      "sqlReaderQuery": {
        "value": "@variables('SQLStatement')",
        "type": "Expression"
      },
      "queryTimeout": "02:00:00"
    },
    "sink": {
      "type": "ParquetSink",
      "storeSettings": {
        "type": "AzureBlobStorageWriteSettings"
      }
    },
    "enableStaging": false,
    "parallelCopies": {
      "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
      "type": "Expression"
    },
    "translator": {
      "value": "@pipeline().parameters.Mapping",
      "type": "Expression"
    }
  },
} + AzureBlobStorage_Parquet_CopyActivity_Output(GFPIR)
  + AzureSqlTable_NA_CopyActivity_Inputs(GFPIR)
  else if (SourceType=="AzureSqlTable" && SourceFormat == "NA" && TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
    "source": {
      "type": "SqlServerSource",
      "sqlReaderQuery": {
        "value": "@variables('SQLStatement')",
        "type": "Expression"
      },
      "queryTimeout": "02:00:00"
    },
    "sink": {
      "type": "ParquetSink",
      "storeSettings": {
        "type": "AzureBlobFSWriteSettings"
      }
    },
    "enableStaging": false,
    "parallelCopies": {
      "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
      "type": "Expression"
    },
    "translator": {
      "value": "@pipeline().parameters.Mapping",
      "type": "Expression"
    }
} + AzureBlobFS_Parquet_CopyActivity_Output(GFPIR)
  + SqlServerTable_NA_CopyActivity_Inputs(GFPIR)
else if (SourceType=="AzureSqlTable" && SourceFormat == "NA" && TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
    "source": {
      "type": "SqlServerSource",
      "sqlReaderQuery": {
        "value": "@variables('SQLStatement')",
        "type": "Expression"
      },
      "queryTimeout": "02:00:00"
    },
    "sink": {
      "type": "ParquetSink",
      "storeSettings": {
        "type": "AzureBlobStorageWriteSettings"
      }
    },
    "enableStaging": false,
    "parallelCopies": {
      "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
      "type": "Expression"
    },
    "translator": {
      "value": "@pipeline().parameters.Mapping",
      "type": "Expression"
    }
} + AzureBlobStorage_Parquet_CopyActivity_Output(GFPIR)
  + SqlServerTable_NA_CopyActivity_Inputs(GFPIR)
else 
  error 'CopyActivity_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+SourceFormat+","+TargetType+","+TargetFormat