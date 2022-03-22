function(GenerateArm="false",GFPIR="IRA") 
 {
   local referenceName = "GDS_SqlServerTable_NA_",
   "inputs": [{    
    "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",   
    "type": "DatasetReference",
    "parameters": {
      "TableSchema": {
        "value": "@pipeline().parameters.TaskObject.Source.TableSchema",
        "type": "Expression"
      },
      "TableName": {
        "value": "@pipeline().parameters.TaskObject.Source.TableName",
        "type": "Expression"
      },
      "KeyVaultBaseUrl": {
        "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
        "type": "Expression"
      },
      "PasswordSecret": {
        "value": "@pipeline().parameters.TaskObject.Source.System.PasswordKeyVaultSecretName",
        "type": "Expression"
      },
      "Server": {
        "value": "@pipeline().parameters.TaskObject.Source.System.SystemServer",
        "type": "Expression"
      },
      "Database": {
        "value": "@pipeline().parameters.TaskObject.Source.System.Database",
        "type": "Expression"
      },
      "UserName": {
        "value": "@pipeline().parameters.TaskObject.Source.System.Username",
        "type": "Expression"
      }
    }
  }]
 }