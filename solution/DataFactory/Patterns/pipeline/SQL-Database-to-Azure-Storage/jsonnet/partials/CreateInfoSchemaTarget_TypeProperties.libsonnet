function(GFPIR="IRA", SourceType="AzureSqlTable", SourceFormat="NA")
if (SourceType=="AzureSqlTable" && SourceFormat == "NA") then
{
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
        "referenceName": "GDS_AzureSqlTable_NA_" + GFPIR,
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
  error 'CreateInfoSchemaTarget_TypeProperties.libsonnet Failed: ' + GFPIR+","+SourceType+","+SourceFormat

