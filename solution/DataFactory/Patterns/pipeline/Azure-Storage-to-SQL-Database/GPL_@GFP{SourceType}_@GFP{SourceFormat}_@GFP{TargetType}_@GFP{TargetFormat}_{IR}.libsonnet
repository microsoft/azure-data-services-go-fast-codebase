function(GenerateArm="true",GFPIR="IRA", SourceType="AzureBlobFS", SourceFormat="Parquet", TargetType="AzureSqlTable",TargetFormat="NA")

	local Wrapper = import '../static/partials/wrapper.libsonnet';
	local Main_CopyActivity_TypeProperties = import './partials/Main_CopyActivity_TypeProperties.libsonnet';
	
	local pipeline = 
	{
		"name":if(GenerateArm=="false") 
			   then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_"+GFPIR 
			   else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_" + "', parameters('integrationRuntimeShortName'))]",
		"properties": {
			"activities": [
				{
					"name": "Pipeline AF Log - ADLS to Azure SQL Start",
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
								"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":3,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy to SQL\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"Status\":\"Started\"}'))",
								"type": "Expression"
							},
							"FunctionName": "Log",
							"Method": "Post"
						}
					}
				},
				{
					"name": "If Auto Create Table",
					"description": "Auto Creates Table Using a Schema File",
					"type": "IfCondition",
					"dependsOn": [
						{
							"activity": "Pipeline AF Log - ADLS to Azure SQL Start",
							"dependencyConditions": [
								"Succeeded"
							]
						}],
					"userProperties": [],
					"typeProperties": {
						"expression": {
							"value": "@and(not(equals(coalesce(pipeline().parameters.TaskObject.Source.SchemaFileName,''),'')),bool(pipeline().parameters.TaskObject.Target.AutoCreateTable))",
							"type": "Expression"
						},
						"ifTrueActivities": [
							{
								"name": "Execute Create Table",
								"type": "ExecutePipeline",
								"dependsOn": [],
								"userProperties": [],
								"typeProperties": {
									"pipeline": {
										"referenceName":if(GenerateArm=="false") 
														then "GPL_"+TargetType+"_"+TargetFormat+"_Create_Table_"+GFPIR 
														else "[concat('GPL_"+TargetType+"_"+TargetFormat+"_Create_Table_" + "', parameters('integrationRuntimeShortName'))]",
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
								"name": "AF Get Mapping",
								"type": "AzureFunctionActivity",
								"dependsOn": [
									{
										"activity": "Execute Create Table",
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
									"functionName": "GetSourceTargetMapping",
									"method": "POST",
									"body": {
										"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"StorageAccountName\":\"', string(pipeline().parameters.TaskObject.Source.StorageAccountName), '\",\"StorageAccountContainer\":\"', string(pipeline().parameters.TaskObject.Source.StorageAccountContainer), '\",\"RelativePath\":\"', string(pipeline().parameters.TaskObject.Source.RelativePath), '\",\"SchemaFileName\":\"', string(pipeline().parameters.TaskObject.Source.SchemaFileName), '\",\"SourceType\":\"', string(pipeline().parameters.TaskObject.Source.Type), '\",\"TargetType\":\"', string(pipeline().parameters.TaskObject.Target.Type), '\",\"MetadataType\":\"Parquet\"}'))",
										"type": "Expression"
									}
								},
								"linkedServiceName": {
									"referenceName": "SLS_AzureFunctionApp",
									"type": "LinkedServiceReference"
								}
							}
						]
					}
				},
				{
					"name": "Copy to SQL",
					"type": "Copy",
					"dependsOn": [
						{
							"activity": "If Auto Create Table",
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
					+Main_CopyActivity_TypeProperties(GenerateArm, GFPIR, SourceType, SourceFormat, TargetType, TargetFormat),					
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
							"referenceName": "SPL_AzureFunction",
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
							"referenceName": "SPL_AzureFunction",
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
							"referenceName": 	if(GenerateArm=="false") 
												then "GPL_"+TargetType+"_"+TargetFormat + "_Post_Copy_"+ GFPIR
												else "[concat('GPL_"+TargetType+"_"+TargetFormat + "_Post_Copy_"+"', parameters('integrationRuntimeShortName'))]",
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
				"name": if(GenerateArm=="false") 
						then "ADS Go Fast/Data Movement/" + GFPIR
						else "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeShortName'))]",
			},
			"annotations": [],
			"lastPublishTime": "2020-07-29T09:43:40Z"
		},
		"type": "Microsoft.DataFactory/factories/pipelines"
	};
	
	Wrapper(GenerateArm,pipeline)+{}




