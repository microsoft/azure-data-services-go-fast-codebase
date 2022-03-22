function(GFPIR="IRA") {
  "source": {
    "type": "DelimitedTextSource",
    "storeSettings": {
      "type": "AzureBlobFSReadSettings",
      "maxConcurrentConnections": {
        "value": "@pipeline().parameters.TaskObject.Source.MaxConcurrentConnections",
        "type": "Expression"
      },
      "recursive": true,
      "wildcardFolderPath": {
        "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
        "type": "Expression"
      },
      "wildcardFileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
      },
      "enablePartitionDiscovery": false
    },
    "formatSettings": {
      "type": "DelimitedTextReadSettings",
      "skipLineCount": {
        "value": "@pipeline().parameters.TaskObject.Source.SkipLineCount",
        "type": "Expression"
      }
    }
  },
  "sink": {
    "type": "AzureSqlSink",
    "preCopyScript": {
      "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
      "type": "Expression"
    },
    "tableOption": "autoCreate",
    "disableMetricsCollection": false
  },
  "enableStaging": false,
  "parallelCopies": {
    "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
    "type": "Expression"
  },
  "translator": {
    "value": "@pipeline().parameters.TaskObject.Target.DynamicMapping",
    "type": "Expression"
  }
}

