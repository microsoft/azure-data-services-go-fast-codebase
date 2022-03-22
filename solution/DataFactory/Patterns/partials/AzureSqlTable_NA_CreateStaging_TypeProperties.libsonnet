function(GFPIR="IRA") {
    "source": {
        "type": "AzureSqlSource",
        "sqlReaderQuery": {
            "value": "@activity('AF Get SQL Create Statement Staging').output.CreateStatement",
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
    },
    "firstRowOnly": false
}

