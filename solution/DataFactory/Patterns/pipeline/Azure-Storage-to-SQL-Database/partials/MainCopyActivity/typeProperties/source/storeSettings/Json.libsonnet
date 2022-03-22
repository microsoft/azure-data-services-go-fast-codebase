function(SourceType = "AzureBlobStorage")	
{
    "type": "%(SourceType)sReadSettings" % {SourceType:SourceType},
    "recursive": true
}