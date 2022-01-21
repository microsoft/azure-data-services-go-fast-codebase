local commons = import '../../../static/partials/functionapptest_commons.libsonnet';
local vars = import '../../../static/partials/secrets.libsonnet';
function(
    ADFPipeline = "GPL_AzureBlobStorage_ParquetAzureSqlTable_NA_IRA",
    Pattern = "Azure Storage to SQL Database",
    TestNumber = "1",
    SourceFormat = "Azure SQL",
    SourceType = "Azure SQL",
    DataFilename = "SalesLT.Customer.parquet",
    SchemaFileName = "SalesLT.Customer.json",
    SourceSystemAuthType = "MSI",
    SkipLineCount = "",
    FirstRowAsHeader ="FirstRowAsHeader",    
    SheetName = "",
    MaxConcorrentConnections = 0,
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
    MergeSQL
    )
{
    local TaskMasterJson =     
    {
        "Source":{
            "Type": SourceFormat,                       
            "RelativePath": "samples/",
            "DataFileName": DataFilename,
            "SchemaFileName": SchemaFileName,
            "SkipLineCount": SkipLineCount,
            "FirstRowAsHeader":FirstRowAsHeader,
            "SheetName":SheetName,
            "MaxConcorrentConnections": MaxConcorrentConnections,
            "Recursively": Recursively,
            "DeleteAfterCompletion": DeleteAfterCompletion,
        },
        "Target":{
            "Type":TargetFormat,
            "DataFileName": DataFilename,
            "SchemaFileName": SchemaFileName,
            "TableSchema":TableSchema,
            "TableName":TableName+TestNumber,
            "StagingTableSchema":StagingTableSchema,
            "StagingTableName":StagingTableName+TestNumber,
            "AutoCreateTable":AutoCreateTable,
            "PreCopySQL":PreCopySQL,
            "PostCopySQL":PostCopySQL,
            "AutoGenerateMerge":AutoGenerateMerge,
            "MergeSQL":MergeSQL,
            "DynamicMapping":{}
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
        "Database": vars.stagingdb_name,
        "UsernameKeyVaultSecretName":"",
        "PasswordKeyVaultSecretName":""
    },
             
    "TaskInstanceJson":std.manifestJson(TaskInstanceJson),
    "TaskTypeId":1,
    "TaskType":Pattern,
    "DataFactoryName":vars.datafactory_name,
    "DataFactoryResourceGroup":vars.resource_group_name,
    "DataFactorySubscriptionId":vars.subscription_id,
    "TaskMasterJson":std.manifestJson(TaskMasterJson),       
    "TaskMasterId":TestNumber,
    "SourceSystemId":if(SourceType == "Azure Blob") then 3 else 4,
    "SourceSystemJSON":std.manifestJson(SourceSystemJson),
    "SourceSystemType":SourceType,
    "SourceSystemServer":if(SourceType == "Azure Blob") then "https://" + vars.blobstorage_name + ".blob.core.windows.net" else "https://" + vars.adlsstorage_name + ".dfs.core.windows.net",
    "SourceKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "SourceSystemAuthType":SourceSystemAuthType,
    "SourceSystemSecretName":"",
    "SourceSystemUserName":"",   
    "TargetSystemId":if(TargetType == "Azure Synapse") then 10 else 2,
    "TargetSystemJSON":std.manifestJson(TargetSystemJson),
    "TargetSystemType":TargetType,
    "TargetSystemServer":vars.sqlserver_name + ".database.windows.net",
    "TargetKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "TargetSystemAuthType":"MSI",
    "TargetSystemSecretName":"",
	"TargetSystemUserName":"",
    "ADFPipeline": ADFPipeline
}+commons

