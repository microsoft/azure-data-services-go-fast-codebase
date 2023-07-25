local partials = {
    "Anonymous": import "Partial_SourceAnonymousAuth.libsonnet",
    "Basic": import "Partial_SourceBasicAuth.libsonnet",
    "ServicePrincipal": import "Partial_SourceServicePrincipalAuth.libsonnet",
    "OAuth2": import "Partial_SourceOAuth2Auth.libsonnet",
    "Json": import "Partial_TargetJson.libsonnet",   
};


function(SourceType = "Rest", SourceFormat = "Anonymous",TargetType = "", TargetFormat = "Json")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
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
        "Source",
        "Target"
    ]
}