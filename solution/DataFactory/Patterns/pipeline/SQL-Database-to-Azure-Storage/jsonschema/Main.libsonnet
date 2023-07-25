local partials = {
   "AzureSqlTable": import "Partial_LoadFromSql.libsonnet",
   "AzureSqlDWTable": import "Partial_LoadFromSql.libsonnet",   
   "SqlServerTable": import "Partial_LoadFromSql.libsonnet",   
   "OracleServerTable": import "Partial_LoadFromSql.libsonnet",   
   "Parquet": import "Partial_LoadIntoParquet.libsonnet",   
};


function(SourceType = "AzureSqlTable", SourceFormat = "",TargetType = "", TargetFormat = "Parquet")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "Source": partials[SourceType](),
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