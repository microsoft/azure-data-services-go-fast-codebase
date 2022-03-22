function(GFPIR="IRA") {
    "source": {
        "type": "JsonSource",
        "storeSettings": {
            "type": "AzureBlobFSReadSettings",
            "recursive": true
        },
        "formatSettings": {
            "type": "JsonReadSettings"
        }
    },
    "sink": {
        "type": "AzureSqlSink",
        "preCopyScript": {
            "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
            "type": "Expression"
        },
        "disableMetricsCollection": false
    },
    "enableStaging": false,
    "parallelCopies": {
        "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
        "type": "Expression"
    }
}

