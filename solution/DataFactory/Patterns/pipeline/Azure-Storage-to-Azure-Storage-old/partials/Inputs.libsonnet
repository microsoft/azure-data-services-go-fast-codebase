function (SourceType = "AzureBlobStorage", SourceFormat = "Binary", GFPIR="{IRA}")
if (SourceType == "AzureBlobStorage") then
{
    "referenceName": "[concat('GDS_AzureBlobStorage_Binary_', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.Source.StorageAccountName",
            "type": "Expression"
        },
        "FileSystem": {
            "value": "@pipeline().parameters.TaskObject.Source.StorageAccountContainer",
            "type": "Expression"
        },
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
            "type": "Expression"
        }
    }
}
else if (SourceType == "AzureBlobFS") then
{
    "referenceName": "[concat('GDS_AzureBlobFS_Binary_', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.Source.StorageAccountName",
            "type": "Expression"
        },
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
            "type": "Expression"
        },
        "FileSystem": {
            "value": "@pipeline().parameters.TaskObject.Source.StorageAccountContainer",
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
            "type": "Expression"
        }
    }
}