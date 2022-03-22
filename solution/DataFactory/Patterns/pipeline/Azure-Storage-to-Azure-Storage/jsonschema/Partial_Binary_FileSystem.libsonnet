function()
{
    "type": "object",
    "properties": {
        "Type": {
            "type": "string",
            "enum": [
                "Binary"
            ],
            "options": {
                "hidden": true
            }
        },
        "RelativePath": {
            "type": "string",
            "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
            "options": {
                "inputAttributes": {
                    "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                },
                "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"
            }
        },
        "DataFileName": {
            "type": "string",
            "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
            "options": {
                "inputAttributes": {
                    "placeholder": "eg. *.parquet"
                },
                "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type"
            }
        },
        "Recursively": {
            "type": "string",
            "enum": [
                "true",
                "false"
            ],
            "default": "true",
            "options": {
                "infoText": "Set to true if you want the framework to copy files from subfolders."
            }
        },
        "DeleteAfterCompletion": {
            "type": "string",
            "enum": [
                "true",
                "false"
            ],
            "default": "true",
            "options": {
                "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
            }
        },        
        "MaxConcurrentConnections": {
            "type": "integer",
            "default": 100,
            "options": {                        
                "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
            }
        }    
    },
    "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "Recursively",
        "MaxConcurrentConnections",
        "DeleteAfterCompletion"
    ]
}
