local partials = {
    "Notebook-Optional": import "Partial_Notebook_Optional.libsonnet"
};


function(SourceType = "", SourceFormat = "Notebook-Optional",TargetType = "", TargetFormat = "Notebook-Optional")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "Purview": {
            "type": "string",
            "default": "Disabled",
            "enum": [
                "Enabled",
                "Disabled"
            ],
            "options": {
                "infoText": "(required) Use this to enable the pipeline to be written to purview. Note: This will not work if Purview is not enabled and configured with the ExecutionEngine."
            }
        },
        "QualifiedIDAssociation": {
            "type": "string",
            "default": "TaskMasterId",
            "enum": [
                "ExecutionId",
                "TaskMasterId"
            ],
            "options": {
                "infoText": "(optional) This is used to enable Purview to direct the QualifiedID (UID) to attach itself to the relevant ID. Note: If attached to the ExecutionID each indiviudal run of the pipeline with have a lineage."
            }
        }, 
        "ExecuteNotebook": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "DeltaProcessingNotebook"
                },
                "infoText": "(required) Use this field to define the name of the notebook to execute."
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
                "infoText": "(optional) Use this field to create fields to use in your notebook from the TaskObject."
            }
        },
        "UseNotebookActivity": {
            "type": "string",
            "default": "Disabled",
            "enum": [
                "Enabled",
                "Disabled"
            ],
            "options": {
                "infoText": "(required) This flag is used to control the method used to call the Synapse Notebook that carries out the processing. When Enabled the default notebook activity type within Synapse pipelines will be used. Note that this will force a new spark session for each job execution. By leaving this flag disabled an Azure Function is used to call the notebook and Spark Sessions will be reused if available."
            }
        },
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
        "ExecuteNotebook",
        "Purview",
        "CustomDefinitions",
        "UseNotebookActivity"
    ]
}