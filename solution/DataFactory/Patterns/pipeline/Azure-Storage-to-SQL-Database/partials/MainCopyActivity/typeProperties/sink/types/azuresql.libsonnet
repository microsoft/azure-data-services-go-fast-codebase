function (allowPolyBase=false)
{
    "type": "AzureSqlSink",
    "preCopyScript": {
        "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
        "type": "Expression"
    },
    "tableOption": "autoCreate",
    "disableMetricsCollection": false
}