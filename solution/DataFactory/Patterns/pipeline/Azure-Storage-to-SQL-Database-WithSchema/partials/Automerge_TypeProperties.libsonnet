function(GFPIR="IRA", TargetType="AzureBlobFS",TargetFormat="Parquet") 
if(TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
    "source": {
        "type": "AzureSqlSource",
        "sqlReaderQuery": {
            "value": "@activity('AF Get Information Schema SQL Stage').output.InformationSchemaSQL",
            "type": "Expression"
        },
        "queryTimeout": "02:00:00",
        "partitionOption": "None"
    },
    "dataset": {
        "referenceName": "AzureSqlTable_" + GFPIR,
        "type": "DatasetReference",
        "parameters": {
            "Schema": {
                "value": "@pipeline().parameters.TaskObject.Target.StagingTableSchema",
                "type": "Expression"
            },
            "Table": {
                "value": "@pipeline().parameters.TaskObject.Target.StagingTableName",
                "type": "Expression"
            },
            "Server": {
                "value": "@pipeline().parameters.TaskObject.Target.Database.SystemName",
                "type": "Expression"
            },
            "Database": {
                "value": "@pipeline().parameters.TaskObject.Target.Database.Name",
                "type": "Expression"
            }
        }
    },
    "firstRowOnly": false
}
else if (TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
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
}
else 
  error 'CopyActivity_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+SourceFormat