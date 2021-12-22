function() 
{"outputs":
[
  {
    "referenceName": "[concat('GDS_AzureSqlTable_NA_', parameters('integrationRuntimeShortName'))]",
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
        "value": "@pipeline().parameters.TaskObject.Target.Database.SystemName",
        "type": "Expression"
      },
      "Database": {
        "value": "@pipeline().parameters.TaskObject.Target.Database.Name",
        "type": "Expression"
      }
    }
  }
]
}