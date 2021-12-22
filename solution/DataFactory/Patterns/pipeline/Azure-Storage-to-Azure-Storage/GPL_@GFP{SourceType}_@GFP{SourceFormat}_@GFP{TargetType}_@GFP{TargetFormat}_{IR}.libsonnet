function(GFPIR="{IRA}",SourceType="AzureBlobFS",TargetType="AzureBlobFS")
{
    local sourceStoreSettings = import './partials/Source_Store_Settings.libsonnet',
    local sinkStoreSettings = import './partials/Sink_Store_Settings.libsonnet',

    local inputs = import './partials/Inputs.libsonnet',
    local outputs = import './partials/Outputs.libsonnet',

    local parameterDefaultValue = import './partials/Parameter_Default_Value.libsonnet',

	local copyActivityName = "Copy %(Source)s to %(Target)s" % {Source: SourceType, Target: TargetType},
	local globalName = "GLP_%(Source)s_%(Target)s_%(IRA)s" % {Source: SourceType, Target: TargetType, IRA: GFPIR},

	local successMessage = "Pipeline AF Log - %(Source)s to %(Target)s Succeed" % {Source: SourceType, Target: TargetType},
	local startMessage = "Pipeline AF Log - %(Source)s to %(Target)s Start" % {Source: SourceType, Target: TargetType},
	local failMessage = "Pipeline AF Log - %(Source)s to %(Target)s Failed" % {Source: SourceType, Target: TargetType},
	local copyMessage = "Pipefile AF Log - %(Source)s to %(Target)s Start" % {Source: SourceType, Target: TargetType},

	"name": globalName,
	"properties": {
		"activities": [
            {
                "name": copyActivityName,
                "type": "Copy",
                "dependsOn": [
                    {
                        "activity": copyMessage,
                        "dependencyConditions": [
                            "Succeeded"
                        ]
                    }
                ],
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
                        "type": "BinarySource",
                        "storeSettings": sourceStoreSettings(SourceType),
                        "formatSettings": {
                            "type": "BinaryReadSettings"
                        }
                    },
                    "sink": {
                        "type": "BinarySink",
                        "storeSettings": sinkStoreSettings(TargetType),
                    },
                    "enableStaging": false,
                    "parallelCopies": {
                        "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
                        "type": "Expression"
                    }
                },
                "inputs": [inputs(SourceType, GFPIR)],
                "outputs": [outputs(TargetType, GFPIR)]
            },
			{
			"name": failMessage,
			"type": "ExecutePipeline",
			"dependsOn": [
				{
					"activity": copyActivityName,
					"dependencyConditions": [
						"Failed"
					]
				}
			],
			"userProperties": [],
			"typeProperties": {
				"pipeline": {
					"referenceName": "GPL_AzureFunction_Common",
					"type": "PipelineReference"
				},
				"waitOnCompletion": false,
				"parameters": {
					"Body": {
						"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy Blob to Blob\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('" + copyActivityName + "').error.message), '\",\"Status\":\"Failed\"}'))",
						"type": "Expression"
					},
					"FunctionName": "Log",
					"Method": "Post"
				}
			}
		},
		{
			"name": startMessage,
			"type": "ExecutePipeline",
			"dependsOn": [],
			"userProperties": [],
			"typeProperties": {
				"pipeline": {
					"referenceName": "GPL_AzureFunction_Common",
					"type": "PipelineReference"
				},
				"waitOnCompletion": false,
				"parameters": {
					"Body": {
						"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":3,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy Blob to Blob\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"Status\":\"Started\"}'))",
						"type": "Expression"
					},
					"FunctionName": "Log",
					"Method": "Post"
				}
			}
		},
		{
			"name": successMessage,
			"type": "ExecutePipeline",
			"dependsOn": [
				{
					"activity": copyActivityName,
					"dependencyConditions": [
						"Succeeded"
					]
				}
			],
			"userProperties": [],
			"typeProperties": {
				"pipeline": {
					"referenceName": "GPL_AzureFunction_Common",
					"type": "PipelineReference"
				},
				"waitOnCompletion": false,
				"parameters": {
					"Body": {
						"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy Blob to Blob\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"RowsInserted\":\"', string(activity('" + copyActivityName + "').output.filesWritten), '\",\"Comment\":\"\",\"Status\":\"Complete\"}'))",
						"type": "Expression"
					},
					"FunctionName": "Log",
					"Method": "Post"
				}
			}
		}
		],
		"parameters": parameterDefaultValue(SourceType),
		"folder": {
			"name": "ADS Go Fast/Data Movement/" + GFPIR
		},
		"annotations": [],
		"lastPublishTime": "2020-08-05T04:14:00Z"
	},
	"type": "Microsoft.DataFactory/factories/pipelines"
}