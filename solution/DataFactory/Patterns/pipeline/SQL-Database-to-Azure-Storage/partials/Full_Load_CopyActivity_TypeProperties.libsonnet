function(GenerateArm="false",GFPIR="IRA", SourceType="SqlServerTable", TargetType="AzureBlobFS",TargetFormat="Parquet") 
local AzureBlobFS_Parquet_CopyActivity_Output = import './Full_Load_CopyActivity_AzureBlobFS_Parquet_Outputs.libsonnet';
local AzureBlobStorage_Parquet_CopyActivity_Output = import './Full_Load_CopyActivity_AzureBlobStorage_Parquet_Outputs.libsonnet';
local AzureSqlTable_NA_CopyActivity_Inputs = import './Full_Load_CopyActivity_AzureSqlTable_NA_Inputs.libsonnet';
local OracleServerTable_NA_CopyActivity_Inputs = import './Full_Load_CopyActivity_OracleTable_NA_Inputs.libsonnet';
local SqlServerTable_NA_CopyActivity_Inputs = import './Full_Load_CopyActivity_SqlServerTable_NA_Inputs.libsonnet';
local FileServer_Parquet_CopyActivity_Output = import './Full_Load_CopyActivity_FileServer_Parquet_Outputs.libsonnet';
local AzureBlobFS_DelimitedText_CopyActivity_Output = import './Full_Load_CopyActivity_AzureBlobFS_DelimitedText_Outputs.libsonnet';
local TempOutputSuccess = import './Main_Set_Parameter_Set_Success.libsonnet';
local TempOutputFail = import './Main_Set_Parameter_Set_Fail.libsonnet';

