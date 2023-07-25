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
                            "value": "@json(\n    concat(\n        '{\"TaskInstanceId\":\"', \n        string(\n            json(string(pipeline().parameters.TaskObject)).TaskInstanceId\n            ), \n        '\",\"ExecutionUid\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).ExecutionUid),\n        '\",\"TaskMasterId\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TaskMasterId),\n        '\",\"TaskMasterName\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TaskMasterName), \n        '\",\"NotificationList\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TMOptionals.NotificationList),\n        '\",\"NotificationOn\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TMOptionals.NotificationOn),\n        '\",\"RunId\":\"', \n        string(pipeline().RunId), \n        '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Data-Movement-Master\",\"StartDateTimeOffSet\":\"', \n        string(pipeline().TriggerTime), \n        '\",\"EndDateTimeOffSet\":\"', \n        string(utcNow()), \n        '\",\"Comment\":\"', \n       encodeUriComponent(\n                string(activity('Execute Main Pipeline').error.message)), \n        '\",\"Status\":\"Failed\",\"NumberOfRetries\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).NumberOfRetries),\n        '\"}'\n    )\n)",
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
                            "value": "@json(\n    concat(\n        '{\"TaskInstanceId\":\"', \n        string(\n            json(string(pipeline().parameters.TaskObject)).TaskInstanceId\n            ), \n        '\",\"ExecutionUid\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).ExecutionUid),\n        '\",\"TaskMasterId\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TaskMasterId),\n        '\",\"TaskMasterName\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TaskMasterName), \n        '\",\"NotificationList\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TMOptionals.NotificationList),\n        '\",\"NotificationOn\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).TMOptionals.NotificationOn),\n        '\",\"RunId\":\"', \n        string(pipeline().RunId), \n        '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Data-Movement-Master\",\"StartDateTimeOffSet\":\"', \n        string(pipeline().TriggerTime), \n        '\",\"EndDateTimeOffSet\":\"', \n        string(utcNow()), \n        '\",\"Comment\":\"\",\"Status\":\"Complete\",\"NumberOfRetries\":\"', \n        string(json(string(pipeline().parameters.TaskObject)).NumberOfRetries),\n        '\"}'\n    )\n)",
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