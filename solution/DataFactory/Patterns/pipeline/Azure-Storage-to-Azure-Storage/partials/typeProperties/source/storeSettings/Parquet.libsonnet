function (GenerateArm=false, SourceType = "AzureBlobStorage", GFPIR = "{IRA}")
{
    "type": "%(SourceType)sReadSettings" % {SourceType:SourceType},
    "recursive": false,
    "wildcardFolderPath": {
        "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
        "type": "Expression"
    },
    "wildcardFileName": "*.parquet",
    "enablePartitionDiscovery": false
}