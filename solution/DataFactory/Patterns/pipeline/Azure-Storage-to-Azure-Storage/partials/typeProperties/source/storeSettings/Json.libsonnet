function(SourceType = "AzureBlobStorage")	
{
    "type": "%(SourceType)sReadSettings" % {SourceType:SourceType},
    "maxConcurrentConnections": {
        "value": "@pipeline().parameters.TaskObject.Source.MaxConcurrentConnections",
        "type": "Expression"
    },
    "recursive": true
}