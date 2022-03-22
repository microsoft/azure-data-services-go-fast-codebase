function(GFPIR="IRA")
{
    "name": "GDS_AzureBlobFS_Binary_" + GFPIR,
    "properties": {
        "linkedServiceName": {
            "referenceName": "GLS_AzureBlobFS_" + GFPIR,
            "type": "LinkedServiceReference",
            "parameters": {
                "StorageAccountEndpoint": {
                    "value": "@dataset().StorageAccountEndpoint",
                    "type": "Expression"
                }
            }
        },
        "parameters": {
            "StorageAccountEndpoint": {
                "type": "string"
            },
            "FileSystem": {
                "type": "string"
            },
            "Directory": {
                "type": "string"
            },
            "File": {
                "type": "string"
            }
        },
        "folder": {
            "name": "ADS Go Fast/Generic/" + GFPIR
        },
        "annotations": [],
        "type": "Binary",
        "typeProperties": {
            "location": {
                "type": "AzureBlobStorageLocation",
                "fileName": {
                    "value": "@dataset().File",
                    "type": "Expression"
                },
                "folderPath": {
                    "value": "@dataset().Directory",
                    "type": "Expression"
                },
                "container": {
                    "value": "@dataset().FileSystem",
                    "type": "Expression"
                }
            }
        }
    },
    "type": "Microsoft.DataFactory/factories/datasets"
}