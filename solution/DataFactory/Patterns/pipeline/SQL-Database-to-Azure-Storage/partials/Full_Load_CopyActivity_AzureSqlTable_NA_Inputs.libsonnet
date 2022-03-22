function(GenerateArm="false",GFPIR="IRA") 
{"inputs":
[{
  local referenceName = "GDS_AzureSqlTable_NA_",
  "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",     
  "type": "DatasetReference",
  "parameters": {
    "Schema": {
      "value": "@pipeline().parameters.TaskObject.Source.TableSchema",
      "type": "Expression"
    },
    "Table": {
      "value": "@pipeline().parameters.TaskObject.Source.TableName",
      "type": "Expression"
    },
    "Server": {
      "value": "@pipeline().parameters.TaskObject.Source.System.SystemServer",
      "type": "Expression"
    },
    "Database": {
      "value": "@pipeline().parameters.TaskObject.Source.System.Database",
      "type": "Expression"
    }
  }
}]
}