if(SourceType=="AzureSqlTable"&&TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "MSI",
            "activities": [
                {
                    "name": "Copy Azure SQL to Storage MSIAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
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
                    "inputs": AzureSqlTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": AzureBlobFS_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy Azure SQL to Storage MSIAuth"),
                TempOutputFail("Copy Azure SQL to Storage MSIAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if(SourceType=="AzureSqlTable"&&TargetType=="AzureBlobFS"&&TargetFormat=="DelimtedText") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "MSI",
            "activities": [
                {
                    "name": "Copy Azure SQL to Storage MSIAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
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
                    "inputs": AzureSqlTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": AzureBlobFS_DelimitedText_CopyActivity_Output(GenerateArm,GFPIR)
                },
                TempOutputSuccess("Copy Azure SQL to Storage MSIAuth"),
                TempOutputFail("Copy Azure SQL to Storage MSIAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if(SourceType=="AzureSqlTable"&&TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "MSI",
            "activities": [
                {
                    "name": "Copy Azure SQL to Storage MSIAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
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
                    "inputs": AzureSqlTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": AzureBlobStorage_Parquet_CopyActivity_Output(GenerateArm,GFPIR)
                },
                TempOutputSuccess("Copy Azure SQL to Storage MSIAuth"),
                TempOutputFail("Copy Azure SQL to Storage MSIAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if(SourceType=="AzureSqlTable"&&TargetType=="FileServer"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "MSI",
            "activities": [
                {
                    "name": "Copy Azure SQL to Storage MSIAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
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
                          "type": "FileServerWriteSettings"
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
                    "inputs": AzureSqlTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": FileServer_Parquet_CopyActivity_Output(GenerateArm,GFPIR)
                },
                TempOutputSuccess("Copy Azure SQL to Storage MSIAuth"),
                TempOutputFail("Copy Azure SQL to Storage MSIAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if (SourceType=="SqlServerTable" && TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "WindowsAuth",
            "activities": [
                {
                    "name": "Copy SQL to Storage WindowsAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
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
                    },
                    "inputs": SqlServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR,"GDS_SqlServerTable_NA_"),
                    "outputs": AzureBlobFS_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy SQL to Storage WindowsAuth"),
                TempOutputFail("Copy SQL to Storage WindowsAuth")
            ]
        },
        {
            "value": "SQLAuth",
            "activities": [
                {
                    "name": "Copy SQL to Storage SQLAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
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
                    },
                    "inputs": SqlServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR,"GDS_SqlServerTable_NA_SqlAuth_"),
                    "outputs": AzureBlobFS_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy SQL to Storage SQLAuth"),
                TempOutputFail("Copy SQL to Storage SQLAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if (SourceType=="SqlServerTable" && TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "WindowsAuth",
            "activities": [
                {
                    "name": "Copy SQL to Storage WindowsAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
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
                    },
                    "inputs": SqlServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR,"GDS_SqlServerTable_NA_"),
                    "outputs": AzureBlobStorage_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy SQL to Storage WindowsAuth"),
                TempOutputFail("Copy SQL to Storage WindowsAuth")
            ]
        },
        {
            "value": "SQLAuth",
            "activities": [
                {
                    "name": "Copy SQL to Storage SQLAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
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
                    },
                    "inputs": SqlServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR,"GDS_SqlServerTable_NA_SqlAuth_"),
                    "outputs": AzureBlobStorage_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy SQL to Storage SQLAuth"),
                TempOutputFail("Copy SQL to Storage SQLAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if (SourceType=="SqlServerTable" && TargetType=="FileServer"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "WindowsAuth",
            "activities": [
                {
                    "name": "Copy SQL to Storage WindowsAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
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
                          "type": "FileServerWriteSettings"
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
                    "inputs": SqlServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR,"GDS_SqlServerTable_NA_"),
                    "outputs": FileServer_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy SQL to Storage WindowsAuth"),
                TempOutputFail("Copy SQL to Storage WindowsAuth")
            ]
        },
        {
            "value": "SQLAuth",
            "activities": [
                {
                    "name": "Copy SQL to Storage SQLAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
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
                          "type": "FileServerWriteSettings"
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
                    "inputs": SqlServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR,"GDS_SqlServerTable_NA_SqlAuth_"),
                    "outputs": FileServer_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy SQL to Storage SQLAuth"),
                TempOutputFail("Copy SQL to Storage SQLAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if (SourceType=="OracleServerTable" && TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "SID",
            "activities": [
                {
                    "name": "Copy Oracle SQL to Storage SIDAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
                      "source": {
                        "type": "OracleSource",
                        "oracleReaderQuery": {
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
                    "inputs": OracleServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": AzureBlobFS_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy Oracle SQL to Storage SIDAuth"),
                TempOutputFail("Copy Oracle SQL to Storage SIDAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if (SourceType=="OracleServerTable" && TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "SID",
            "activities": [
                {
                    "name": "Copy Oracle SQL to Storage SIDAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
                      "source": {
                        "type": "OracleSource",
                        "oracleReaderQuery": {
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
                    "inputs": OracleServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": AzureBlobStorage_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy Oracle SQL to Storage SIDAuth"),
                TempOutputFail("Copy Oracle SQL to Storage SIDAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else if (SourceType=="OracleServerTable" && TargetType=="FileServer"&&TargetFormat=="Parquet") then
{
  "typeProperties": {
    "on": {
        "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
        "type": "Expression"
    },
    "cases": [
        {
            "value": "SID",
            "activities": [
                {
                    "name": "Copy Oracle SQL to Storage SIDAuth",
                    "type": "Copy",
                    "dependsOn": [],
                    "policy": {
                        "timeout": "7.00:00:00",
                        "retry": 0,
                        "retryIntervalInSeconds": 30,
                        "secureOutput": false,
                        "secureInput": false
                    },
                    "userProperties": [],
                    "typeProperties": {
                      "source": {
                        "type": "OracleSource",
                        "oracleReaderQuery": {
                          "value": "@variables('SQLStatement')",
                          "type": "Expression"
                        },
                        "queryTimeout": "02:00:00"
                      },
                      "sink": {
                        "type": "ParquetSink",
                        "storeSettings": {
                          "type": "FileServerWriteSettings"
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
                    "inputs": OracleServerTable_NA_CopyActivity_Inputs(GenerateArm,GFPIR),
                    "outputs": FileServer_Parquet_CopyActivity_Output(GenerateArm,GFPIR),
                },
                TempOutputSuccess("Copy Oracle SQL to Storage SIDAuth"),
                TempOutputFail("Copy Oracle SQL to Storage SIDAuth")
            ]
        }
    ],
    "defaultActivities": [
        {
            "name": "Failure",
            "type": "Fail",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "message": "No Valid Auth Type Provided",
                "errorCode": "400"
            }
        }
    ]
  }
}
else 
  error 'CopyActivity_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+TargetType+","+TargetFormat