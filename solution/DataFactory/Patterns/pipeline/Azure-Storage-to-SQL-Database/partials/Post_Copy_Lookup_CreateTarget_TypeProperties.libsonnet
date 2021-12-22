function(GenerateArm=false,GFPIR="IRA", TargetType="AzureSqlTable", TargetFormat="NA")
if (TargetType=="AzureSqlTable"&&TargetFormat=="NA") then
{
    local referenceName = "GDS_AzureSqlTable_NA_",
    "source": {
      "type": "AzureSqlSource",
      "sqlReaderQuery": {
          "value": "@activity('AF Get Information Schema SQL Target').output.InformationSchemaSQL",
          "type": "Expression"
      },
      "queryTimeout": "02:00:00",
      "partitionOption": "None"
    },
    "dataset": {
         "referenceName":    if(GenerateArm=="false") 
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
                "value": "@pipeline().parameters.TaskObject.Target.Database.SystemName",
                "type": "Expression"
            },
            "Database": {
                "value": "@pipeline().parameters.TaskObject.Target.Database.Name",
                "type": "Expression"
            }
        }
    },
     "firstRowOnly": false
}
else
  error 'Post_Copy_Lookup_AutoMergeSQL_TypeProperties.libsonnet failed. No mapping for:' +GFPIR+","+TargetType+","+TargetFormat