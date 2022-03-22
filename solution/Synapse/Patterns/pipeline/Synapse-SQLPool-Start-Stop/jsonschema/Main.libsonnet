local partials = {
    "Not-Applicable": import "Not-Applicable.libsonnet"
};


function(SourceType = "", SourceFormat = "Not-Applicable", TargetType = "", TargetFormat = "Not-Applicable")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "SQLPoolName": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "TestPool"
                },
                "infoText": "Use this field to define the name of the Synapse SQL Pool you are wanting to manipulate within your workspace."
            }
        },
        "SQLPoolOperation": {
            "type": "string",
            "enum": [
                "Start",
                "Pause"
            ],
        },
        "Source": partials[SourceFormat](),
        "Target": partials[TargetFormat]()
    },
    "required": [
        "SQLPoolName",
        "SQLPoolOperation"
    ]
}