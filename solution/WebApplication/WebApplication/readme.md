AppSettings Required 

```json

{
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft": "Warning",
      "Microsoft.Hosting.Lifetime": "Information"
    }
  },
  "ApplicationOptions": {
    "UseMSI": false,
    "AdsGoFastTaskMetaDataDatabaseName": "",
    "AdsGoFastTaskMetaDataDatabaseServer": "",
    "ConnectionString": "",
    "AppInsightsWorkspaceId": ""
  },
  "AllowedHosts": "*",
  //Azure Ad credentials are used by all downstream service connections by application, you should remove the Client Secret and use MSI for production deployments. 
  "AzureAd": {
    "Instance": "https://login.microsoftonline.com/",
    "Domain": "",
    "TenantId": "",
    "ClientId": "",
    "ClientSecret": "",
    "CallbackPath": "/signin-oidc",
    "SignedOutCallbackPath ": "/signout-callback-oidc"
  },
  //Azure Ad Auth Object used ONLY to authenticate user. This is NOT used for downstream service connections by application. 
  "AzureAdAuth": {
    "Instance": "https://login.microsoftonline.com/",
    "Domain": "",
    "TenantId": "",
    "ClientId": "",
    "CallbackPath": "/signin-oidc",
    "SignedOutCallbackPath ": "/signout-callback-oidc"
  },
  "ConnectionStrings": {
    "AzureWebJobsStorage": "UseDevelopmentStorage=true"
  },
  "ApplicationInsights": {
    "ConnectionString": ""
  },
  "SecurityModelOptions": {
    "SecurityRoles": {
      "Administrator": {
        "SecurityGroupId": "",
        "UserOverideList": null, //Optional Array of Users that you would like to push into the group rather than set the application up to read from the Graph API.
        "AllowActions": [ "*" ]
      },
      "Analyst": {
        "SecurityGroupId": "",
        "AllowActions": [
          "Dashboard",
          "Wizards.ExternalFileUpload",
          "Wizards.PIAWizard*",
          "SubjectArea.Create"
        ]
      },
      "Reader": {
        "SecurityGroupId": "",
        "AllowActions": [
          "ADFActivityErrors",
          "ADFPipelineStats",
          "AFExecutionSummary",
          "AFLogMonitor",
          "AFExecutionSummary",
          "Dashboard",
          "TaskType._Reader",
          "TaskTypeMapping._Reader",
          "SubjectArea.RequestAccess",
          "SubjectArea.Browse",
          "SubjectArea.GetGridOptionsBrowse",
          "SubjectArea.GetGridDataBrowse",

          // data insensitive actions
          "Wizards.AddDataSteward",
          "Wizards.RemoveDataSteward",
          "Help"
        ]
      },
      "PlatformManager": {
        "SecurityGroupId": "",
        "AllowActions": [
          "Wizards.PIASummary",

          //then *everything* else
          "ADFActivityErrors",
          "ADFPipelineStats",
          "AFExecutionSummary",
          "AFLogMonitor",
          "AFExecutionSummary",
          "Dashboard",
          "TaskType.*",
          "TaskTypeMapping.*",
          "SubjectArea",
          "ScheduleMaster",
          "ScheduleInstance",
          "SubjectArea",
          "TaskGroup",
          "TaskInstance",
          "TaskMaster",
          "TaskMasterWaterMark"
        ]
      },
      "DataAdministrator": {
        "SecurityGroupId": "",
        "AllowActions": [
          "*._Reader",
          "SubjectArea.*",
          "Wizards.PIA*"
        ]
      },
      "PipelineAdministrator": {
        "SecurityGroupId": "",
        "AllowActions": [
          "ScheduleMaster._Reader",
          "ScheduleMaster._Writer",
          "ScheduleInstance._Reader",
          "ScheduleInstance._Writer",
          "SubjectArea._Reader",
          "SubjectAreaForm._Reader",
          "TaskGroup._Reader",
          "TaskGroupDependency._Reader",
          "TaskInstance._Reader",
          "TaskInstance._Writer",
          "TaskInstance.UpdateTaskInstanceStatus",
          "TaskInstanceExecution._Reader",
          "TaskMaster._Reader",
          "TaskMaster._Writer",
          "TaskMaster.UpdateTaskMasterActiveYN",
          "TaskMasterWaterMark._Reader",
          "Wizards.PIASummary"
        ]
      },
      "SubjectAreaReader": {
        "IsSubjectAreaScoped": true,
        "AllowActions": [
          "ScheduleMaster._Reader",
          "ScheduleInstance._Reader",
          "SubjectArea._Reader",
          "TaskGroup._Reader",
          "TaskGroupDependency._Reader",
          "TaskInstance._Reader",
          "TaskInstanceExecution._Reader",
          "TaskMaster._Reader",
          "TaskMasterWaterMark._Reader",
          "Wizards.PIASummary"
        ]
      },
      "SubjectAreaCustodian": {
        "IsSubjectAreaScoped": true,
        "AllowActions": [
          "ScheduleMaster._Reader",
          "ScheduleInstance._Reader",
          "SubjectArea._Reader",
          "TaskGroup._Reader",
          "TaskGroupDependency._Reader",
          "TaskInstance._Reader",
          "TaskInstanceExecution._Reader",
          "TaskMaster._Reader",
          "TaskMasterWaterMark._Reader",
          "Wizards.PIASummary"
        ]
      },
      "SubjectAreaSteward": {
        "IsSubjectAreaScoped": true,
        "AllowActions": [
          "ScheduleMaster._Reader",
          "ScheduleInstance._Reader",
          "SubjectArea._Reader",
          "TaskGroup._Reader",
          "TaskGroupDependency._Reader",
          "TaskInstance._Reader",
          "TaskInstanceExecution._Reader",
          "TaskMaster._Reader",
          "TaskMasterWaterMark._Reader",

          //edit PIA
          "SubjectArea._Writer",
          "SubjectArea.Publish",
          "SubjectArea.Revise",
          "Wizards.PIAWizard*",
          "Wizards.PIASummary",

          //approve requestes
          "AccessRequests.*",

          //edit tasks
          "TaskMaster.UpdateTaskMasterActiveYN",
          "TaskInstance.UpdateTaskInstanceStatus"
        ]
      },
      "SubjectAreaOwner": {
        "IsSubjectAreaScoped": true,
        "AllowActions": [
          "AccessRequests.*",
          "ScheduleMaster.*",
          "ScheduleInstance.*",
          "SubjectArea.*",
          "TaskGroup.*",
          "TaskGroupDependency.*",
          "TaskInstance.*",
          "TaskInstanceExecution.*",
          "TaskMaster.*",
          "TaskMasterWaterMark.*",
          "Wizards.PIA*"
        ]
      }
    },
    // these are a shortcut that can be referred to with the placeholder _Reader 
    "ReaderActions": [
      "IndexDataTable",
      "Get*",
      "Details"
    ],
    // these are a shortcut that can be referred to with the placeholder _Writer
    "WriterActions": [
      "Copy*",
      "Update*",
      "Create*",
      "Edit*",
      "Delete*"
    ],
    "GlobalAllowActions": [
      "Home.Error",
      "Home.AccessDenied"
    ],
    //Deny globally - cannot be overidden
    "GlobalDenyActions": [
      "*.Delete",
      "SubjectAreaForm"
    ]
  }
}

  
```