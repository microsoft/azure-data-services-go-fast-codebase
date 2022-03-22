function (GenerateArm=false, Type = "AzureSqlDWTable", GFPIR = "{IRA}", SourceOrTarget = "Source")
{
    local Format = "NA",
    "referenceName":  if(GenerateArm) 
                      then "[concat('GDS_%(Type)s_%(Format)s_', parameters('integrationRuntimeShortName'))]" % {Type:Type, Format:Format, GFPIR:GFPIR}
                      else "GDS_%(Type)s_%(Format)s_%(GFPIR)s" % {Type:Type, Format:Format, GFPIR:GFPIR},
    "type": "DatasetReference",
    "parameters": {
        "Schema": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.StagingTableSchema" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "Table": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.StagingTableName" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "Server": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.SystemServer" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        },
        "Database": {
            "value": "@pipeline().parameters.TaskObject.%(SourceOrTarget)s.System.Database" % { SourceOrTarget : SourceOrTarget},
            "type": "Expression"
        }
    }
}
