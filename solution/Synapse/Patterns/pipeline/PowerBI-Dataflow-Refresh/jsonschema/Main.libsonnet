local partials = {
    "Not-Applicable": import "Not-Applicable.libsonnet"
};


function(SourceType = "", SourceFormat = "Not-Applicable", TargetType = "", TargetFormat = "Not-Applicable")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "DataflowName": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "df_testdataflow"
                },
                "infoText": "(required) Use this field to define the name of the dataflow you are wanting to refresh within the specified workspace."
            }
        },
        "WorkspaceId": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "00000000-0000-0000-0000-000000000000"
                },
                "infoText": "(required) Use this field to define the ID of the workspace that contains the dataflow you wish to reference."
            },
        },
        "FunctionToExecute": {
            "type": "string",
            "enum": [
                "PowerBIRefreshDataflow"
            ],
            "options": {
                "hidden": true
            },
            "default": "PowerBIRefreshDataflow"
        },
        "FunctionToCheck": {
            "type": "string",
            "enum": [
                "PowerBICheckDataflowRefresh"
            ],
            "options": {
                "hidden": true
            },
            "default": "PowerBICheckDataflowRefresh"
        },
        "Source": partials[SourceFormat](),
        "Target": partials[TargetFormat](),
        "NotificationList": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": ""
                },
                "infoText": "(optional) Use this field to specify email addresses you wish to report the relevant completion condition to. This conditon is defined by EmailNotficationOn. Notes: Separate multiple email addresses with commas / This relies on Azure Communication Services being configured."
            }
        },
        "NotificationOn": {
            "type": "string",
            "default": "Disabled",
            "enum": [
                "Disabled",
                "Completion",
                "Failure",
                "FailureNoRetry",
                "Success"
            ],
            "options": {
                "infoText": "(optional) This flag is used to define on what condition you wish to notify the addresses from the NotificationList when this task completes. Note: Completion will notify whenever the task has been execution of the task has been finished regardless on the outcome."
            }
        }
    },
    "required": [
        "DataflowName",
        "WorkspaceId"
    ]
}