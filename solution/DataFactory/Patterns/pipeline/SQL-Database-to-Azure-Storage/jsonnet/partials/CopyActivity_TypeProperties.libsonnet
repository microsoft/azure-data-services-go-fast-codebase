function(GFPIR="IRA", SourceType="AzureSqlTable", SourceFormat="NA", TargetType="AzureBlobFS",TargetFormat="Parquet") 
local AzureBlobFS_Parquet_CopyActivity_Output = import './AzureBlobFS_Parquet_CopyActivity_Outputs.libsonnet';
local AzureSqlTable_NA_CopyActivity_Inputs = import './/AzureSqlTable_NA_CopyActivity_Inputs.libsonnet';

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
  inputs:[{
  "referenceName": "GDS_AzureSqlTable_NA_" + GFPIR,
  "type": "DatasetReference",
  "parameters": {
    "Schema": {
      "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableSchema",
      "type": "Expression"
    },
    "Table": {
      "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableName",
      "type": "Expression"
    },
    "Server": {
      "value": "@pipeline().parameters.TaskObject.Source.Database.SystemName",
      "type": "Expression"
    },
    "Database": {
      "value": "@pipeline().parameters.TaskObject.Source.Database.Name",
      "type": "Expression"
    }
  }
  }], 
  outputs:
  [{
  "referenceName": "GDS_AzureBlobStorage_Parquet_" + GFPIR,
  "type": "DatasetReference",
  "parameters": {
    "RelativePath": {
      "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
      "type": "Expression"
    },
    "FileName": {
      "value": "@replace(pipeline().parameters.TaskObject.Target.DataFileName,'.parquet',concat('.chunk_', string(pipeline().parameters.Item),'.parquet'))",
      "type": "Expression"
    },
    "StorageAccountEndpoint": {
      "value": "@pipeline().parameters.TaskObject.Target.StorageAccountName",
      "type": "Expression"
    },
    "StorageAccountContainerName": {
      "value": "@pipeline().parameters.TaskObject.Target.StorageAccountContainer",
      "type": "Expression"
    }
  }
  }]
}
else if (SourceType=="AzureSqlTable" && SourceFormat == "NA" && TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
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
  "inputs":[{
    "referenceName": "GDS_SqlServerTable_NA_" + GFPIR,
    "type": "DatasetReference",
    "parameters": {
      "TableSchema": {
        "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableSchema",
        "type": "Expression"
      },
      "TableName": {
        "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableName",
        "type": "Expression"
      },
      "KeyVaultBaseUrl": {
        "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
        "type": "Expression"
      },
      "PasswordSecret": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.PasswordKeyVaultSecretName",
        "type": "Expression"
      },
      "Server": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.SystemName",
        "type": "Expression"
      },
      "Database": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.Name",
        "type": "Expression"
      },
      "UserName": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.Username",
        "type": "Expression"
      }
    }
  }],
  "outputs":[{
  "referenceName": "GDS_AzureBlobStorage_Parquet_" + GFPIR,
  "type": "DatasetReference",
  "parameters": {
    "RelativePath": {
      "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
      "type": "Expression"
    },
    "FileName": {
      "value": "@replace(pipeline().parameters.TaskObject.Target.DataFileName,'.parquet',concat('.chunk_', string(pipeline().parameters.Item),'.parquet'))",
      "type": "Expression"
    },
    "StorageAccountEndpoint": {
      "value": "@pipeline().parameters.TaskObject.Target.StorageAccountName",
      "type": "Expression"
    },
    "StorageAccountContainerName": {
      "value": "@pipeline().parameters.TaskObject.Target.StorageAccountContainer",
      "type": "Expression"
    }
  }
  }]
}
else 
  error 'CopyActivity_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+SourceFormat