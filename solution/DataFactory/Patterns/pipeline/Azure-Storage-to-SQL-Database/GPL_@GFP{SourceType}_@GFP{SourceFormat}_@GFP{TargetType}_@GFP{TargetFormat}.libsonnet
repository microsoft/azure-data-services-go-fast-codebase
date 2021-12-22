local Main_CopyActivity_TypeProperties = import './partials/Main_CopyActivity_TypeProperties.libsonnet';

function(SourceType="AzureBlobFS", SourceFormat="Excel", TargetType="AzureSqlTable",TargetFormat="NA")
{	
   "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
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
		"name": "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_', parameters('integrationRuntimeShortName'))]",	
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
				}
					+Main_CopyActivity_TypeProperties(SourceType, SourceFormat, TargetType, TargetFormat),					
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
							"referenceName": "[concat('GPL_"+TargetType+"_"+TargetFormat+"_Post_Copy_', parameters('integrationRuntimeShortName'))]",
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
				"name": "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeName'))]"
			},
			"annotations": [],
			"lastPublishTime": "2020-07-29T09:43:40Z"
		},
		"type": "Microsoft.DataFactory/factories/pipelines"
	}]
}
