function(GFPIR="IRA", SourceType="AzureBlobFS", SourceFormat="DelimitedText", TargetType="AzureSqlTable",TargetFormat="NA") 
local Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs = import './Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobFS_Excel_Inputs = import './Main_CopyActivity_AzureBlobFS_Excel_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobFS_Json_Inputs = import './Main_CopyActivity_AzureBlobFS_Json_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_DelimitedText_Inputs = import './Main_CopyActivity_AzureBlobStorage_DelimitedText_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_Excel_Inputs = import './Main_CopyActivity_AzureBlobStorage_Excel_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_Json_Inputs = import './Main_CopyActivity_AzureBlobStorage_Json_Inputs.libsonnet';
local Main_CopyActivity_AzureSqlTable_NA_Outputs = import './Main_CopyActivity_AzureSqlTable_NA_Outputs.libsonnet';

if(SourceType=="AzureBlobFS"&&SourceFormat=="Excel"&&TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
    "source": {
        "type": "ExcelSource",
        "storeSettings": {
            "type": "AzureBlobFSReadSettings",
            "recursive": true
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
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Excel_Inputs(GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GFPIR)
else if(SourceType=="AzureBlobFS"&&SourceFormat=="DelimitedText"&&TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
    "source": {
      "type": "DelimitedTextSource",
      "storeSettings": {
        "type": "AzureBlobFSReadSettings",
        "maxConcurrentConnections": {
          "value": "@pipeline().parameters.TaskObject.Source.MaxConcorrentConnections",
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
  },
}
  + Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs(GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GFPIR)
else if (SourceType=="AzureBlobFS" && SourceFormat == "Json" && TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
      "source": {
        "type": "JsonSource",
        "storeSettings": {
            "type": "AzureBlobFSReadSettings",
            "recursive": true
        },
        "formatSettings": {
            "type": "JsonReadSettings"
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
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Json_Inputs(GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GFPIR)
else if(SourceType=="AzureBlobStorage"&&SourceFormat=="Excel"&&TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
    "source": {
        "type": "ExcelSource",
        "storeSettings": {
            "type": "AzureBlobStorageReadSettings",
            "recursive": true
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
    }
  },
}
  + Main_CopyActivity_AzureBlobStorage_Excel_Inputs(GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GFPIR)
else if(SourceType=="AzureBlobStorage"&&SourceFormat=="DelimitedText"&&TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
    "source": {
      "type": "DelimitedTextSource",
      "storeSettings": {
        "type": "AzureBlobStorageReadSettings",
        "maxConcurrentConnections": {
          "value": "@pipeline().parameters.TaskObject.Source.MaxConcorrentConnections",
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
  },
}
  + Main_CopyActivity_AzureBlobStorage_DelimitedText_Inputs(GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GFPIR)
else if (SourceType=="AzureBlobStorage" && SourceFormat == "Json" && TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
      "source": {
        "type": "JsonSource",
        "storeSettings": {
            "type": "AzureBlobStorageReadSettings",
            "recursive": true
        },
        "formatSettings": {
            "type": "JsonReadSettings"
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
    }
  },
}
  + Main_CopyActivity_AzureBlobStorage_Json_Inputs(GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GFPIR)
else
  error 'Main_CopyActivity_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+SourceFormat+","+TargetType+","+TargetFormat