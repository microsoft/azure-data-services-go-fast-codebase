function (GenerateArm=false, SourceType = "AzureBlobStorage", GFPIR = "{IRA}")
{
    local SourceFormat = "DelimitedText",
    "referenceName":  if(GenerateArm) 
                      then "[concat('GDS_%(SourceType)s_%(SourceFormat)s_', parameters('integrationRuntimeShortName'))]" % {SourceType:SourceType, SourceFormat:SourceFormat, GFPIR:GFPIR}
                      else "GDS_%(SourceType)s_%(SourceFormat)s_%(GFPIR)s" % {SourceType:SourceType, SourceFormat:SourceFormat, GFPIR:GFPIR},
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