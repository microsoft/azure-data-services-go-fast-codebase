function() 
{"inputs":
[
    {
        "referenceName": "[concat('GDS_AzureBlobFS_Json_', parameters('integrationRuntimeShortName'))]",
        "type": "DatasetReference",
        "parameters": {
            "RelativePath": {
                "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
                "type": "Expression"
            },
            "FileName": {
                "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
                "type": "Expression"
            },
            "StorageAccountEndpoint": {
                "value": "@pipeline().parameters.TaskObject.Source.StorageAccountName",
                "type": "Expression"
            },
            "StorageAccountContainerName": {
                "value": "@pipeline().parameters.TaskObject.Source.StorageAccountContainer",
                "type": "Expression"
            }
        }
    }
]
}
