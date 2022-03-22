function(GFPIR="IRA") [{
  "referenceName": "GDS_AzureSqlTable_NA_" + GFPIR,
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
