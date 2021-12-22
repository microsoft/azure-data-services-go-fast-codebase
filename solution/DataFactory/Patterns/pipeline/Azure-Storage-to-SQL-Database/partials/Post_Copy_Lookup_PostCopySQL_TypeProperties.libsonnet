function(TargetType="AzureSqlTable", TargetFormat="NA")
if (TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
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
        "referenceName": "[concat('GDS_AzureSqlTable_NA_', parameters('integrationRuntimeShortName'))]",
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
                "value": "@pipeline().parameters.TaskObject.Target.Database.SystemName",
                "type": "Expression"
            },
            "Database": {
                "value": "@pipeline().parameters.TaskObject.Target.Database.Name",
                "type": "Expression"
            }
        }
    }
}
else
  error 'Post_Copy_Lookup_PostCopySQL_TypeProperties.libsonnet failed. No mapping for:' +TargetType+","+TargetFormat