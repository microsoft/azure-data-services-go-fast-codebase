function(SourceType = "AzureBlobStorage")	
{
    "type": "%(SourceType)sReadSettings" % {SourceType:SourceType},
    "maxConcurrentConnections": {
        "value": "@pipeline().parameters.TaskObject.Source.MaxConcorrentConnections",
        "type": "Expression"
    },
    "recursive": true,
    "wildcardFolderPath": {
        "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
        "type": "Expression"
    },
    "wildcardFileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
    },
    "enablePartitionDiscovery": false
}