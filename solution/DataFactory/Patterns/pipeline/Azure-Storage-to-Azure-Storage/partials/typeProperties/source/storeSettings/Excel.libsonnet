function (GenerateArm=false, SourceType = "AzureBlobStorage", GFPIR = "{IRA}")
{
    "type": "%(SourceType)sReadSettings" % {SourceType:SourceType},
    "recursive": true
}
