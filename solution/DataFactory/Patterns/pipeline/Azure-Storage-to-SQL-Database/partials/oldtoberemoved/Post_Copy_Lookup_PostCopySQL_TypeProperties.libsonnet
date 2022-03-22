function(GenerateArm="true",GFPIR="IRA", TargetType="AzureSqlTable", TargetFormat="NA")
if (TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
    local referenceName = "GDS_AzureSqlTable_NA_",
    "source": {
      "type": "AzureSqlSource",
      "sqlReaderQuery": {
          "value": "@pipeline().parameters.TaskObject.Target.PostCopySQL",
          "type": "Expression"
      },
      "queryTimeout": "02:00:00",
      "partitionOption": "None"
    },
    "dataset": {
         "referenceName":   if(GenerateArm=="false") 
                            then referenceName + GFPIR
                            else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
        "type": "DatasetReference",
        "parameters": {
            "Schema": {
                "value": "@pipeline().parameters.TaskObject.Target.TableSchema",
                "type": "Expression"
            },
            "Table": {
                "value": "@pipeline().parameters.TaskObject.Target.TableName",
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
}
else if (TargetType=="AzureSqlDWTable"&&TargetFormat=="NA") then
{
    local referenceName = "GDS_AzureSqlDWTable_NA_",
    "source": {
      "type": "SqlDWSource",
      "sqlReaderQuery": {
          "value": "@pipeline().parameters.TaskObject.Target.PostCopySQL",
          "type": "Expression"
      },
      "queryTimeout": "02:00:00",
      "partitionOption": "None"
    },
    "dataset": {
         "referenceName":   if(GenerateArm=="false") 
                            then referenceName + GFPIR
                            else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
        "type": "DatasetReference",
        "parameters": {
            "Schema": {
                "value": "@pipeline().parameters.TaskObject.Target.TableSchema",
                "type": "Expression"
            },
            "Table": {
                "value": "@pipeline().parameters.TaskObject.Target.TableName",
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
}
else
  error 'Post_Copy_Lookup_PostCopySQL_TypeProperties.libsonnet failed. No mapping for:' +GFPIR+","+TargetType+","+TargetFormat