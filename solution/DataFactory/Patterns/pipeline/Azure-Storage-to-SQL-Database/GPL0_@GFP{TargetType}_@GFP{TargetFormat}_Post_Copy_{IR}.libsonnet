function(GenerateArm=false, GFPIR="{IRA}", SourceType="AzureBlobFS", SourceFormat="Excel",TargetType="AzureSqlTable",TargetFormat="NA")
	
	local Wrapper = import '../static/partials/wrapper.libsonnet';

	local Post_Copy_Lookup_PostCopySQL_TypeProperties = import './partials/Post_Copy_Lookup_PostCopySQL_TypeProperties.libsonnet';
	local Post_Copy_Lookup_MergeSQL_TypeProperties = import './partials/Post_Copy_Lookup_MergeSQL_TypeProperties.libsonnet';
	local Post_Copy_Lookup_AutoMergeSQL_TypeProperties = import './partials/Post_Copy_Lookup_AutoMergeSQL_TypeProperties.libsonnet';
	local Post_Copy_Lookup_CreateStage_TypeProperties = import './partials/Post_Copy_Lookup_CreateStage_TypeProperties.libsonnet';
	local Post_Copy_Lookup_CreateTarget_TypeProperties = import './partials/Post_Copy_Lookup_CreateTarget_TypeProperties.libsonnet';
	local pipeline = 
	{
		"name":if(GenerateArm=="false") 
				then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Post_Copy_"+GFPIR 
				else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Post_Copy_" + "', parameters('integrationRuntimeShortName'))]",
		"properties": {
			"activities": [
				{
					"name": "If Exist PostCopySQL",
					"type": "IfCondition",
					"dependsOn": [],
					"userProperties": [],
					"typeProperties": {
						"expression": {
							"value": "@not(empty(pipeline().parameters.TaskObject.Target.PostCopySQL))",
							"type": "Expression"
						},
						"ifTrueActivities": [
							{
								"name": "Run PostCopySQL",
								"type": "Lookup",
								"dependsOn": [],
								"policy": {
									"timeout": "7.00:00:00",
									"retry": 0,
									"retryIntervalInSeconds": 30,
									"secureOutput": false,
									"secureInput": false
								},
								"userProperties": [],
								"typeProperties": Post_Copy_Lookup_PostCopySQL_TypeProperties(GenerateArm,GFPIR, TargetType, TargetFormat)
							},
							{
								"name": "AF Log - Run PostCopySQL Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Run PostCopySQL",
										"dependencyConditions": [
											"Failed"
										]
									}
								],
								"userProperties": [],
								"typeProperties": {
									"pipeline": {
										"referenceName": "AZ_Function_Generic",
										"type": "PipelineReference"
									},
									"waitOnCompletion": false,
									"parameters": {
										"Body": {
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Run PostCopySQL\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Run PostCopySQL').error.message), '\",\"Status\":\"Failed\"}'))",
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
					"name": "If Exist MergeSQL",
					"type": "IfCondition",
					"dependsOn": [
						{
							"activity": "If Exist PostCopySQL",
							"dependencyConditions": [
								"Succeeded"
							]
						}
					],
					"userProperties": [],
					"typeProperties": {
						"expression": {
							"value": "@not(empty(pipeline().parameters.TaskObject.Target.MergeSQL))",
							"type": "Expression"
						},
						"ifTrueActivities": [
							{
								"name": "Run MergeSQL",
								"type": "Lookup",
								"dependsOn": [],
								"policy": {
									"timeout": "7.00:00:00",
									"retry": 0,
									"retryIntervalInSeconds": 30,
									"secureOutput": false,
									"secureInput": false
								},
								"userProperties": [],
								"typeProperties": Post_Copy_Lookup_MergeSQL_TypeProperties(GenerateArm,GFPIR, TargetType, TargetFormat)
							},
							{
								"name": "AF Log - Run MergeSQL Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Run MergeSQL",
										"dependencyConditions": [
											"Failed"
										]
									}
								],
								"userProperties": [],
								"typeProperties": {
									"pipeline": {
										"referenceName": "AZ_Function_Generic",
										"type": "PipelineReference"
									},
									"waitOnCompletion": false,
									"parameters": {
										"Body": {
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Run MergeSQL\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Run MergeSQL').error.message), '\",\"Status\":\"Failed\"}'))",
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
					"name": "If AutoGenerateMerge",
					"type": "IfCondition",
					"dependsOn": [
						{
							"activity": "If Exist PostCopySQL",
							"dependencyConditions": [
								"Succeeded"
							]
						}
					],
					"userProperties": [],
					"typeProperties": {
						"expression": {
							"value": "@bool(pipeline().parameters.TaskObject.Target.AutoGenerateMerge)",
							"type": "Expression"
						},
						"ifTrueActivities": [
							{
								"name": "Run MergeStatement",
								"type": "Lookup",
								"dependsOn": [
									{
										"activity": "AF Get Merge Statement",
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
								"typeProperties": Post_Copy_Lookup_AutoMergeSQL_TypeProperties(GenerateArm,GFPIR, TargetType, TargetFormat)
							},
							{
								"name": "AF Get Information Schema SQL Stage",
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
									"functionName": "GetInformationSchemaSQL",
									"method": "POST",
									"body": {
										"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"TableSchema\":\"', string(pipeline().parameters.TaskObject.Target.StagingTableSchema), '\",\"TableName\":\"', string(pipeline().parameters.TaskObject.Target.StagingTableName),'\"}'))",
										"type": "Expression"
									}
								},
								"linkedServiceName": {
									"referenceName": "SLS_AzureFunctionApp",
									"type": "LinkedServiceReference"
								}
							},
							{
								"name": "AF Get Merge Statement",
								"type": "AzureFunctionActivity",
								"dependsOn": [
									{
										"activity": "Lookup Get Metadata Stage",
										"dependencyConditions": [
											"Succeeded"
										]
									},
									{
										"activity": "Lookup Get Metadata Target",
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
									"functionName": "GetSQLMergeStatement",
									"method": "POST",
									"body": {
										"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId),'\",\"TargetTableSchema\":\"',string(pipeline().parameters.TaskObject.Target.TableSchema),'\",\"TargetTableName\":\"',string(pipeline().parameters.TaskObject.Target.TableName),'\",\"StagingTableSchema\":\"',string(pipeline().parameters.TaskObject.Target.StagingTableSchema),'\",\"StagingTableName\":\"',string(pipeline().parameters.TaskObject.Target.StagingTableName),'\",\"Stage\":', string(activity('Lookup Get Metadata Stage').output.value), ',\"Target\":', string(activity('Lookup Get Metadata Target').output.value),'}'))",
										"type": "Expression"
									}
								},
								"linkedServiceName": {
									"referenceName": "SLS_AzureFunctionApp",
									"type": "LinkedServiceReference"
								}
							},
							{
								"name": "Lookup Get Metadata Stage",
								"type": "Lookup",
								"dependsOn": [
									{
										"activity": "AF Get Information Schema SQL Stage",
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
								"typeProperties":Post_Copy_Lookup_CreateStage_TypeProperties(GenerateArm,GFPIR, TargetType, TargetFormat)
							},
							{
								"name": "Lookup Get Metadata Target",
								"type": "Lookup",
								"dependsOn": [
									{
										"activity": "AF Get Information Schema SQL Target",
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
								"typeProperties":Post_Copy_Lookup_CreateTarget_TypeProperties(GenerateArm,GFPIR, TargetType, TargetFormat)
							},
							{
								"name": "AF Get Information Schema SQL Target",
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
									"functionName": "GetInformationSchemaSQL",
									"method": "POST",
									"body": {
										"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"TableSchema\":\"', string(pipeline().parameters.TaskObject.Target.TableSchema), '\",\"TableName\":\"', string(pipeline().parameters.TaskObject.Target.TableName),'\"}'))",
										"type": "Expression"
									}
								},
								"linkedServiceName": {
									"referenceName": "SLS_AzureFunctionApp",
									"type": "LinkedServiceReference"
								}
							},
							{
								"name": "AF Log - Run AutoMerge Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Run MergeStatement",
										"dependencyConditions": [
											"Failed"
										]
									}
								],
								"userProperties": [],
								"typeProperties": {
									"pipeline": {
										"referenceName": "AZ_Function_Generic",
										"type": "PipelineReference"
									},
									"waitOnCompletion": false,
									"parameters": {
										"Body": {
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Run AutoMerge\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Run MergeStatement').error.message), '\",\"Status\":\"Failed\"}'))",
											"type": "Expression"
										},
										"FunctionName": "Log",
										"Method": "Post"
									}
								}
							},
							{
								"name": "AF Log - Run Lookup Get Metadata Target Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Lookup Get Metadata Target",
										"dependencyConditions": [
											"Failed"
										]
									}
								],
								"userProperties": [],
								"typeProperties": {
									"pipeline": {
										"referenceName": "AZ_Function_Generic",
										"type": "PipelineReference"
									},
									"waitOnCompletion": false,
									"parameters": {
										"Body": {
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Lookup Get Metadata Target\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Lookup Get Metadata Target').error.message), '\",\"Status\":\"Failed\"}'))",
											"type": "Expression"
										},
										"FunctionName": "Log",
										"Method": "Post"
									}
								}
							},
							{
								"name": "AF Log - Lookup Get Metadata Stage Failed",
								"type": "ExecutePipeline",
								"dependsOn": [
									{
										"activity": "Lookup Get Metadata Stage",
										"dependencyConditions": [
											"Failed"
										]
									}
								],
								"userProperties": [],
								"typeProperties": {
									"pipeline": {
										"referenceName": "AZ_Function_Generic",
										"type": "PipelineReference"
									},
									"waitOnCompletion": false,
									"parameters": {
										"Body": {
											"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Lookup Get Metadata Stage\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Lookup Get Metadata Stage').error.message), '\",\"Status\":\"Failed\"}'))",
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
							then "ADS Go Fast/Data Movement/" + GFPIR + "/Common"
							else "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeShortName'), '/Common')]",
			},
			"annotations": [],
			"lastPublishTime": "2020-08-04T13:09:30Z"
		},
		"type": "Microsoft.DataFactory/factories/pipelines"
	};

Wrapper(GenerateArm,pipeline)+{}
