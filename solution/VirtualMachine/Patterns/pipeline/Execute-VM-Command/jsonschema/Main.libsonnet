local partials = {
    "Not-Applicable": import "Not-Applicable.libsonnet",
    "dbt": import "dbt.libsonnet"

};


function(SourceType = "", SourceFormat = "Not-Applicable", TargetType = "", TargetFormat = "Not-Applicable")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "ExecutionPath": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "/home/testuser"
                },
                "infoText": "(required) Use this field to define the FULL path where you wish to execute the command."
            }
        },
        "Source": partials[SourceFormat](),
        "Target": partials[TargetFormat]()
    },
    "required": [
        "ExecutionPath"
    ]
}