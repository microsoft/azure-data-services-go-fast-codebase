import random
import json
from pyspark.sql import Row
from pyspark.sql.types import *
from pyspark.sql.functions import *
session_id = random.randint(0,1000000)

TaskObject = '''    {
        "TaskInstanceId": 20,
        "TaskMasterId": -2,
        "TaskStatus": "InProgress",
        "TaskType": "Azure Storage to SQL Database",
        "Enabled": 1,
        "ExecutionUid": "b829721c-f297-49eb-8436-c33e27005971",
        "NumberOfRetries": 0,
        "DegreeOfCopyParallelism": 1,
        "KeyVaultBaseUrl": "https://mst-stg-kv-ads-pnu0.vault.azure.net/",
        "ScheduleMasterId": "4",
        "TaskGroupConcurrency": "10",
        "TaskGroupPriority": 0,
        "TaskExecutionType": "ADF",
        "DataFactory": {
            "Id": 1,
            "Name": "mst-stg-adf-ads-pnu0",
            "ResourceGroup": "adsgftera2",
            "SubscriptionId": "035a1364-f00d-48e2-b582-4fe125905ee3",
            "ADFPipeline": "GPL_AzureBlobFS_Parquet_AzureSqlTable_NA_Azure",
            "TaskDatafactoryIR": "Azure"
        },
        "Source": {
            "System": {
                "SystemId": 4,
                "SystemServer": "https://mststgdlsadspnu0adsl.dfs.core.windows.net",
                "AuthenticationType": "MSI",
                "Type": "ADLS",
                "Username": null,
                "Container": "datalakeraw"
            },
            "Instance": {
                "SourceRelativePath": "samples/"
            },
            "DataFileName": "SalesLT.Customer.chunk_1.parquet",
            "DeleteAfterCompletion": "false",
            "MaxConcurrentConnections": 0,
            "Recursively": "false",
            "RelativePath": "samples/",
            "Type": "Parquet"
        },
        "Target": {
            "System": {
                "SystemId": 4,
                "SystemServer": "https://mststgdlsadspnu0adsl.dfs.core.windows.net",
                "AuthenticationType": "MSI",
                "Type": "ADLS",
                "Username": null,
                "Container": "datalakeraw"
            },
            "Instance": {
                "SourceRelativePath": "samples/"
            },
            "DataFileName": "SalesLT-Customer-Delta",
            "DeleteAfterCompletion": "false",
            "MaxConcurrentConnections": 0,
            "Recursively": "false",
            "RelativePath": "deltalake/samples/",
            "Type": "Delta"
        }
    }'''

print(TaskObject)