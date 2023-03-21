function(GenerateArm="false",GFPIR="IRA", SourceType="AzureSqlTable")
local TempOutputSuccess = import './Main_Set_Parameter_Set_Success.libsonnet';
local TempOutputFail = import './Main_Set_Parameter_Set_Fail.libsonnet';

if (SourceType=="AzureSqlTable") then
{
  local referenceName = "GDS_AzureSqlTable_NA_",
  "on": {
    "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
    "type": "Expression"
  },
  "cases": [
      {
          "value": "MSI",
          "activities": [
              {
                  "name": "Lookup Get AzureSQL Metadata MSIAuth",
                  "type": "Lookup",
                  "dependsOn": [],
                  "policy": {
                      "timeout": "7.00:00:00",
                      "retry": 0,
                      "retryIntervalInSeconds": 30,
                      "secureOutput": false,
                      "secureInput": false
                  },
                  "userProperties": [],
                  "typeProperties": {
                    "source": {
                        "type": "AzureSqlSource",
                        "sqlReaderQuery": {
                          "value": "@activity('AF Get Information Schema SQL').output.InformationSchemaSQL",
                          "type": "Expression"
                        },
                        "queryTimeout": "02:00:00",
                        "partitionOption": "None"
                      },
                      "dataset": {    
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
                      },
                      "firstRowOnly": false
                  }
              },
                TempOutputSuccess("Lookup Get AzureSQL Metadata MSIAuth"),
                TempOutputFail("Lookup Get AzureSQL Metadata MSIAuth")
          ]
      }
  ],
  "defaultActivities": [
      {
          "name": "Failure",
          "type": "Fail",
          "dependsOn": [],
          "userProperties": [],
          "typeProperties": {
              "message": "No Valid Auth Type Provided",
              "errorCode": "400"
          }
      }
  ]
}
else if (SourceType=="SqlServerTable") then
{
  local referenceName = "GDS_SqlServerTable_NA_",
  local referenceNameSql = "GDS_SqlServerTable_NA_SqlAuth_",
  "on": {
      "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
      "type": "Expression"
  },
  "cases": [
      {
          "value": "WindowsAuth",
          "activities": [
              {
                  "name": "Lookup Get SQL Metadata windowsAuth",
                  "type": "Lookup",
                  "dependsOn": [],
                  "policy": {
                      "timeout": "7.00:00:00",
                      "retry": 0,
                      "retryIntervalInSeconds": 30,
                      "secureOutput": false,
                      "secureInput": false
                  },
                  "userProperties": [],
                  "typeProperties": {
                      "source": {
                          "type": "SqlServerSource",
                          "sqlReaderQuery": {
                              "value": "@activity('AF Get Information Schema SQL').output.InformationSchemaSQL",
                              "type": "Expression"
                          },
                          "queryTimeout": "02:00:00",
                          "partitionOption": "None"
                      },
                      "dataset": {
                          "referenceName":  if(GenerateArm=="false") 
                                            then referenceName + GFPIR
                                            else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
                          "type": "DatasetReference",
                          "parameters": {
                              "Database": {
                                  "value": "@pipeline().parameters.TaskObject.Source.System.Database",
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
                              "TableName": {
                                  "value": "@pipeline().parameters.TaskObject.Source.TableName",
                                  "type": "Expression"
                              },
                              "TableSchema": {
                                  "value": "@pipeline().parameters.TaskObject.Source.TableSchema",
                                  "type": "Expression"
                              },
                              "UserName": {
                                  "value": "@pipeline().parameters.TaskObject.Source.System.Username",
                                  "type": "Expression"
                              }
                          }
                      },
                      "firstRowOnly": false
                  }
              },
                TempOutputSuccess("Lookup Get SQL Metadata windowsAuth"),
                TempOutputFail("Lookup Get SQL Metadata windowsAuth")
          ]
      },
      {
          "value": "SQLAuth",
          "activities": [
              {
                  "name": "Lookup Get SQL Metadata sqlAuth",
                  "type": "Lookup",
                  "dependsOn": [],
                  "policy": {
                      "timeout": "7.00:00:00",
                      "retry": 0,
                      "retryIntervalInSeconds": 30,
                      "secureOutput": false,
                      "secureInput": false
                  },
                  "userProperties": [],
                  "typeProperties": {
                      "source": {
                          "type": "SqlServerSource",
                          "sqlReaderQuery": {
                              "value": "@activity('AF Get Information Schema SQL').output.InformationSchemaSQL",
                              "type": "Expression"
                          },
                          "queryTimeout": "02:00:00",
                          "partitionOption": "None"
                      },
                      "dataset": {
                          "referenceName":  if(GenerateArm=="false") 
                                            then referenceNameSql + GFPIR
                                            else "[concat('"+referenceNameSql+"', parameters('integrationRuntimeShortName'))]",
                          "type": "DatasetReference",
                          "parameters": {
                              "Database": {
                                  "value": "@pipeline().parameters.TaskObject.Source.System.Database",
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
                              "TableName": {
                                  "value": "@pipeline().parameters.TaskObject.Source.TableName",
                                  "type": "Expression"
                              },
                              "TableSchema": {
                                  "value": "@pipeline().parameters.TaskObject.Source.TableSchema",
                                  "type": "Expression"
                              },
                              "UserName": {
                                  "value": "@pipeline().parameters.TaskObject.Source.System.Username",
                                  "type": "Expression"
                              }
                          }
                      },
                      "firstRowOnly": false
                  }
              },
                TempOutputSuccess("Lookup Get SQL Metadata sqlAuth"),
                TempOutputFail("Lookup Get SQL Metadata sqlAuth")
          ]
      }
  ],
  "defaultActivities": [
      {
          "name": "Failure",
          "type": "Fail",
          "dependsOn": [],
          "userProperties": [],
          "typeProperties": {
              "message": "No Valid Auth Type Provided",
              "errorCode": "400"
          }
      }
  ]
}
else if (SourceType=="OracleServerTable") then
{
  local referenceName = "GDS_OracleServerTable_NA_",
  "on": {
    "value": "@pipeline().parameters.TaskObject.Source.System.AuthenticationType",
    "type": "Expression"
  },
  "cases": [
      {
          "value": "SID",
          "activities": [
              {
                  "name": "Lookup Get Oracle Metadata SIDAuth",
                  "type": "Lookup",
                  "dependsOn": [],
                  "policy": {
                      "timeout": "7.00:00:00",
                      "retry": 0,
                      "retryIntervalInSeconds": 30,
                      "secureOutput": false,
                      "secureInput": false
                  },
                  "userProperties": [],
                  "typeProperties": {
                      "source": {
                      "type": "OracleSource",
                      "oracleReaderQuery": {
                        "value": "@activity('AF Get Information Schema SQL').output.InformationSchemaSQL",
                        "type": "Expression"
                      },
                      "queryTimeout": "02:00:00",
                      "partitionOption": "None"
                    },
                    "dataset": {    
                      "referenceName":if(GenerateArm=="false") 
                                      then referenceName + GFPIR
                                      else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",   
                      "type": "DatasetReference",
                      "parameters": {
                          "Host": {
                              "value": "@pipeline().parameters.TaskObject.Source.System.SystemServer",
                              "type": "Expression"
                          },
                          "Port": {
                              "value": "@pipeline().parameters.TaskObject.Source.System.Port",
                              "type": "Expression"
                          },
                          "ServiceName": {
                              "value": "@pipeline().parameters.TaskObject.Source.System.ServiceName",
                              "type": "Expression"
                          },
                          "UserName": {
                              "value": "@pipeline().parameters.TaskObject.Source.System.Username",
                              "type": "Expression"
                          },
                          "KeyVaultBaseUrl": {
                              "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
                              "type": "Expression"
                          },
                          "Secret": {
                              "value": "@pipeline().parameters.TaskObject.Source.System.SecretName",
                              "type": "Expression"
                          },
                          "TableSchema": {
                              "value": "@pipeline().parameters.TaskObject.Source.TableSchema",
                              "type": "Expression"
                          },
                          "TableName": {
                              "value": "@pipeline().parameters.TaskObject.Source.TableName",
                              "type": "Expression"
                          }
                      }
                    },
                    "firstRowOnly": false
                  }
              },
                TempOutputSuccess("Lookup Get Oracle Metadata SIDAuth"),
                TempOutputFail("Lookup Get Oracle Metadata SIDAuth")
          ]
      }
  ],
  "defaultActivities": [
      {
          "name": "Failure",
          "type": "Fail",
          "dependsOn": [],
          "userProperties": [],
          "typeProperties": {
              "message": "No Valid Auth Type Provided",
              "errorCode": "400"
          }
      }
  ]
}
else
  error 'GetInformationSchema.libsonnet failed. No mapping for:' +GFPIR+","+SourceType