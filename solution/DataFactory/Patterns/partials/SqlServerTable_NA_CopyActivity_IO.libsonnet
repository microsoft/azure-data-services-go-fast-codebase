function(GFPIR="IRA") 
[{
    "referenceName": "GDS_SqlServerTable_NA_" + GFPIR,
    "type": "DatasetReference",
    "parameters": {
      "TableSchema": {
        "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableSchema",
        "type": "Expression"
      },
      "TableName": {
        "value": "@pipeline().parameters.TaskObject.Source.Extraction.TableName",
        "type": "Expression"
      },
      "KeyVaultBaseUrl": {
        "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
        "type": "Expression"
      },
      "PasswordSecret": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.PasswordKeyVaultSecretName",
        "type": "Expression"
      },
      "Server": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.SystemName",
        "type": "Expression"
      },
      "Database": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.Name",
        "type": "Expression"
      },
      "UserName": {
        "value": "@pipeline().parameters.TaskObject.Source.Database.Username",
        "type": "Expression"
      }
    }
  }]
