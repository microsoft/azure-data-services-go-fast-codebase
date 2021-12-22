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
      "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableSchema",
      "type": "Expression"
    },
    "Table": {
      "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableName",
      "type": "Expression"
    },
    "Server": {
      "value": "@pipeline().parameters.TaskObject.Source.Database.SystemName",
      "type": "Expression"
    },
    "Database": {
      "value": "@pipeline().parameters.TaskObject.Source.Database.Name",
      "type": "Expression"
    }
  }
}]
}