function (SourceType="AzureBlobStorage")
if (SourceType == "AzureBlobStorage") then
{
    "type": "AzureBlobStorageReadSettings",
    "recursive": {
        "value": "@pipeline().parameters.TaskObject.Source.Recursively",
        "type": "Expression"
    },
    "wildcardFileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
    },
    "deleteFilesAfterCompletion": {
        "value": "@pipeline().parameters.TaskObject.Source.DeleteAfterCompletion",
        "type": "Expression"
    }
}
else if (SourceType == "AzureBlobFS") then
{
    "type": "AzureBlobFSReadSettings",
    "recursive": {
        "value": "@pipeline().parameters.TaskObject.Source.Recursively",
        "type": "Expression"
    },
    "wildcardFileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
    },
    "deleteFilesAfterCompletion": {
        "value": "@pipeline().parameters.TaskObject.Source.DeleteAfterCompletion",
        "type": "Expression"
    }
}