function(GenerateArm=false,GFPIR="IRA")
{
local referenceName = "GDS_AzureSqlDWTable_NA_",
"outputs":
[
  {
    "referenceName":  if(GenerateArm=="false") 
                      then referenceName + GFPIR
                      else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
      "Schema": {
        "value": "@pipeline().parameters.TaskObject.Target.StagingTableSchema",
        "type": "Expression"
      },
      "Table": {
        "value": "@pipeline().parameters.TaskObject.Target.StagingTableName",
        "type": "Expression"
      },
      "Server": {
        "value": "@pipeline().parameters.TaskObject.Target.System.SystemServer",
        "type": "Expression"
      },
      "Database": {
        "value": "@pipeline().parameters.TaskObject.Target.System.Database",
        "type": "Expression"
      }
    }
  }
]
}