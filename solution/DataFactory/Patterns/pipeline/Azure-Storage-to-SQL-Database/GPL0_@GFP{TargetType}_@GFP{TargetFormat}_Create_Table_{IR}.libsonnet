function(GenerateArm="true", GFPIR="{IRA}", SourceType="AzureBlobFS", SourceFormat="Excel",TargetType="AzureSqlTable",TargetFormat="NA")
	
	local Wrapper = import '../static/partials/wrapper.libsonnet';

	local Create_Table_Lookup_CreateStage_TypeProperties = import './partials/Create_Table_Lookup_CreateStage_TypeProperties.libsonnet';
	local Create_Table_Lookup_CreateTarget_TypeProperties = import './partials/Create_Table_Lookup_CreateTarget_TypeProperties.libsonnet';
	
	local pipeline = 
	{
		"name":	if(GenerateArm=="false") 
				then "GPL_"+TargetType+"_"+TargetFormat+"_Create_Table_"+GFPIR 
				else "[concat(parameters('dataFactoryName'), '/','GPL_"+TargetType+"_"+TargetFormat+"_Create_Table_" + "', parameters('integrationRuntimeShortName'))]",		
		"properties": {
			"activities": [
				{
					"name": "If exist Staging TableName",
					"type": "IfCondition",
					"dependsOn": [],
					"userProperties": [],
					"typeProperties": {
						"expression": {
							"value": "@not(empty(pipeline().parameters.TaskObject.Target.TableName))",
							"type": "Expression"
						},
						"ifTrueActivities": [
							{
								"name": "AF Get SQL Create Statement Staging",
								"type": "AzureFunctionActivity",
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
									"functionName": "GetSQLCreateStatementFromSchema",
									"method": "POST",
									"body": {
										"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"TableSchema\":\"',string(pipeline().parameters.TaskObject.Target.TableSchema), '\",\"TableName\":\"', string(pipeline().parameters.TaskObject.Target.TableName),'\",\"StorageAccountName\":\"', string(pipeline().parameters.TaskObject.Source.StorageAccountName), '\",\"StorageAccountContainer\":\"', string(pipeline().parameters.TaskObject.Source.StorageAccountContainer), '\",\"RelativePath\":\"', string(pipeline().parameters.TaskObject.Source.RelativePath), '\",\"SchemaFileName\":\"', string(pipeline().parameters.TaskObject.Source.SchemaFileName), '\"}'))",
										"type": "Expression"
									}
								},
								"linkedServiceName": {
									"referenceName": "SLS_AzureFunctionApp",
									"type": "LinkedServiceReference"
								}
							},
							{
								"name": "Lookup Create Staging Table",
								"type": "Lookup",
								"dependsOn": [
									{
										"activity": "AF Get SQL Create Statement Staging",
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
								"typeProperties": Create_Table_Lookup_CreateStage_TypeProperties(GenerateArm,GFPIR,TargetType,TargetFormat)
								
							},
							{
								"name": "AF Log - Create Staging Table Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Lookup Create Staging Table",
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
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Create Staging Table\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Lookup Create Staging Table').error.message), '\",\"Status\":\"Failed\"}'))",
											"type": "Expression"
										},
										"FunctionName": "Log",
										"Method": "Post"
									}
								}
							}
						]
					}
				},
				{
					"name": "If exist Target TableName",
					"type": "IfCondition",
					"dependsOn": [],
					"userProperties": [],
					"typeProperties": {
						"expression": {
							"value": "@not(empty(pipeline().parameters.TaskObject.Target.StagingTableName))",
							"type": "Expression"
						},
						"ifTrueActivities": [
							{
								"name": "AF Get SQL Create Statement Target",
								"type": "AzureFunctionActivity",
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
									"functionName": "GetSQLCreateStatementFromSchema",
									"method": "POST",
									"body": {
										"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"TableSchema\":\"',string(pipeline().parameters.TaskObject.Target.StagingTableSchema), '\",\"TableName\":\"', string(pipeline().parameters.TaskObject.Target.StagingTableName),'\",\"StorageAccountName\":\"', string(pipeline().parameters.TaskObject.Source.StorageAccountName), '\",\"StorageAccountContainer\":\"', string(pipeline().parameters.TaskObject.Source.StorageAccountContainer), '\",\"RelativePath\":\"', string(pipeline().parameters.TaskObject.Source.RelativePath), '\",\"SchemaFileName\":\"', string(pipeline().parameters.TaskObject.Source.SchemaFileName), '\",\"DropIfExist\":\"True\"}'))",
										"type": "Expression"
									}
								},
								"linkedServiceName": {
									"referenceName": "SLS_AzureFunctionApp",
									"type": "LinkedServiceReference"
								}
							},
							{
								"name": "Lookup Create Target Table",
								"type": "Lookup",
								"dependsOn": [
									{
										"activity": "AF Get SQL Create Statement Target",
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
								"typeProperties": Create_Table_Lookup_CreateTarget_TypeProperties(GenerateArm,GFPIR,TargetType,TargetFormat)
							},
							{
								"name": "AF Log - Create Target Table Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Lookup Create Target Table",
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
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Create Target Table\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Lookup Create Target Table').error.message), '\",\"Status\":\"Failed\"}'))",
											"type": "Expression"
										},
										"FunctionName": "Log",
										"Method": "Post"
									}
								}
							}
						]
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
			"lastPublishTime": "2020-08-04T13:09:30Z"
		},
		"type": "Microsoft.DataFactory/factories/pipelines"
	};
 

Wrapper(GenerateArm,pipeline)+{}
