{
    "name": "GPL_AzureBlobFS_Parquet_AzureBlobFS_Parquet_Azure",
    "properties": {
        "activities": [
            {
                "name": "GDF_AzureBlobFS_Parquet_AzureBlobFS_Delta",
                "type": "ExecuteDataFlow",
                "dependsOn": [],
                "policy": {
                    "timeout": "1.00:00:00",
                    "retry": 0,
                    "retryIntervalInSeconds": 30,
                    "secureOutput": false,
                    "secureInput": false
                },
                "userProperties": [],
                "typeProperties": {
                    "dataflow": {
                        "referenceName": "GDF_AzureBlobFS_Parquet_AzureBlobFS_Parquet_Azure",
                        "type": "DataFlowReference",
                        "parameters": {
                            "TargetContainer": {
                                "value": "'@{pipeline().parameters.TaskObject.Target.System.Container}'",
                                "type": "Expression"
                            },
                            "TargetFolderPath": {
                                "value": "'@{pipeline().parameters.TaskObject.Target.Instance.TargetRelativePath}'",
                                "type": "Expression"
                            }
                        },
                        "datasetParameters": {
                            "source1": {
                                "FileName": {
                                    "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
                                    "type": "Expression"
                                },
                                "RelativePath": {
                                    "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
                                    "type": "Expression"
                                },
                                "StorageAccountContainerName": {
                                    "value": "@pipeline().parameters.TaskObject.Source.System.Container",
                                    "type": "Expression"
                                },
                                "StorageAccountEndpoint": {
                                    "value": "@pipeline().parameters.TaskObject.Source.System.SystemServer",
                                    "type": "Expression"
                                }
                            }
                        },
                        "linkedServiceParameters": {
                            "sink1": {
                                "linkedService": {
                                    "StorageAccountEndpoint": {
                                        "value": "@pipeline().parameters.TaskObject.Target.System.SystemServer",
                                        "type": "Expression"
                                    }
                                }
                            }
                        }
                    },
                    "compute": {
                        "coreCount": 8,
                        "computeType": "General"
                    },
                    "traceLevel": "Fine"
                }
            }
        ],
        "parameters": {
            "TaskObject": {
                "type": "object",
                "defaultValue": {
                    "TaskObject": {
                        "TaskInstanceId": 1,
                        "TaskMasterId": 6,
                        "TaskStatus": "Untried",
                        "TaskType": "Azure Storage to SQL Database",
                        "Enabled": 1,
                        "ExecutionUid": "725c1093-80a0-446d-9512-381f8939e451",
                        "NumberOfRetries": 3,
                        "DegreeOfCopyParallelism": 1,
                        "KeyVaultBaseUrl": "https://adsgfkvjkcgkaibkungm.vault.azure.net",
                        "ScheduleMasterId": "2",
                        "TaskGroupConcurrency": "10",
                        "TaskGroupPriority": 0,
                        "TaskExecutionType": "ADF",
                        "DataFactory": {
                            "Id": 1,
                            "Name": "adsgfadfjkcgkaibkungm",
                            "ResourceGroup": "AdsTestDemo",
                            "SubscriptionId": "035a1364-f00d-48e2-b582-4fe125905ee3",
                            "ADFPipeline": "GPL_AzureBlobFS_DelimitedText_AzureSqlTable_NA_IRA",
                            "TaskDatafactoryIR": "IRA"
                        },
                        "Source": {
                            "System": {
                                "SystemId": 1,
                                "SystemServer": "https://adsdevdlsadsbn6dadsl.dfs.core.windows.net",
                                "AuthenticationType": "MSI",
                                "Type": "ADLS",
                                "Username": "",
                                "Container": "datalakeraw"
                            },
                            "Instance": {
                                "SourceRelativePath": "samples/"
                            },
                            "DataFileName": "SalesLT.Customer.chunk_1.parquet",
                            "DeleteAfterCompletion": "false",
                            "FirstRowAsHeader": "true",
                            "MaxConcorrentConnections": 0,
                            "Recursively": "false",
                            "RelativePath": "samples/",
                            "SchemaFileName": "",
                            "SheetName": "",
                            "SkipLineCount": 0,
                            "Type": "Csv"
                        },
                        "Target": {
                            "System": {
                                "SystemId": 1,
                                "SystemServer": "https://adsdevdlsadsbn6dadsl.dfs.core.windows.net",
                                "AuthenticationType": "MSI",
                                "Type": "ADLS",
                                "Username": "",
                                "Container": "datalakeraw"
                            },
                            "Instance": {
                                "TargetRelativePath": "tests/-99/DeltaTest/"
                            },
                            "AutoCreateTable": "true",
                            "AutoGenerateMerge": "false",
                            "DataFileName": "",
                            "MergeSQL": "",
                            "PostCopySQL": "",
                            "PreCopySQL": "",
                            "SchemaFileName": "",
                            "StagingTableName": "stg_yellow_tripdata6",
                            "StagingTableSchema": "dbo",
                            "TableName": "yellow_tripdata6",
                            "TableSchema": "dbo",
                            "Type": "Table"
                        }
                    }
                }
            }
        },
        "annotations": []
    }
}