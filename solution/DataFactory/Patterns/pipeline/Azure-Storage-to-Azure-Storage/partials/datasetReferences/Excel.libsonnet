function (GenerateArm=false, SourceType = "AzureBlobStorage", GFPIR = "{IRA}")
{
    local SourceFormat = "Excel",
    "referenceName":  if(GenerateArm) 
                      then "[concat('GDS_%(SourceType)s_%(SourceFormat)s_', parameters('integrationRuntimeShortName'))]" % {SourceType:SourceType, SourceFormat:SourceFormat, GFPIR:GFPIR}
                      else "GDS_%(SourceType)s_%(SourceFormat)s_%(GFPIR)s" % {SourceType:SourceType, SourceFormat:SourceFormat, GFPIR:GFPIR},
    "type": "DatasetReference",
    "parameters": {
        "RelativePath": {
            "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
            "type": "Expression"
        },
        "FileName": {
            "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
            "type": "Expression"
        },
        "StorageAccountEndpoint": {
            "value": "@pipeline().parameters.TaskObject.Source.StorageAccountName",
            "type": "Expression"
        },
        "StorageAccountContainerName": {
            "value": "@pipeline().parameters.TaskObject.Source.StorageAccountContainer",
            "type": "Expression"
        },
        "SheetName": {
            "value": "@pipeline().parameters.TaskObject.Source.SheetName",
            "type": "Expression"
        },
        "FirstRowAsHeader": {
            "value": "@pipeline().parameters.TaskObject.Source.FirstRowAsHeader",
            "type": "Expression"
        }
    }
}