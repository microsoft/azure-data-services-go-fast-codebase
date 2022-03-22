local commons = import '../../../static/partials/functionapptest_commons.libsonnet';
local vars = import '../../../static/partials/secrets.libsonnet';
function(
    ADFPipeline = "GPL_AzureBlobStorage_ParquetAzureSqlTable_NA",
    Pattern = "Azure Storage to SQL Database",
    TestNumber = "-1",
    SourceFormat = "Azure SQL",
    SourceType = "Azure SQL",
    DataFilename = "SalesLT.Customer.parquet",
    SchemaFileName = "SalesLT.Customer.json",
    SourceSystemAuthType = "MSI",
    SkipLineCount = "",
    FirstRowAsHeader ="FirstRowAsHeader",    
    SheetName = "",
    MaxConcurrentConnections = 0,
    Recursively = "false",
    DeleteAfterCompletion = "",
    TargetFormat = "Parquet",
    TargetType = "Azure Blob", 
    TableSchema,
    TableName,
    StagingTableSchema,
    StagingTableName,
    AutoCreateTable,
    PreCopySQL,
    PostCopySQL,
    AutoGenerateMerge,
    MergeSQL,
    TestDescription = "",
    )
{
    local TaskMasterJson =     
    {
        "Source":{
            "Type": SourceFormat,                       
            "RelativePath": "samples/",
            "DataFileName": DataFilename,
            "SchemaFileName": SchemaFileName,                        
            "MaxConcurrentConnections": MaxConcurrentConnections,
            "Recursively": Recursively,
            "DeleteAfterCompletion": DeleteAfterCompletion,
            } 
            + if (SourceFormat == "Excel") 
            then {"FirstRowAsHeader":FirstRowAsHeader,"SkipLineCount": SkipLineCount,  "SheetName":SheetName}
            else {}
            + if (SourceFormat == "Csv" || SourceFormat == "DelimitedText") 
            then {"SkipLineCount": SkipLineCount, "FirstRowAsHeader":FirstRowAsHeader}
            else {},
            "Target":{
            "Type":TargetFormat,            
            "TableSchema":TableSchema,
            "TableName":TableName+TestNumber,
            "StagingTableSchema":StagingTableSchema,
            "StagingTableName":StagingTableName+TestNumber,
            "AutoCreateTable":AutoCreateTable,
            "PreCopySQL":PreCopySQL,
            "PostCopySQL":PostCopySQL,
            "AutoGenerateMerge":AutoGenerateMerge,
            "MergeSQL":MergeSQL
        }
    },

    local TaskInstanceJson =  
    {
        "SourceRelativePath": "samples/"
    },

    local SourceSystemJson = 
    {
        "Container" : "datalakeraw"       
    },

    local TargetSystemJson = 
    {   
        "Database": if(TargetType == "Azure Synapse") then vars.synapse_sql_pool_name else vars.stagingdb_name,
        "UsernameKeyVaultSecretName":"",
        "PasswordKeyVaultSecretName":""
    },
             
    "TaskInstanceJson":std.manifestJson(TaskInstanceJson),
    "TaskTypeId":-1,
    "TaskType":Pattern,
    "EngineName":vars.datafactory_name,
    "EngineResourceGroup":vars.resource_group_name,
    "EngineSubscriptionId":vars.subscription_id,
    "EngineJson":  "{}",
    "TaskMasterJson":std.manifestJson(TaskMasterJson),       
    "TaskMasterId":TestNumber,
    "SourceSystemId":if(SourceType == "Azure Blob") then -3 else -4,
    "SourceSystemJSON":std.manifestJson(SourceSystemJson),
    "SourceSystemType":SourceType,
    "SourceSystemServer":if(SourceType == "Azure Blob") then "https://" + vars.blobstorage_name + ".blob.core.windows.net" else "https://" + vars.adlsstorage_name + ".dfs.core.windows.net",
    "SourceKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "SourceSystemAuthType":SourceSystemAuthType,
    "SourceSystemSecretName":"",
    "SourceSystemUserName":"",   
    "TargetSystemId":if(TargetType == "Azure Synapse") then -10 else -2,
    "TargetSystemJSON":std.manifestJson(TargetSystemJson),
    "TargetSystemType":TargetType,
    "TargetSystemServer":if(TargetType == "Azure Synapse") then vars.synapse_workspace_name + ".database.windows.net" else vars.sqlserver_name + ".database.windows.net",
    "TargetKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "TargetSystemAuthType":"MSI",
    "TargetSystemSecretName":"",
	"TargetSystemUserName":"",
    "ADFPipeline": ADFPipeline,
    "TestDescription": "[" + TestNumber + "] " +  " " + TestDescription + " of " + DataFilename + " (" + SourceFormat + ") from " + SourceType + " to " + TargetType
}+commons

