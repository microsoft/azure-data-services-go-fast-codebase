function(GenerateArm="false",GFPIR="IRA",SourceType="AzureSqlTable",SourceFormat="NA",TargetType="AzureBlobFS",TargetFormat="Parquet")
local CopyActivity_TypeProperties = import './partials/Full_Load_CopyActivity_TypeProperties.libsonnet';
local Full_Load_GetTargetMetadata = import './partials/Full_Load_GetTargetMetadata.libsonnet';
local Wrapper = import '../static/partials/wrapper.libsonnet';
local pipeline =  {

		
	"name":	if(GenerateArm=="false") 
			then "GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_"+GFPIR 
			else "[concat(parameters('dataFactoryName'), '/','GPL_"+SourceType+"_"+SourceFormat+"_"+TargetType+"_"+TargetFormat+"_Watermark_" + "', parameters('integrationRuntimeShortName'))]",
	"properties": {
		"activities": [
			{
				"name": "Set SQLStatement",
				"type": "SetVariable",
				"dependsOn": [],
				"userProperties": [],
				"typeProperties": {
					"variableName": "SQLStatement",
					"value": {
						"value": "@replace(replace(replace(pipeline().parameters.TaskObject.Source.Extraction.SQLStatement,'<batchcount>',string(pipeline().parameters.BatchCount)),'<item>',string(pipeline().parameters.Item)),'<newWatermark>',pipeline().parameters.NewWaterMark)",
						"type": "Expression"
					}
				}
			},
			{
				"name": "Copy SQL to Storage",
				"type": "Copy",
				"dependsOn": [
					{
						"activity": "Pipeline AF Log - Copy Start",
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
				"userProperties": []
			}
				+CopyActivity_TypeProperties(GenerateArm,GFPIR,SourceType, SourceFormat, TargetType, TargetFormat),											
			{
				"name": "Pipeline AF Log - Copy Failed",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "Copy SQL to Storage",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy SQL to Storage\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"Comment\":\"', string(activity('Copy SQL to Storage').error.message), '\",\"Status\":\"Failed\"}'))",
							"type": "Expression"
						},
						"FunctionName": "Log",
						"Method": "Post"
					}
				}
			},
			{
				"name": "AF Persist Parquet Metadata",
				"type": "AzureFunctionActivity",
				"dependsOn": [
					{
						"activity": "Get Parquet Metadata",
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
						"value": "@json(\n concat(\n '{\"TaskInstanceId\":\"', \n string(pipeline().parameters.TaskObject.TaskInstanceId), \n '\",\"ExecutionUid\":\"', \n string(pipeline().parameters.TaskObject.ExecutionUid), \n '\",\"RunId\":\"', \n string(pipeline().RunId), \n '\",\"StorageAccountName\":\"', \n string(pipeline().parameters.TaskObject.Target.StorageAccountName), \n '\",\"StorageAccountContainer\":\"', \n string(pipeline().parameters.TaskObject.Target.StorageAccountContainer), \n '\",\"RelativePath\":\"', \n string(pipeline().parameters.TaskObject.Target.RelativePath), \n '\",\"SchemaFileName\":\"', \n string(pipeline().parameters.TaskObject.Target.SchemaFileName), \n '\",\"SourceType\":\"', \n string(pipeline().parameters.TaskObject.Source.Type), \n '\",\"TargetType\":\"', \n if(\n    contains(\n    string(pipeline().parameters.TaskObject.Target.StorageAccountName),\n    '.dfs.core.windows.net'\n    ),\n   'ADLS',\n   'Azure Blob'), \n '\",\"Data\":',\n string(activity('Get Parquet Metadata').output),\n ',\"MetadataType\":\"Parquet\"}')\n)",
						"type": "Expression"
					}
				},
				"linkedServiceName": {
					"referenceName": "SLS_AzureFunctionApp",
					"type": "LinkedServiceReference"
				}
			},
			{
				"name": "Get Parquet Metadata",
				"type": "GetMetadata",
				"dependsOn": [
					{
						"activity": "Copy SQL to Storage",
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
				"typeProperties": Full_Load_GetTargetMetadata(GenerateArm,GFPIR,TargetType, TargetFormat)
			},
			{
				"name": "Pipeline AF Log - Copy Start",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":3,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy SQL to Storage\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"Status\":\"Started\"}'))",
							"type": "Expression"
						},
						"FunctionName": "Log",
						"Method": "Post"
					}
				}
			},
			{
				"name": "Pipeline AF Log - Copy Succeed",
				"type": "ExecutePipeline",
				"dependsOn": [
					{
						"activity": "Copy SQL to Storage",
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
							"value": "@json(concat('{\"TaskInstanceId\":\"', string(pipeline().parameters.TaskObject.TaskInstanceId), '\",\"ExecutionUid\":\"', string(pipeline().parameters.TaskObject.ExecutionUid), '\",\"RunId\":\"', string(pipeline().RunId), '\",\"LogTypeId\":1,\"LogSource\":\"ADF\",\"ActivityType\":\"Copy SQL to Storage\",\"StartDateTimeOffSet\":\"', string(pipeline().TriggerTime), '\",\"EndDateTimeOffSet\":\"', string(utcnow()), '\",\"RowsInserted\":\"', string(activity('Copy SQL to Storage').output.rowsCopied), '\",\"Comment\":\"\",\"Status\":\"Complete\"}'))",
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
			"NewWaterMark": {
				"type": "string"
			},
			"Item": {
				"type": "int"
			},
			"BatchCount": {
				"type": "int"
			}
		},
		"variables": {
			"SQLStatement": {
				"type": "String"
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
