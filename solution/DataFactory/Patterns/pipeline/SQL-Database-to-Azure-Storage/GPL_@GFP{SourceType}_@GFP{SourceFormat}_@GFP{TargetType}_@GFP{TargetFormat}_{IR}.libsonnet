
function(GenerateArm="false",GFPIR="IRA",SourceType="SqlServerTable",SourceFormat="NA",TargetType="AzureBlobFS",TargetFormat="Parquet")
local infoschemasource = import './partials/Main_Lookup_GetInformationSchema_TypeProperties.libsonnet';
local Watermarksource = import './partials/Main_Lookup_GetNextWaterMarkOrChunk.libsonnet';
local Wrapper = import '../static/partials/wrapper.libsonnet';
local pipeline = {
	
	"name":	if(GenerateArm=="false") 
			then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_"+GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_" + "', parameters('integrationRuntimeShortName'))]",
	"properties": {
		"activities": [
			{
				"name": "AF Get Information Schema SQL",
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
						"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"TableSchema\":\"', string(pipeline().parameters.TaskObject.Source.Extraction.TableSchema), '\",\"TableName\":\"', string(pipeline().parameters.TaskObject.Source.Extraction.TableName),'\"}'))",
						"type": "Expression"
					}
				},
				"linkedServiceName": {
					"referenceName": "SLS_AzureFunctionApp",
					"type": "LinkedServiceReference"
				}
			},
			{
				"name": "Lookup Get SQL Metadata",
				"type": "Lookup",
				"dependsOn": [
					{
						"activity": "AF Get Information Schema SQL",
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
				"typeProperties": infoschemasource(GenerateArm,GFPIR, SourceType, SourceFormat)
			},			
			{
				"name": "AF Log - Get Metadata Failed",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "Lookup Get SQL Metadata",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Get Metadata\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Lookup Get SQL Metadata').error.message), '\",\"Status\":\"Failed\"}'))",
							"type": "Expression"
						},
						"FunctionName": "Log",
						"Method": "Post"
					}
				}
			},						
			{
				"name": "AF Persist Metadata and Get Mapping",
				"type": "AzureFunctionActivity",
				"dependsOn": [
					{
						"activity": "Lookup Get SQL Metadata",
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
					"functionName": "TaskExecutionSchemaFile",
					"method": "POST",
					"body": {
						"value": "@json(\n concat('{\"TaskInstanceId\":\"',\n string(pipeline().parameters.TaskObject.TaskInstanceId), \n '\",\"ExecutionUid\":\"', \n string(pipeline().parameters.TaskObject.ExecutionUid), \n '\",\"RunId\":\"', string(pipeline().RunId), \n '\",\"StorageAccountName\":\"', \n string(pipeline().parameters.TaskObject.Target.StorageAccountName),\n  '\",\"StorageAccountContainer\":\"', \n  string(pipeline().parameters.TaskObject.Target.StorageAccountContainer), \n  '\",\"RelativePath\":\"', \n  string(pipeline().parameters.TaskObject.Target.RelativePath), \n  '\",\"SchemaFileName\":\"', \n  string(pipeline().parameters.TaskObject.Target.SchemaFileName), \n  '\",\"SourceType\":\"', \n  string(pipeline().parameters.TaskObject.Source.Type), \n  '\",\"TargetType\":\"', \n  if(\n    contains(\n    string(pipeline().parameters.TaskObject.Target.StorageAccountName),\n    '.dfs.core.windows.net'\n    ),\n   'ADLS',\n   'Azure Blob'), \n  '\",\"Data\":',\n  string(activity('Lookup Get SQL Metadata').output),\n  ',\"MetadataType\":\"SQL\"}')\n)",
						"type": "Expression"
					}
				},
				"linkedServiceName": {
					"referenceName": "SLS_AzureFunctionApp",
					"type": "LinkedServiceReference"
				}
			},
			{
				"name": "Switch Load Type",
				"type": "Switch",
				"dependsOn": [
					{
						"activity": "AF Persist Metadata and Get Mapping",
						"dependencyConditions": [
							"Succeeded"
						]
					}
				],
				"userProperties": [],
				"typeProperties": {
					"on": {
						"value": "@pipeline().parameters.TaskObject.Source.Extraction.IncrementalType",
						"type": "Expression"
					},
					"cases": [
						{
							"value": "Full",
							"activities": [
								{
									"name": "Execute Full_Load Pipeline",
									"type": "ExecutePipeline",
									"dependsOn": [],
									"userProperties": [],
									"typeProperties": {
										"pipeline": {
											"referenceName": 	if(GenerateArm=="false") 
																then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Full_Load_"+GFPIR 
																else "[concat('GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Full_Load_" + "', parameters('integrationRuntimeShortName'))]",
											"type": "PipelineReference"
										},
										"waitOnCompletion": true,
										"parameters": {
											"TaskObject": {
												"value": "@pipeline().parameters.TaskObject",
												"type": "Expression"
											},
											"Mapping": {
												"value": "@activity('AF Persist Metadata and Get Mapping').output.value",
												"type": "Expression"
											},
											"BatchCount": "1",
											"Item": "1"
										}
									}
								}
							]
						},
						{
							"value": "Watermark",
							"activities": [
								{
									"name": "Execute Watermark Pipeline",
									"type": "ExecutePipeline",
									"dependsOn": [
										{
											"activity": "Lookup New Watermark",
											"dependencyConditions": [
												"Succeeded"
											]
										}
									],
									"userProperties": [],
									"typeProperties": {
										"pipeline": {										
											"referenceName": if(GenerateArm=="false") 
																then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_"+GFPIR 
																else "[concat('GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_" + "', parameters('integrationRuntimeShortName'))]",
											"type": "PipelineReference"
										},
										"waitOnCompletion": true,
										"parameters": {
											"TaskObject": {
												"value": "@pipeline().parameters.TaskObject",
												"type": "Expression"
											},
											"Mapping": {
												"value": "@activity('AF Persist Metadata and Get Mapping').output.value",
												"type": "Expression"
											},
											"NewWaterMark": {
												"value": "@activity('Lookup New Watermark').output.firstRow.newWatermark",
												"type": "Expression"
											},
											"Item": "1",
											"BatchCount": "1"
										}
									}
								},
								{
									"name": "Lookup New Watermark",
									"type": "Lookup",
									"dependsOn": [],
									"policy": {
										"timeout": "0.00:30:00",
										"retry": 0,
										"retryIntervalInSeconds": 30,
										"secureOutput": false,
										"secureInput": false
									},
									"userProperties": [],
									"typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, SourceFormat)
								}
							]
						},
						{
							"value": "Full_Chunk",
							"activities": [
								{
									"name": "Execute Full Load Chunk Pipeline",
									"type": "ExecutePipeline",
									"dependsOn": [
										{
											"activity": "Lookup Chunk",
											"dependencyConditions": [
												"Succeeded"
											]
										}
									],
									"userProperties": [],
									"typeProperties": {
										"pipeline": {											
											"referenceName": if(GenerateArm=="false") 
																then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_"+GFPIR 
																else "[concat('GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Full_Load_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
											"type": "PipelineReference"
										},
										"waitOnCompletion": true,
										"parameters": {
											"TaskObject": {
												"value": "@pipeline().parameters.TaskObject",
												"type": "Expression"
											},
											"Mapping": {
												"value": "@activity('AF Persist Metadata and Get Mapping').output.value",
												"type": "Expression"
											},
											"BatchCount": {
												"value": "@activity('Lookup Chunk').output.firstRow.batchcount",
												"type": "Expression"
											}
										}
									}
								},
								{
									"name": "Lookup Chunk",
									"type": "Lookup",
									"dependsOn": [],
									"policy": {
										"timeout": "0.00:30:00",
										"retry": 0,
										"retryIntervalInSeconds": 30,
										"secureOutput": false,
										"secureInput": false
									},
									"userProperties": [],
									"typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, SourceFormat)
								}
							]
						},
						{
							"value": "Watermark_Chunk",
							"activities": [
								{
									"name": "Execute Watermark Chunk Pipeline",
									"type": "ExecutePipeline",
									"dependsOn": [
										{
											"activity": "Lookup New Watermark and Chunk",
											"dependencyConditions": [
												"Succeeded"
											]
										}
									],
									"userProperties": [],
									"typeProperties": {
										"pipeline": {											
											"referenceName": if(GenerateArm=="false") 
																then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
																else "[concat('GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",
											"type": "PipelineReference"
										},
										"waitOnCompletion": true,
										"parameters": {
											"TaskObject": {
												"value": "@pipeline().parameters.TaskObject",
												"type": "Expression"
											},
											"Mapping": {
												"value": "@activity('AF Persist Metadata and Get Mapping').output.value",
												"type": "Expression"
											},
											"NewWatermark": {
												"value": "@activity('Lookup New Watermark and Chunk').output.firstRow.newWatermark",
												"type": "Expression"
											},
											"BatchCount": {
												"value": "@activity('Lookup New Watermark and Chunk').output.firstRow.batchcount",
												"type": "Expression"
											}
										}
									}
								},
								{
									"name": "Lookup New Watermark and Chunk",
									"type": "Lookup",
									"dependsOn": [],
									"policy": {
										"timeout": "0.00:30:00",
										"retry": 0,
										"retryIntervalInSeconds": 30,
										"secureOutput": false,
										"secureInput": false
									},
									"userProperties": [],
									"typeProperties": Watermarksource(GenerateArm,GFPIR,  SourceType, SourceFormat)
								}
							]
						}
					]
				}
			}
		],
		"parameters": {
			"TaskObject": {
				"type": "object",
				"defaultValue": {
					"TaskInstanceId": 75,
					"TaskMasterId": 12,
					"TaskStatus": "Untried",
					"TaskType": "SQL Database to Azure Storage",
					"Enabled": 1,
					"ExecutionUid": "2c5924ee-b855-4d2b-bb7e-4f5dde4c4dd3",
					"NumberOfRetries": 111,
					"DegreeOfCopyParallelism": 1,
					"KeyVaultBaseUrl": "https://adsgofastkeyvault.vault.azure.net/",
					"ScheduleMasterId": 2,
					"TaskGroupConcurrency": 10,
					"TaskGroupPriority": 0,
					"Source": {
						"Type": "Azure SQL",
						"Database": {
							"SystemName": "adsgofastdatakakeaccelsqlsvr.database.windows.net",
							"Name": "AWSample",
							"AuthenticationType": "MSI"
						},
						"Extraction": {
							"Type": "Table",
							"FullOrIncremental": "Full",
							"IncrementalType": null,
							"TableSchema": "SalesLT",
							"TableName": "SalesOrderHeader"
						}
					},
					"Target": {
						"Type": "Azure Blob",
						"StorageAccountName": "https://adsgofastdatalakeaccelst.blob.core.windows.net",
						"StorageAccountContainer": "datalakeraw",
						"StorageAccountAccessMethod": "MSI",
						"RelativePath": "/AwSample/SalesLT/SalesOrderHeader/2020/7/9/14/12/",
						"DataFileName": "SalesLT.SalesOrderHeader.parquet",
						"SchemaFileName": "SalesLT.SalesOrderHeader",
						"FirstRowAsHeader": null,
						"SheetName": null,
						"SkipLineCount": null,
						"MaxConcorrentConnections": null
					},
					"DataFactory": {
						"Id": 1,
						"Name": "adsgofastdatakakeacceladf",
						"ResourceGroup": "AdsGoFastDataLakeAccel",
						"SubscriptionId": "035a1364-f00d-48e2-b582-4fe125905ee3",
						"ADFPipeline": "AZ_SQL_AZ_Storage_Parquet_" +GFPIR
					}
				}
			}
		},
		"variables": {
			"SQLStatement": {
				"type": "String"
			}
		},
		"folder": {
			"name": if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/" + GFPIR
					else "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeShortName'))]",
		},
		"annotations": [],
		"lastPublishTime": "2020-08-04T12:40:45Z"
	},
	"type": "Microsoft.DataFactory/factories/pipelines"
};
	
Wrapper(GenerateArm,pipeline)+{}