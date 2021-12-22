function(GFPIR="{IRA}",SourceType="AzureSqlTable",SourceFormat="NA",TargetType="AzureBlobFS",TargetFormat="Parquet")
{
	local infoschemasource = import './partials/Main_Lookup_GetInformationSchema_TypeProperties.libsonnet',
	local Watermarksource = import './partials/Main_Lookup_GetNextWaterMarkOrChunk.libsonnet',
	"properties": {
		"activities": [
			{
				"name": "Pipeline AF Log - ADLS to Azure SQL Start",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":3,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy to SQL\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"Status\":\"Started\"}'))",
							"type": "Expression"
						},
						"FunctionName": "Log",
						"Method": "Post"
					}
				}
			},
			{
				"name": "Copy to SQL",
				"type": "Copy",
				"dependsOn": [
					{
						"activity": "Pipeline AF Log - ADLS to Azure SQL Start",
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
				"typeProperties": {/*@GFP{typeProperties}*/},
				"inputs": {/*@GFP{inputs}*/},									
				"outputs": {/*@GFP{outputs}*/}
			},
			{
				"name": "Pipeline AF Log - ADLS to Azure SQL Failed",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "Copy to SQL",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy to SQL\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Copy to SQL').error.message), '\",\"Status\":\"Failed\"}'))",
							"type": "Expression"
						},
						"FunctionName": "Log",
						"Method": "Post"
					}
				}
			},			
			{
				"name": "Pipeline AF Log - ADLS to Azure SQL Succeed",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "Copy to SQL",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy to SQL\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"RowsInserted\":\"', string(activity('Copy to SQL').output.rowsCopied), '\",\"Comment\":\"\",\"Status\":\"Complete\"}'))",
							"type": "Expression"
						},
						"FunctionName": "Log",
						"Method": "Post"
					}
				}
			},
			{
				"name": "Execute AZ_SQL_Post-Copy",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "Pipeline AF Log - ADLS to Azure SQL Succeed",
						"dependencyConditions": [
							"Succeeded"
						]
					}
				],
				"userProperties": [],
				"typeProperties": {
					"pipeline": {
						"referenceName": "GPL_@GFP{TargetType}_@GFP{TargetFormat}_Post_Copy_@GF{IR}",
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
			}
		],
		"parameters": {
			"TaskObject": {
				"type": "object"
			}
		},
		"folder": {
			"name": "ADS Go Fast/Data Movement/@GF{IR}"
		},
		"annotations": [],
		"lastPublishTime": "2020-07-29T09:43:40Z"
	},
	"type": "Microsoft.DataFactory/factories/pipelines"
}
