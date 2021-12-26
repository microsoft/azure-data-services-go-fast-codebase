function(GenerateArm="false",GFPIR="IRA",SourceType="AzureSqlTable",SourceFormat="NA",TargetType="AzureBlobFS",TargetFormat="Parquet")
local Wrapper = import '../static/partials/wrapper.libsonnet';
local pipeline = {
	"name":	if(GenerateArm=="false") 
		then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_"+GFPIR 
		else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_Chunk_" + "', parameters('integrationRuntimeShortName'))]",		
	"properties": {
		"activities": [
			{
				"name": "AF Set New Watermark",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "ForEach Chunk",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"TaskMasterId\":\"', string(pipeline().parameters.TaskObject.TaskMasterId),'\",\"TaskMasterWaterMarkColumnType\":\"', string(pipeline().parameters.TaskObject.Source.Extraction.IncrementalColumnType),'\",\"WaterMarkValue\":\"', string(pipeline().parameters.NewWatermark), '\"}'))",
							"type": "Expression"
						},
						"FunctionName": "WaterMark",
						"Method": "Post"
					}
				}
			},
			{
				"name": "ForEach Chunk",
				"type": "ForEach",
				"dependsOn": [],
				"userProperties": [],
				"typeProperties": {
					"items": {
						"value": "@range(1, pipeline().parameters.BatchCount)",
						"type": "Expression"
					},
					"isSequential": true,
					"activities": [
						{
							"name": "Execute Watermark",
							"type": "ExecutePipeline",
							"dependsOn": [],
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
										"value": "@pipeline().parameters.Mapping",
										"type": "Expression"
									},
									"NewWaterMark": {
										"value": "@pipeline().parameters.NewWatermark",
										"type": "Expression"
									},
									"Item": {
										"value": "@item()",
										"type": "Expression"
									},
									"BatchCount": {
										"value": "@pipeline().parameters.BatchCount",
										"type": "Expression"
									}
								}
							}
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
						"ADFPipeline": "AZ_SQL_AZ_Storage_Parquet_" + GFPIR
					}
				}
			},
			"Mapping": {
				"type": "object"
			},
			"NewWatermark": {
				"type": "string"
			},
			"BatchCount": {
				"type": "int"
			}
		},
		"folder": {
			"name": if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/" + GFPIR + "/Components"
					else "[concat('ADS Go Fast/Data Movement/', parameters('integrationRuntimeShortName'), '/Components')]",
		},
		"annotations": []
	},
	"type": "Microsoft.DataFactory/factories/pipelines"
};
	
Wrapper(GenerateArm,pipeline)+{}
