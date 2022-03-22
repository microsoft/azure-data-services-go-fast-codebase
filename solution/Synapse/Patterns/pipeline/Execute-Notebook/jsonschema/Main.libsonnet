local partials = {
    "Notebook-Optional": import "Partial_Notebook_Optional.libsonnet"
};


function(SourceType = "", SourceFormat = "Notebook-Optional",TargetType = "", TargetFormat = "Notebook-Optional")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "ExecuteNotebook": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "DeltaProcessingNotebook"
                },
                "infoText": "Use this field to define the name of the notebook to execute."
            }
        },
        "Source": partials[SourceFormat](),
        "Target": partials[TargetFormat](),
        "CustomDefinitions": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": ""
                },
                "infoText": "Use this field to create fields to use in your notebook from the TaskObject."
            }
        }
    },
    "required": [
        "ExecuteNotebook",
        "CustomDefinitions"
    ]
}