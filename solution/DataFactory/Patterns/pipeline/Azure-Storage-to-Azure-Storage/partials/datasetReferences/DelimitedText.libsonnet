function (GenerateArm=false, Type = "AzureBlobStorage", GFPIR = "{IRA}", SourceOrTarget = "Source")
{
    local Format = "DelimitedText",
    "referenceName":  if(GenerateArm) 
                      then "[concat('GDS_%(Type)s_%(Format)s_', parameters('integrationRuntimeShortName'))]" % {Type:Type, Format:Format, GFPIR:GFPIR}
                      else "GDS_%(Type)s_%(Format)s_%(GFPIR)s" % {Type:Type, Format:Format, GFPIR:GFPIR},
    "type": "DatasetReference",
    "parameters": {
        "RelativePath": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.RelativePath" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "FileName": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.DataFileName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.SystemServer" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "StorageAccountContainerName": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.Container" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "FirstRowAsHeader": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.FirstRowAsHeader" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        }
    }
}