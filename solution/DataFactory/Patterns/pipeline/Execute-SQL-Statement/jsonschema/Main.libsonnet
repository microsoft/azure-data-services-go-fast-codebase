local partials = {
   "AzureSqlTable": import "Partial_LoadFromSql.libsonnet",
   "SqlServerTable": import "Partial_LoadFromSql.libsonnet",      
   "AzureSqlDWTable": import "Partial_LoadFromSql.libsonnet"
};


function(SourceType = "AzureSqlTable", SourceFormat = "",TargetType = "", TargetFormat = "")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "Source": partials[SourceType](),
        "Target": partials[SourceType](),
        "SQLStatement": {
            "type": "string",            
            "options": {
                "infoText": "(required) SQL Statement/s to Execute. NOTE the last statement MUST return at least one row.",
                "inputAttributes": {
                    "placeholder": "eg. Exec StoredProcedure1; Select 1;"
                }               
            }
        },
        "QueryTimeout": {
            "type": "string",            
            "options": {
                "infoText": "(required) Timeout in the form hh:MM:ss. Eg. 2 hours would be 02:00:00",
                "inputAttributes": {
                    "placeholder": "eg. 02:00:00"
                }  
            }, 
            "default":"02:00:00"
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
        "Source",
        "Target",
        "SQLStatement",
        "QueryTimeout"
    ]
}