function(GFPIR="IRA") {
  "source": {
    "type": "ParquetSource",
    "storeSettings": {
      "type": "AzureBlobStorageReadSettings",
      "recursive": false,
      "wildcardFolderPath": {
        "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
        "type": "Expression"
      },
      "wildcardFileName": "*.parquet",
      "enablePartitionDiscovery": false
    }
  },
  "sink": {
    "type": "AzureSqlSink",
    "preCopyScript": {
      "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
      "type": "Expression"
    },
    "disableMetricsCollection": false
  },
  "enableStaging": false,
  "parallelCopies": {
    "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
    "type": "Expression"
  },
  "translator": {
    "value": "@activity('AF Get Mapping').output.value",
    "type": "Expression"
  }
}

