function(GFPIR="IRA", SourceType="AzureSqlTable", SourceFormat="NA")
if (SourceType=="AzureSqlTable" && SourceFormat == "NA") then
{
  "source": {
    "type": "AzureSqlSource",
    "sqlReaderQuery": {
      "value": "@{pipeline().parameters.TaskObject.Source.Extraction.IncrementalSQLStatement}",
      "type": "Expression"
    },
    "queryTimeout": "02:00:00",
    "partitionOption": "None"
  },
  "dataset": {
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
  },
  "firstRowOnly": true
}
else
if (SourceType=="AzureSqlTable" && SourceFormat == "NA") then
{
  "source": {
    "type": "SqlServerSource",
    "sqlReaderQuery": {
      "value": "@{pipeline().parameters.TaskObject.Source.Extraction.IncrementalSQLStatement}",
      "type": "Expression"
    },
    "queryTimeout": "02:00:00",
    "partitionOption": "None"
  },
  "dataset": {
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
  },
  "firstRowOnly": true
}
