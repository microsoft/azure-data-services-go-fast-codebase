local commons = import '../../../static/partials/functionapptest_commons.libsonnet';
local vars = import '../../../static/partials/secrets.libsonnet';
function(
    ADFPipeline = "GPL_AzureSqlTable_NA_AzureBlobStorage_Parquet",
    Pattern = "SQL Database to Azure Storage",
    TestNumber = "-1",
    SourceFormat = "Azure SQL",
    SourceType = "Azure SQL",
    ExtractionSQL = "",
    DataFilename = "SalesLT.Customer.parquet",
    SchemaFileName = "SalesLT.Customer.json",
    SourceSystemAuthType = "MSI",
    TargetFormat = "Parquet",
    TargetType = "Azure Blob", 
    ChunkField = "",
    ChunkSize = 0,
    IncrementalType = "Full",
    TestDescription = "",
    TaskDatafactoryIR = ""
    )
{
    local TaskMasterJson =     
    {
        "Source":{
            "Type": SourceFormat,
            "IncrementalType": IncrementalType,
            "TableSchema": "SalesLT",
            "TableName": "Customer",
            "ExtractionSQL": ExtractionSQL,                   
            "ChunkField":ChunkField,
            "ChunkSize":ChunkSize
        },
        "Target":{
            "Type":TargetFormat,
            "RelativePath":if TargetType == "FileServer" then "c:/Tests/"+Pattern+"/"+TestNumber else "/Tests/"+Pattern+"/"+TestNumber,
            "DataFileName": DataFilename,
            "SchemaFileName": SchemaFileName
        }
    },

    local TaskInstanceJson =  
    {
        "TargetRelativePath": "/Tests/"+Pattern+"/"+TestNumber+"/"
    },

    local SourceSystemJson = 
    {
        "Database": vars.sampledb_name,
        "UsernameKeyVaultSecretName":"",
        "PasswordKeyVaultSecretName":""        
    },

    local TargetSystemJson = 
    {
        "Container" : "datalakeraw" 
    },
             
    "TaskInstanceJson":std.manifestJson(TaskInstanceJson),
    "TaskType":Pattern,
    "TaskTypeId":-3,
    "EngineName":vars.datafactory_name,
    "EngineResourceGroup":vars.resource_group_name,
    "EngineSubscriptionId":vars.subscription_id,
    "EngineJson":  "{}",
    "TaskMasterJson":std.manifestJson(TaskMasterJson),       
    "TaskMasterId":TestNumber,
    "SourceSystemId":if(SourceType == "Azure SQL") then -1 else if(SourceType == "SQL Server") then -14 else -6,
    "SourceSystemJSON":std.manifestJson(SourceSystemJson),
    "SourceSystemType":SourceType,
    "SourceSystemServer":vars.sqlserver_name + ".database.windows.net",
    "SourceKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "SourceSystemAuthType":SourceSystemAuthType,
    "SourceSystemSecretName":"",
    "SourceSystemUserName":"",   
    "TargetSystemId":if(TargetType == "Azure Blob") then -3 else if(TargetType == "FileServer") then -15 else -4,
    "TargetSystemJSON":std.manifestJson(TargetSystemJson),
    "TargetSystemType":TargetType,
    "TargetSystemServer":if(TargetType == "Azure Blob") then "https://" + vars.blobstorage_name + ".blob.core.windows.net" else "https://" + vars.adlsstorage_name + ".dfs.core.windows.net",
    "TargetKeyVaultBaseUrl":"https://" + vars.keyvault_name +".vault.azure.net",
    "TargetSystemAuthType":"MSI",
    "TargetSystemSecretName":"",
	"TargetSystemUserName":"",
    "ADFPipeline": ADFPipeline,
    "TestDescription": "[" + TestNumber + "] " +  " " + TestDescription + " of " + "SalesLT.Customer" + " (" + SourceFormat + ") from " + SourceType + " to " + DataFilename  + " in " + TargetType +  "(" + TargetFormat + ")",
    "TaskDatafactoryIR": if(TaskDatafactoryIR == null) then "Azure" else TaskDatafactoryIR
}+commons

