function(
    Name = "GPL_AzureSqlTable_NA_AzureBlobStorage_Parquet_IRA",
    CalledPipelineName = "",
    Folder = ""
)
{
    "name": Name,
    "properties": {
        "activities": [
            {
                "name": "Execute Main Pipeline",
                "type": "ExecutePipeline",
                "dependsOn": [],
                "userProperties": [],
                "typeProperties": {
                    "pipeline": {
                        "referenceName": CalledPipelineName,
                        "type": "PipelineReference"
                    },
                    "waitOnCompletion": true,
                    "parameters": {
                        "TaskObject": {
                            "value": "@pipeline().parameters.TaskObject",
                            "type": "Expression"
                        }
                    }
                }
            },
            {
                "name": "Pipeline AF Log - Failed",
                "type": "ExecutePipeline",
                "dependsOn": [
                    {
                        "activity": "Execute Main Pipeline",
                        "dependencyConditions": [
                            "Failed"
                        ]
                    }
                ],
                "userProperties": [],
                "typeProperties": {
                    "pipeline": {
                        "referenceName": "SPL_AzureFunction",
                        "type": "PipelineReference"
                    },
                    "waitOnCompletion": true,
                    "parameters": {
                        "Body": {
                            "value": "@json(\n    concat(\n        '{\"TaskInstanceId\":\"', \n        string(pipeline().parameters.TaskObject.TaskInstanceId), \n        '\",\"ExecutionUid\":\"', \n        string(pipeline().parameters.TaskObject.ExecutionUid), \n        '\",\"RunId\":\"', \n        string(pipeline().RunId), \n        '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Data-Movement-Master\",\"StartDateTimeOffSet\":\"', \n        string(pipeline().TriggerTime), \n        '\",\"EndDateTimeOffSet\":\"', \n        string(utcNow()), \n        '\",\"Comment\":\"', \n        replace(replace(\n                string(activity('Execute Main Pipeline').error.message), '\"',''\n                ), '''',''), \n        '\",\"Status\":\"Failed\",\"NumberOfRetries\":\"', \n        string(pipeline().parameters.TaskObject.NumberOfRetries),\n        '\"}'\n    )\n)",
                            "type": "Expression"
                        },
                        "FunctionName": "Log",
                        "Method": "Post"
                    }
                }
            },
            {
                "name": "Pipeline AF Log - Succeed",
                "type": "ExecutePipeline",
                "dependsOn": [
                    {
                        "activity": "Execute Main Pipeline",
                        "dependencyConditions": [
                            "Succeeded"
                        ]
                    }
                ],
                "userProperties": [],
                "typeProperties": {
                    "pipeline": {
                        "referenceName": "SPL_AzureFunction",
                        "type": "PipelineReference"
                    },
                    "waitOnCompletion": true,
                    "parameters": {
                        "Body": {
                            "value": "@json(\n    concat(\n        '{\"TaskInstanceId\":\"', \n        string(\n            pipeline().parameters.TaskObject.TaskInstanceId\n            ), \n        '\",\"ExecutionUid\":\"', \n        string(pipeline().parameters.TaskObject.ExecutionUid), \n        '\",\"RunId\":\"', \n        string(pipeline().RunId), \n        '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Data-Movement-Master\",\"StartDateTimeOffSet\":\"', \n        string(pipeline().TriggerTime), \n        '\",\"EndDateTimeOffSet\":\"', \n        string(utcNow()), \n        '\",\"Comment\":\"\",\"Status\":\"Complete\",\"NumberOfRetries\":\"', \n        string(pipeline().parameters.TaskObject.NumberOfRetries),\n        '\"}'\n    )\n)",
                            "type": "Expression"
                        },
                        "FunctionName": "Log",
                        "Method": "Post"
                    }
                }
            }
        ],
        "parameters": {
            "TaskObject": {
                "type": "object"
            }
        },
        "folder": {
            "name": Folder
        },
        "annotations": [],
        "lastPublishTime": "2020-08-06T06:27:14Z"
    },
    "type": "Microsoft.Synapse/workspaces/pipelines"
}