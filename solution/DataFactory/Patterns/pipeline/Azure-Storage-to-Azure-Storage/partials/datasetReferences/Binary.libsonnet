function (GenerateArm=false, Type = "AzureBlobStorage", GFPIR = "{IRA}", SourceOrTarget = "Source")
{
    local Format = "Binary",
    "referenceName":  if(GenerateArm) 
                      then "[concat('GDS_%(Type)s_%(Format)s_', parameters('integrationRuntimeShortName'))]" % {Type:Type, Format:Format, GFPIR:GFPIR}
                      else "GDS_%(Type)s_%(Format)s_%(GFPIR)s" % {Type:Type, Format:Format, GFPIR:GFPIR},
    "type": "DatasetReference",
    "parameters": {
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.StorageAccountName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.RelativePath" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "FileSystem": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.StorageAccountContainer" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.DataFileName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        }
    }
}