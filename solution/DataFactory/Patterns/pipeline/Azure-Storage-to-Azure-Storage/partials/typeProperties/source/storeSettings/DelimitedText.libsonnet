function(SourceType = "AzureBlobStorage")	
{
    "type": "%(SourceType)sReadSettings" % {SourceType:SourceType},
    "maxConcurrentConnections": {
        "value": "@pipeline().parameters.TaskObject.Source.MaxConcurrentConnections",
        "type": "Expression"
    },
    "recursive": true,
    "wildcardFolderPath": {
        "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
        "type": "Expression"
    },
    "wildcardFileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
    },
    "enablePartitionDiscovery": false
}