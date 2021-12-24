function (SourceType = "AzureBlobStorage", SourceFormat = "Binary", GFPIR="{IRA}")
if (SourceType == "AzureBlobStorage" && SourceFormat == "Binary") then
{
    "referenceName": "[concat('GDS_AzureBlobStorage_Binary_', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.Target.StorageAccountName",
            "type": "Expression"
        },
        "FileSystem": {
            "value": "@pipeline().parameters.TaskObject.Target.StorageAccountContainer",
            "type": "Expression"
        },
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.Target.DataFileName",
            "type": "Expression"
        }
    }
}
else if (SourceType == "AzureBlobFS"  && SourceFormat == "Binary") then
{
    "referenceName": "[concat('GDS_AzureBlobFS_Binary_', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.Target.StorageAccountName",
            "type": "Expression"
        },
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
            "type": "Expression"
        },
        "FileSystem": {
            "value": "@pipeline().parameters.TaskObject.Target.StorageAccountContainer",
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.Target.DataFileName",
            "type": "Expression"
        }
    }
}