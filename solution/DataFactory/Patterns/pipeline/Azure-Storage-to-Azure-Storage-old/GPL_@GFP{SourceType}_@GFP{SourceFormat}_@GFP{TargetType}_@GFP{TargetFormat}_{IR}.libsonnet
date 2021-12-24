function(GenerateArm="false",GFPIR="IRA",SourceType="AzureBlobFS",SourceFormat="Binary",TargetType="AzureBlobFS",TargetFormat="Binary")
{
    local sourceStoreSettings = import './partials/Source_Store_Settings.libsonnet',
    local sinkStoreSettings = import './partials/Sink_Store_Settings.libsonnet',

    local inputs = import './partials/Inputs.libsonnet',
    local outputs = import './partials/Outputs.libsonnet',

    local parameterDefaultValue = import './partials/Parameter_Default_Value.libsonnet',

	local copyActivityName = "Copy %(Source)s-%(SourceFormat)s to %(Target)s-%(TargetFormat)s" % {Source: SourceType, SourceFormat: SourceFormat, Target: TargetType, TargetFormat: TargetFormat},

	local successActivityName = "%(ActivityName)s Succeed" % {ActivityName: copyActivityName},
	local startActivityName = "%(ActivityName)s Started" % {ActivityName: copyActivityName},
	local failActivityName = "%(ActivityName)s Failed" % {ActivityName: copyActivityName},

    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "integrationRuntimeShortName": {
            "type": "string",
            "metadata": "The name of the integration runtime this pipeline uses"
        }		
    },
    "resources": [
		{
			"apiVersion": "2018-06-01",
			"name": "[concat('GPL_%(Source)s_%(SourceFormat)s_%(Target)s_%(TargetFormat)s_', parameters('integrationRuntimeShortName'))]" % {Source: SourceType, SourceFormat: SourceFormat, Target: TargetType, TargetFormat: TargetFormat},
			"properties": {
				"activities": [
					{
						"name": copyActivityName,
						"type": "Copy",
						"dependsOn": [
							{
								"activity": startActivityName,
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
								"storeSettings": sourceStoreSettings(SourceType, SourceFormat, GFPIR),
								"formatSettings": {
									"type": "BinaryReadSettings"
								}
							},
							"sink": {
								"type": "BinarySink",
								"storeSettings": sinkStoreSettings(TargetType, TargetFormat, GFPIR),
							},
							"enableStaging": false,
							"parallelCopies": {
								"value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
								"type": "Expression"
							}
						},
						"inputs": [inputs(SourceType)],
						"outputs": [outputs(TargetType)]
					},
					{
					"name": failActivityName,
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
							"referenceName": "SPL_AzureFunction",
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
					"name": startActivityName,
					"type": "ExecutePipeline",
					"dependsOn": [],
					"userProperties": [],
					"typeProperties": {
						"pipeline": {
							"referenceName": "SPL_AzureFunction",
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
					"name": successActivityName,
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
							"referenceName": "SPL_AzureFunction",
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
				"parameters": parameterDefaultValue(SourceType, SourceFormat),
				"folder": {
					"name" : "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeShortName'))]",
				},
				"annotations": [],
				"lastPublishTime": "2020-08-05T04:14:00Z"
			},
			"type": "Microsoft.DataFactory/factories/pipelines"
		}
	]
}