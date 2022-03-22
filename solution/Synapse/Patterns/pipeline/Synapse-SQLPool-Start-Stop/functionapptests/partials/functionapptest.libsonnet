local commons = import '../../../static/partials/functionapptest_commons.libsonnet';
local vars = import '../../../static/partials/secrets.libsonnet';
function(
    SynapsePipeline = "GPL_AzureBlobStorage_ParquetAzureSqlTable_NA",
    Pattern = "Synapse SQL Pool Start/Stop",
    TestNumber = "-1",
    SourceFormat = "N/A",
    SourceType = "Non-Applicable",
    SourceDataFilename = "",
    SourceSchemaFileName = "",
    SourceSystemAuthType = "MSI",
    SourceSkipLineCount = "",
    SourceFirstRowAsHeader ="",    
    SourceSheetName = "",
    SourceMaxConcurrentConnections = 0,
    SourceRecursively = "false",
    SourceDeleteAfterCompletion = "",
    TargetFormat = "N/A",
    TargetType = "Non-Applicable",
    TargetDataFilename = "",
    TargetSchemaFileName = "",
    TargetSystemAuthType = "MSI",
    TargetSkipLineCount = "",
    TargetFirstRowAsHeader ="",    
    TargetSheetName = "",
    TargetMaxConcurrentConnections = 0,
    TargetRecursively = "false",
    TargetDeleteAfterCompletion = "",
    TestDescription = "",
    SQLPoolName = "",
    SQLPoolOperation = ""
    )
{
    local TaskMasterJson =     
    {
        "SQLPoolName": SQLPoolName,
        "SQLPoolOperation": SQLPoolOperation,
        "Source":{
            "Type": SourceFormat,                       
            "RelativePath": "",
            "DataFileName": SourceDataFilename,
            "SchemaFileName": SourceSchemaFileName,
            "MaxConcurrentConnections": SourceMaxConcurrentConnections,
            "Recursively": SourceRecursively,
            "DeleteAfterCompletion": SourceDeleteAfterCompletion,
            
        },

        "Target":{
            "Type":TargetFormat,
            "RelativePath":"",
            "DataFileName": TargetDataFilename,
            "SchemaFileName": TargetSchemaFileName,            
            "MaxConcurrentConnections": TargetMaxConcurrentConnections,
            "Recursively": TargetRecursively,
            "DeleteAfterCompletion": TargetDeleteAfterCompletion
        },
    },

    local TaskInstanceJson =  
    {
        
    },

    local SourceSystemJson = 
    {
            
    },

    local TargetSystemJson = 
    {   
         
    },
             
    "TaskInstanceJson":std.manifestJson(TaskInstanceJson),
    "TaskTypeId":-6,
    "TaskType":Pattern,
    "EngineName":vars.datafactory_name,
    "EngineResourceGroup":vars.resource_group_name,
    "EngineSubscriptionId":vars.subscription_id,
    "EngineJson":  '{"endpoint": "https://' + vars.synapse_workspace_name + '.dev.azuresynapse.net", "DeltaProcessingNotebook": "DeltaProcessingNotebook"}',
    "TaskMasterJson":std.manifestJson(TaskMasterJson),       
    "TaskMasterId":TestNumber,
    "SourceSystemId": -16,
    "SourceSystemJSON":std.manifestJson(SourceSystemJson),
    "SourceSystemType":SourceType,
    "SourceSystemServer":"N/A",
    "SourceKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "SourceSystemAuthType":SourceSystemAuthType,
    "SourceSystemSecretName":"",
    "SourceSystemUserName":"",   
    "TargetSystemId": -10,
    "TargetSystemJSON":std.manifestJson(TargetSystemJson),
    "TargetSystemType":TargetType,
    "TargetSystemServer":"N/A",
    "TargetKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "TargetSystemAuthType":TargetSystemAuthType,
    "TargetSystemSecretName":"",
	"TargetSystemUserName":"",
    "SynapsePipeline": SynapsePipeline,
    "TestDescription": "[" + TestNumber + "] " +  " SQL Dedicated Pool " + SQLPoolOperation + " execution test." 
}+commons

