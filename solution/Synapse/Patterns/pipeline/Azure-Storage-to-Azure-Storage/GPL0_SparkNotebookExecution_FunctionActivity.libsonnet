function(GenerateArm="false", SparkPoolName = "", GFPIR = "")

local generateArmAsBool = GenerateArm == "true";
local Wrapper = import '../static/partials/wrapper.libsonnet';

local typeProperties = import './partials/typeProperties/typeProperties.libsonnet';

local parameterDefaultValue = import './partials/parameterDefaultValue.libsonnet';

local name =  "GPL_SparkNotebookExecution_FunctionActivity_" + GFPIR;

local ActivityName = "CallSynapseNotebook";

local Folder =  if(GenerateArm=="false") 
					then "ADS Go Fast/Data Movement/ExecuteNotebook/" + GFPIR +"/"
					else "[concat('ADS Go Fast/ExecuteNotebook/', parameters('integrationRuntimeShortName'), '/')]";

local pipeline = 
{
    "name": name,
    "properties": {
        "activities": [
            {
                "name": "IsPurviewEnabled",
                "type": "IfCondition",
                "dependsOn": [
                    {
                        "activity": "Poll For Statement Execution",
                        "dependencyConditions": [
                            "Succeeded"
                        ]
                    }
                ],
                "userProperties": [],
                "typeProperties": {
                    "expression": {
                        "value": "@not(or(equals(string(json(string(pipeline().parameters.TaskObject)).ExecutionEngine.JsonProperties.PurviewAccountName), ''), equals(string(json(string(pipeline().parameters.TaskObject)).TMOptionals.Purview), 'Disabled')))\n",
                        "type": "Expression"
                    },
                    "ifTrueActivities": [
                        {
                            "name": "PrepareMetaData",
                            "type": "SynapseNotebook",
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
                                "notebook": {
                                    "referenceName": "PrepareMetaData",
                                    "type": "NotebookReference"
                                },
                                "parameters": {
                                    "TaskObject": {
                                        "value": {
                                            "value": "@string(pipeline().parameters.TaskObject)",
                                            "type": "Expression"
                                        },
                                        "type": "string"
                                    }
                                },
                                "snapshot": true,
                                "sparkPool": {
                                    "referenceName": SparkPoolName,
                                    "type": "BigDataPoolReference"
                                }
                            }
                        },
                        {
                            "name": "Set Purview Metadata",
                            "type": "SetVariable",
                            "dependsOn": [
                                {
                                    "activity": "PrepareMetaData",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "variableName": "OutputMetaData",
                                "value": {
                                    "value": "@activity('PrepareMetaData').output.status.Output.result.exitValue",
                                    "type": "Expression"
                                }
                            }
                        },
                        {
                            "name": "PassMetaDataToPurview",
                            "type": "AzureFunctionActivity",
                            "dependsOn": [
                                {
                                    "activity": "Set Purview Metadata",
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
                                "functionName": "PurviewGetMetaData",
                                "method": "POST",
                                "body": {
                                    "value": "@json(variables('OutputMetaData'))",
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
                "name": "Poll For Statement Execution",
                "type": "Until",
                "dependsOn": [
                    {
                        "activity": "Poll For Session Allocation",
                        "dependencyConditions": [
                            "Succeeded"
                        ]
                    }
                ],
                "userProperties": [],
                "typeProperties": {
                    "expression": {
                        "value": "@equals(\n    variables('NotebookExecutionComplete'),\n    bool('true')\n)",
                        "type": "Expression"
                    },
                    "activities": [
                        {
                            "name": "Mark Notebook Execution Complete After Polling",
                            "type": "SetVariable",
                            "dependsOn": [
                                {
                                    "activity": "Check Statement State",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "variableName": "NotebookExecutionComplete",
                                "value": {
                                    "value": "@if(\n    equals(\n            activity('Check Statement State').output.Result,\n            'available'\n        ),\n        bool('true'),\n        bool('false')\n    )",
                                    "type": "Expression"
                                }
                            }
                        },
                        {
                            "name": "Check Statement State",
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
                                "functionName": "CheckSynapseStatementExecution",
                                "method": "POST",
                                "body": {
                                    "value": "@activity('Execute Notebook Using Function2').output",
                                    "type": "Expression"
                                }
                            },
                            "linkedServiceName": {
                                "referenceName": "SLS_AzureFunctionApp",
                                "type": "LinkedServiceReference"
                            }
                        },
                        {
                            "name": "Wait1",
                            "type": "Wait",
                            "dependsOn": [
                                {
                                    "activity": "Mark Notebook Execution Complete After Polling",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "waitTimeInSeconds": {
                                    "value": "@if(\n    equals(\n            activity('Check Statement State').output.Result,\n            'available'\n        ),\n        1,\n        10\n    )",
                                    "type": "Expression"
                                }
                            }
                        },
                        {
                            "name": "Fail1",
                            "type": "Fail",
                            "dependsOn": [
                                {
                                    "activity": "Mark Notebook Execution Complete After Polling_copy1",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "message": "Checking Statement State failed",
                                "errorCode": "0"
                            }
                        },
                        {
                            "name": "Mark Notebook Execution Complete After Polling_copy1",
                            "type": "SetVariable",
                            "dependsOn": [
                                {
                                    "activity": "Check Statement State",
                                    "dependencyConditions": [
                                        "Failed"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "variableName": "NotebookExecutionComplete",
                                "value": {
                                    "value": "@bool('true')",
                                    "type": "Expression"
                                }
                            }
                        }
                    ],
                    "timeout": "7.00:00:00"
                }
            },
            {
                "name": "Poll For Session Allocation",
                "type": "Until",
                "dependsOn": [],
                "userProperties": [],
                "typeProperties": {
                    "expression": {
                        "value": "@equals(\n    variables('SessionAllocationComplete'),\n    bool('true')\n)",
                        "type": "Expression"
                    },
                    "activities": [
                        {
                            "name": "Mark Session Allocation Complete After Polling",
                            "type": "SetVariable",
                            "dependsOn": [
                                {
                                    "activity": "Execute Notebook Using Function2",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "variableName": "SessionAllocationComplete",
                                "value": {
                                    "value": "@if(\n    equals(\n        activity('Execute Notebook Using Function2').output.StatementResult,\n        2),\n    bool('true'),\n    bool('false')\n    )",
                                    "type": "Expression"
                                }
                            }
                        },
                        {
                            "name": "Execute Notebook Using Function2",
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
                                "functionName": "ExecuteSynapseNotebook",
                                "method": "POST",
                                "body": {
                                    "value": "@pipeline().parameters.TaskObject",
                                    "type": "Expression"
                                }
                            },
                            "linkedServiceName": {
                                "referenceName": "SLS_AzureFunctionApp",
                                "type": "LinkedServiceReference"
                            }
                        },
                        {
                            "name": "Wait1_copy1",
                            "type": "Wait",
                            "dependsOn": [
                                {
                                    "activity": "Mark Session Allocation Complete After Polling",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "waitTimeInSeconds": 10
                            }
                        },
                        {
                            "name": "Fail1_copy1",
                            "type": "Fail",
                            "dependsOn": [
                                {
                                    "activity": "Mark Session Allocation Failed After Polling",
                                    "dependencyConditions": [
                                        "Succeeded"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "message": "Session Allocation Usines Function Failed",
                                "errorCode": "0"
                            }
                        },
                        {
                            "name": "Mark Session Allocation Failed After Polling",
                            "type": "SetVariable",
                            "dependsOn": [
                                {
                                    "activity": "Execute Notebook Using Function2",
                                    "dependencyConditions": [
                                        "Failed"
                                    ]
                                }
                            ],
                            "userProperties": [],
                            "typeProperties": {
                                "variableName": "SessionAllocationComplete",
                                "value": {
                                    "value": "@bool('true')",
                                    "type": "Expression"
                                }
                            }
                        }
                    ],
                    "timeout": "7.00:00:00"
                }
            }
        ],
        "parameters": {
            "TaskObject": {
                "type": "object"
            }
        },
        "variables": {
            "OutputMetaData": {
                "type": "String"
            },
            "NotebookExecutionComplete": {
                "type": "Boolean",
                "defaultValue": false
            },
            "SessionAllocationComplete": {
                "type": "Boolean",
                "defaultValue": false
            }
        },
        "folder": {
            "name": Folder
        },
        "annotations": [],
        "lastPublishTime": "2022-04-06T03:50:37Z"
    },
    "type": "Microsoft.Synapse/workspaces/pipelines"
};
Wrapper(GenerateArm,pipeline)+{}