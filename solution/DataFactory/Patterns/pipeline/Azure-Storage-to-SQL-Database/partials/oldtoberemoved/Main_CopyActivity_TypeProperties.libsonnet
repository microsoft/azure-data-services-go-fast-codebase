function(GenerateArm=false,GFPIR="IRA", SourceType="AzureBlobFS", SourceFormat="Parquet", TargetType="AzureSqlTable",TargetFormat="NA") 
local Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs = import './Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobFS_Excel_Inputs = import './Main_CopyActivity_AzureBlobFS_Excel_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobFS_Json_Inputs = import './Main_CopyActivity_AzureBlobFS_Json_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_DelimitedText_Inputs = import './Main_CopyActivity_AzureBlobStorage_DelimitedText_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_Excel_Inputs = import './Main_CopyActivity_AzureBlobStorage_Excel_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_Json_Inputs = import './Main_CopyActivity_AzureBlobStorage_Json_Inputs.libsonnet';
local Main_CopyActivity_AzureSqlTable_NA_Outputs = import './Main_CopyActivity_AzureSqlTable_NA_Outputs.libsonnet';
local Main_CopyActivity_AzureSqlDWTable_NA_Outputs = import './Main_CopyActivity_AzureSqlDWTable_NA_Outputs.libsonnet';
local Main_CopyActivity_AzureBlobFS_Parquet_Inputs = import './Main_CopyActivity_AzureBlobFS_Parquet_Inputs.libsonnet';
local Main_CopyActivity_AzureBlobStorage_Parquet_Inputs = import './Main_CopyActivity_AzureBlobStorage_Parquet_Inputs.libsonnet';


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
    },
    "translator": {
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Excel_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if(SourceType=="AzureBlobFS"&&SourceFormat=="DelimitedText"&&TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
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
          "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
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
  + Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
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
    },
    "translator": {
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Json_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if (SourceType=="AzureBlobFS" && SourceFormat == "Parquet" && TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
      "source": {
        "type": "ParquetSource",
        "storeSettings": {
            "type": "AzureBlobFSReadSettings",
            "recursive": false,
            "wildcardFolderPath": {
                                      "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
                                      "type": "Expression"
                                  },
            "wildcardFileName": {
                                      "value": "@concat(\n    replace(\n        pipeline().parameters.TaskObject.Source.DataFileName,\n        '.parquet',\n        ''\n        ),\n    '*.parquet'\n)",
                                      "type": "Expression"
                                  },
            "enablePartitionDiscovery": false
        },
        "formatSettings": {
            "type": "AzureBlobFSReadSettings"
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
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Parquet_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if (SourceType=="AzureBlobFS" && SourceFormat == "Parquet" && TargetType=="AzureSqlDWTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
      "source": {
        "type": "ParquetSource",
        "storeSettings": {
            "type": "AzureBlobFSReadSettings",
            "recursive": false,
            "wildcardFolderPath": {
                                      "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
                                      "type": "Expression"
                                  },
            "wildcardFileName": {
                                      "value": "@concat(\n    replace(\n        pipeline().parameters.TaskObject.Source.DataFileName,\n        '.parquet',\n        ''\n        ),\n    '*.parquet'\n)",
                                      "type": "Expression"
                                  },
            "enablePartitionDiscovery": false
        },
        "formatSettings": {
            "type": "AzureBlobFSReadSettings"
        }
    },
    "sink": {
        "type": "SqlDWSink",
        "preCopyScript": {
            "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
            "type": "Expression"
        },
        "allowPolyBase": true,
        "polyBaseSettings": {
            "rejectValue": 0,
            "rejectType": "value",
            "useTypeDefault": true
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
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Parquet_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlDWTable_NA_Outputs(GenerateArm,GFPIR)
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
    },
    "translator": {
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobStorage_Excel_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if(SourceType=="AzureBlobStorage"&&SourceFormat=="DelimitedText"&&TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
    "source": {
      "type": "DelimitedTextSource",
      "storeSettings": {
        "type": "AzureBlobStorageReadSettings",
        "maxConcurrentConnections": {
          "value": "@pipeline().parameters.TaskObject.Source.MaxConcurrentConnections",
          "type": "Expression"
        },
        "recursive": true,
        "wildcardFolderPath": {
          "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
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
  + Main_CopyActivity_AzureBlobStorage_DelimitedText_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
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
        "tableOption": "autoCreate",
        "disableMetricsCollection": false
    },
    "enableStaging": false,
    "parallelCopies": {
        "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
        "type": "Expression"
    },
    "translator": {
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobStorage_Json_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if (SourceType=="AzureBlobStorage" && SourceFormat == "Parquet" && TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
      "source": {
        "type": "ParquetSource",
        "storeSettings": {
            "type": "AzureBlobStorageReadSettings",
            "recursive": true,
            "wildcardFolderPath": {
                                      "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
                                      "type": "Expression"
                                  },
            "wildcardFileName": {
                                      "value": "@concat(\n    replace(\n        pipeline().parameters.TaskObject.Source.DataFileName,\n        '.parquet',\n        ''\n        ),\n    '*.parquet'\n)",
                                      "type": "Expression"
                                  },
            "enablePartitionDiscovery": false
        },
        "formatSettings": {
            "type": "AzureBlobStorageReadSettings"
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
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobStorage_Parquet_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if (SourceType=="AzureBlobStorage" && SourceFormat == "Parquet" && TargetType=="AzureSqlDWTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
      "source": {
        "type": "ParquetSource",
        "storeSettings": {
            "type": "AzureBlobStorageReadSettings",
            "recursive": false,
            "wildcardFolderPath": {
                                      "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
                                      "type": "Expression"
                                  },
            "wildcardFileName": {
                                      "value": "@concat(\n    replace(\n        pipeline().parameters.TaskObject.Source.DataFileName,\n        '.parquet',\n        ''\n        ),\n    '*.parquet'\n)",
                                      "type": "Expression"
                                  },
            "enablePartitionDiscovery": false
        },
        "formatSettings": {
            "type": "AzureBlobStorageReadSettings"
        }
    },
    "sink": {
        "type": "SqlDWSink",
        "preCopyScript": {
            "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
            "type": "Expression"
        },
        "allowPolyBase": true,
        "polyBaseSettings": {
            "rejectValue": 0,
            "rejectType": "value",
            "useTypeDefault": true
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
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobStorage_Parquet_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlDWTable_NA_Outputs(GenerateArm,GFPIR)
else if(SourceType=="AzureBlobFS"&&SourceFormat=="Excel"&&TargetType=="AzureSqlDWTable"&&TargetFormat=="NA") then
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
    },
    "translator": {
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Excel_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if(SourceType=="AzureBlobFS"&&SourceFormat=="DelimitedText"&&TargetType=="AzureSqlDWTable"&&TargetFormat=="NA") then
{
  "typeProperties": {    
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
          "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
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
  + Main_CopyActivity_AzureBlobFS_DelimitedText_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)
else if (SourceType=="AzureBlobFS" && SourceFormat == "Json" && TargetType=="AzureSqlDWTable"&&TargetFormat=="NA") then
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
    },
    "translator": {
        "value": "@if(and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable)),activity('AF Get Mapping').output.value, null)",
        "type": "Expression"
    }
  },
}
  + Main_CopyActivity_AzureBlobFS_Json_Inputs(GenerateArm,GFPIR)
  + Main_CopyActivity_AzureSqlTable_NA_Outputs(GenerateArm,GFPIR)

else
  error 'Main_CopyActivity_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+SourceFormat+","+TargetType+","+TargetFormat