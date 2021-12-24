function(GenerateArm=true,GFPIR="{IRA}",SourceType="AzureBlobFS",SourceFormat="DelimitedText", TargetType="AzureBlobFS", TargetFormat="Excel")

local Wrapper = import '../static/partials/wrapper.libsonnet';

local typeProperties = import './partials/typeProperties/typeProperties.libsonnet';
local datasets = {
	"Binary" : import './partials/datasetReferences/Binary.libsonnet',
	"DelimitedText" : import './partials/datasetReferences/DelimitedText.libsonnet',
	"Excel" : import './partials/datasetReferences/Excel.libsonnet',
	"Json" : import './partials/datasetReferences/Json.libsonnet',
	"Parquet" : import './partials/datasetReferences/Parquet.libsonnet'
};

local parameterDefaultValue = import './partials/parameterDefaultValue.libsonnet';

local name =  if(GenerateArm) 
					then "[concat(parameters('dataFactoryName'), '/','GDS_%(SourceType)s_%(SourceFormat)s_', parameters('integrationRuntimeShortName'))]" % {SourceType:SourceType, SourceFormat:SourceFormat, GFPIR:GFPIR}
					else "GDS_%(SourceType)s_%(SourceFormat)s_%(GFPIR)s" % {SourceType:SourceType, SourceFormat:SourceFormat, GFPIR:GFPIR};

local copyActivityName = "Copy %(Source)s to %(Target)s" % {Source: SourceType, Target: TargetType};
local logSuccessActivityName = "%(ActivityName)s Succeed" % {ActivityName: copyActivityName};
local logStartedActivityName = "%(ActivityName)s Started" % {ActivityName: copyActivityName};
local logFailedActivityName = "%(ActivityName)s Failed" % {ActivityName: copyActivityName};

local pipeline = {
	"name": name,
	"properties": {
		"activities": [
            {
                "name": copyActivityName,
                "type": "Copy",
                "dependsOn": [
                    {
                        "activity": logStartedActivityName,
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
                "typeProperties": typeProperties(),
                "inputs": [datasets[SourceFormat](GenerateArm, SourceType, GFPIR)],
                "outputs": [datasets[TargetFormat](GenerateArm, SourceType, GFPIR)],
            },
			{
			"name": logFailedActivityName,
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
			"name": logStartedActivityName,
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
			"name": logSuccessActivityName,
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
		"parameters": parameterDefaultValue(SourceType),
		"folder": {
			"name": "ADS Go Fast/Data Movement/" + GFPIR
		},
		"annotations": [],
		"lastPublishTime": "2020-08-05T04:14:00Z"
	},
	"type": "Microsoft.DataFactory/factories/pipelines"
};
Wrapper(GenerateArm,pipeline)+{}