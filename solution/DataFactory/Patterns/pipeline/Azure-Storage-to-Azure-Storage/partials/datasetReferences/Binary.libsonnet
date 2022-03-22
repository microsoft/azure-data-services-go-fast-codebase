function (GenerateArm=false, Type = "AzureBlobStorage", GFPIR = "{IRA}", SourceOrTarget = "Source")
{
    local Format = "Binary",
    "referenceName":  if(GenerateArm) 
                      then "[concat('GDS_%(Type)s_%(Format)s_', parameters('integrationRuntimeShortName'))]" % {Type:Type, Format:Format, GFPIR:GFPIR}
                      else "GDS_%(Type)s_%(Format)s_%(GFPIR)s" % {Type:Type, Format:Format, GFPIR:GFPIR},
    "type": "DatasetReference",
    "parameters": if Type=="FileServer" then 
    {
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.RelativePath" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.DataFileName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "Host": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.SystemServer" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "KeyVaultBaseUrl": {
            "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
            "type": "Expression"
        },
        "Secret": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.PasswordKeyVaultSecretName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "UserId": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.Username" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        }
    }
    else 
    {
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.SystemServer" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.RelativePath" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "FileSystem": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.Container" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.DataFileName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        }        
    }
}