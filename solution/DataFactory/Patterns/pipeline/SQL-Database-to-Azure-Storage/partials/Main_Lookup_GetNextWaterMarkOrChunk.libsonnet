function(GenerateArm="false",GFPIR="IRA", SourceType="SqlServerTable", TargetType="", TargetFormat="")
local Watermarksource = import './Partial_GetNextWaterMarkOrChunk.libsonnet';
if (SourceType=="AzureSqlTable" ) then
{
  local referenceName = "GDS_AzureSqlTable_NA_",
  "on": {
    "value": "@variables('CaseCheck')",
    "type": "Expression"
  },
  "cases": [
    {
      "value": "Full",
      "activities": [
        {
          "name": "Execute Full_Load Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {
              "referenceName": 	if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": "1",
              "Item": "1"
            }
          }
        }
      ]
    },
    {
      "value": "WatermarkMSI",
      "activities": [
        {
          "name": "Execute Watermark Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {										
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
                                    "BatchCount": {
                                        "value": "@int('1')",
                                        "type": "Expression"
                                    },
                                    "Mapping": {
                                        "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                                        "type": "Expression"
                                    },
                                    "NewWatermark": {
                                        "value": "@activity('Lookup New Watermark').output.firstRow.newWatermark",
                                        "type": "Expression"
                                    },
                                    "TaskObject": {
                                        "value": "@pipeline().parameters.TaskObject",
                                        "type": "Expression"
                                    }
                                }
          }
        },
        {
          "name": "Lookup New Watermark",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR, SourceType, referenceName)
        }
      ]
    },
    {
      "value": "Full_ChunkMSI",
      "activities": [
        {
          "name": "Execute Full Load Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,SourceType,referenceName)
        }
      ]
    },
    {
      "value": "Watermark_ChunkMSI",
      "activities": [
        {
          "name": "Execute Watermark Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark and Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "NewWatermark": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.newWatermark",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup New Watermark and Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, referenceName)
        }
      ]
    }
  ]
}
else
if (SourceType=="SqlServerTable") then
{
  local referenceName = "GDS_SqlServerTable_NA_",
  local referenceNameSql = "GDS_SqlServerTable_NA_SqlAuth_",
  "on": {
    "value": "@variables('CaseCheck')",
    "type": "Expression"
  },
  "cases": [
    {
      "value": "Full",
      "activities": [
        {
          "name": "Execute Full_Load Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {
              "referenceName": 	if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": "1",
              "Item": "1"
            }
          }
        }
      ]
    },
    {
      "value": "WatermarkWindowsAuth",
      "activities": [
        {
          "name": "Execute Watermark Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {										
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
                                    "BatchCount": {
                                        "value": "@int('1')",
                                        "type": "Expression"
                                    },
                                    "Mapping": {
                                        "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                                        "type": "Expression"
                                    },
                                    "NewWatermark": {
                                        "value": "@activity('Lookup New Watermark').output.firstRow.newWatermark",
                                        "type": "Expression"
                                    },
                                    "TaskObject": {
                                        "value": "@pipeline().parameters.TaskObject",
                                        "type": "Expression"
                                    }
                                }
          }
        },
        {
          "name": "Lookup New Watermark",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR, SourceType, referenceName)
        }
      ]
    },
    {
      "value": "Full_ChunkWindowsAuth",
      "activities": [
        {
          "name": "Execute Full Load Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,SourceType,referenceName)
        }
      ]
    },
    {
      "value": "Watermark_ChunkWindowsAuth",
      "activities": [
        {
          "name": "Execute Watermark Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark and Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "NewWatermark": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.newWatermark",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup New Watermark and Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, referenceName)
        }
      ]
    },
    {
      "value": "WatermarkSQLAuth",
      "activities": [
        {
          "name": "Execute Watermark Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {										
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
                                    "BatchCount": {
                                        "value": "@int('1')",
                                        "type": "Expression"
                                    },
                                    "Mapping": {
                                        "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                                        "type": "Expression"
                                    },
                                    "NewWatermark": {
                                        "value": "@activity('Lookup New Watermark').output.firstRow.newWatermark",
                                        "type": "Expression"
                                    },
                                    "TaskObject": {
                                        "value": "@pipeline().parameters.TaskObject",
                                        "type": "Expression"
                                    }
                                }
          }
        },
        {
          "name": "Lookup New Watermark",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR, SourceType, referenceNameSql)
        }
      ]
    },
    {
      "value": "Full_ChunkSQLAuth",
      "activities": [
        {
          "name": "Execute Full Load Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,SourceType,referenceNameSql)
        }
      ]
    },
    {
      "value": "Watermark_ChunkSQLAuth",
      "activities": [
        {
          "name": "Execute Watermark Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark and Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "NewWatermark": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.newWatermark",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup New Watermark and Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, referenceNameSql)
        }
      ]
    }
  ]
}
else
if (SourceType=="OracleServerTable") then
{
  local referenceName = "GDS_OracleServerTable_NA_",
  "on": {
    "value": "@variables('CaseCheck')",
    "type": "Expression"
  },
  "cases": [
    {
      "value": "Full",
      "activities": [
        {
          "name": "Execute Full_Load Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {
              "referenceName": 	if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": "1",
              "Item": "1"
            }
          }
        }
      ]
    },
    {
      "value": "WatermarkSID",
      "activities": [
        {
          "name": "Execute Watermark Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {										
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
                                    "BatchCount": {
                                        "value": "@int('1')",
                                        "type": "Expression"
                                    },
                                    "Mapping": {
                                        "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                                        "type": "Expression"
                                    },
                                    "NewWatermark": {
                                        "value": "@activity('Lookup New Watermark').output.firstRow.newWatermark",
                                        "type": "Expression"
                                    },
                                    "TaskObject": {
                                        "value": "@pipeline().parameters.TaskObject",
                                        "type": "Expression"
                                    }
                                }
          }
        },
        {
          "name": "Lookup New Watermark",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR, SourceType, referenceName)
        }
      ]
    },
    {
      "value": "Full_ChunkSID",
      "activities": [
        {
          "name": "Execute Full Load Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,SourceType,referenceName)
        }
      ]
    },
    {
      "value": "Watermark_ChunkSID",
      "activities": [
        {
          "name": "Execute Watermark Chunk Pipeline",
          "type": "ExecutePipeline",
          "dependsOn": [
            {
              "activity": "Lookup New Watermark and Chunk",
              "dependencyConditions": [
                "Succeeded"
              ]
            }
          ],
          "userProperties": [],
          "typeProperties": {
            "pipeline": {											
              "referenceName": if(GenerateArm=="false") 
                        then "GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
                        else "[concat('GPL_"+SourceType+"_"+"NA"+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
              "type": "PipelineReference"
            },
            "waitOnCompletion": true,
            "parameters": {
              "TaskObject": {
                "value": "@pipeline().parameters.TaskObject",
                "type": "Expression"
              },
              "Mapping": {
                "value": "@activity('AF Persist Metadata and Get Mapping').output.value",
                "type": "Expression"
              },
              "NewWatermark": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.newWatermark",
                "type": "Expression"
              },
              "BatchCount": {
                "value": "@activity('Lookup New Watermark and Chunk').output.firstRow.batchcount",
                "type": "Expression"
              }
            }
          }
        },
        {
          "name": "Lookup New Watermark and Chunk",
          "type": "Lookup",
          "dependsOn": [],
          "policy": {
            "timeout": "0.00:30:00",
            "retry": 0,
            "retryIntervalInSeconds": 30,
            "secureOutput": false,
            "secureInput": false
          },
          "userProperties": [],
          "typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, referenceName)
        }
      ]
    }
  ]
}
else 
   error 'Main_Lookup_GetNextWaterMarkOrChunk.libsonnet failed. No mapping for:' +GFPIR+","+SourceType