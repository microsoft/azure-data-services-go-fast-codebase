function(SourceType,TargetType, SourceFormat, TargetFormat)
{
	// Done Binary - Binary
	// Done Excel - CSV

    local sourceStoreSettings = import './partials/Source_Store_Settings.libsonnet',
    local sinkStoreSettings = import './partials/Sink_Store_Settings.libsonnet',

    local inputs = import './partials/Inputs.libsonnet',
    local outputs = import './partials/Outputs.libsonnet',

    local parameterDefaultValue = import './partials/Parameter_Default_Value.libsonnet',

	local copyActivityName = "Copy Data",

	local successMessage = "Log - Succeed",
	local startMessage = "Log - Start",
	local failMessage = "Log - Failed",


    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
   "parameters": {

      "dataFactoryName": {

         "metadata": "The name of the data factory",

         "type": "String"
      },
      "integrationRuntimeShortName": {

         "metadata": "The short name of the integration runtime this pipeline uses",

         "type": "String"
      },
      "integrationRuntimeName": {

         "metadata": "The name of the integration runtime this pipeline uses",

         "type": "String"
      },
      "sharedKeyVaultUri" : {

         "metadata": "The uri of the shared KeyVault",

         "type": "String"
      }
   },
    "resources": [
		{
			"apiVersion": "2018-06-01",
			"name": "[concat(parameters('dataFactoryName'), '/', 'GPL_%(Source)s_%(SourceFormat)s_%(Target)s_%(TargetFormat)s_', parameters('integrationRuntimeShortName'))]" % {Source: SourceType, Target: TargetType, SourceFormat: SourceFormat, TargetFormat: TargetFormat},
			"properties": {
				"activities": [
					{
						"name": copyActivityName,
						"type": "Copy",
						"dependsOn": [
							{
								"activity": startMessage,
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
							"source": sourceStoreSettings(SourceType, SourceFormat),
							"sink": sinkStoreSettings(TargetType, TargetFormat),
							"enableStaging": false,
							"parallelCopies": {
								"value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
								"type": "Expression"
							}
						},
						"inputs": [inputs(SourceType, SourceFormat)],
						"outputs": [outputs(TargetType, TargetFormat)]
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
				"parameters": {
					"TaskObject": {
						"type": "object",
					}
				},
				"folder": {
					"name" : "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeName'))]",
				},
				"annotations": [],
				"lastPublishTime": "2020-08-05T04:14:00Z"
			},
			"type": "Microsoft.DataFactory/factories/pipelines"
		}
	]
}