local partials = {
    "Notebook-Optional": import "Partial_Notebook_Optional.libsonnet"
};


function(SourceType = "", SourceFormat = "Notebook-Optional",TargetType = "", TargetFormat = "Notebook-Optional")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "NotebookPath": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "/Shared/Test"
                },
                "infoText": "(required) Use this field to define the path of the notebook to execute."
            }
        },
        "Source": partials[SourceFormat](),
        "Target": partials[TargetFormat](),
        "ClusterNodeType": {
            "type": "string",
            "default": "Standard_DS3_v2",
            "options": {
                "infoText": "(required) Define the node type for the job cluster to be created."
            }
        },
        "ClusterVersion": {
            "type": "string",            
            "default": "12.2.x-scala2.12",
            "options": {                        
                "infoText": "(required) The databricks runtime version for the cluster to run on."
            }
        },
        "Workers": {
            "type": "string",            
            "default": "3",
            "options": {                        
                "infoText": "(required) The workers assigned to the execution of the job."
            }
        },
        "CustomInstancePoolID": {
            "type": "string",            
            "default": "",
            "options": {                        
                "infoText": "(optional) The ID of the Instance Pool to execute the job. Note: Leave this blank if you wish to use the default deployed Instance Pool."
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
        "NotebookPath",
        "ClusterNodeType",
        "ClusterVersion",
        "Workers",
        "CustomInstancePoolID"
    ]
}