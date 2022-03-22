function (allowPolyBase=false)
{
        "type": "SqlDWSink",
        "preCopyScript": {
            "value": "@{pipeline().parameters.TaskObject.Target.PreCopySQL}",
            "type": "Expression"
        },
        "allowPolyBase": allowPolyBase,        
        "tableOption": "autoCreate",
        "disableMetricsCollection": false
}
+ 
if allowPolyBase then 
{
        "polyBaseSettings": {
            "rejectValue": 0,
            "rejectType": "value",
            "useTypeDefault": true
        }
}
else 
{}