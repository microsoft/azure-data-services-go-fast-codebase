function (SourceType = "AzureBlobFS")
if (SourceType == "AzureBlobFS") then
{
    "TaskObject": {
        "type": "object",
        "defaultValue": "[[,   {     \"TaskInstanceId\": 2,     \"TaskMasterId\": 1,     \"TaskStatus\": \"Untried\",     \"TaskType\": \"AzureStorageToAzureStorage_IRA\",     \"Enabled\": true,     \"ExecutionUid\": 1,     \"KeyVaultBaseUrl\": \"https://adsgofastkeyvault.vault.azure.net/\",     \"Source\": {       \"StorageAccountName\": \"https://adsgofastdatalakeadls.dfs.core.windows.net\",       \"Type\": \"ADLS\",       \"StorageAccountContainer\": \"datalakelanding\",       \"StorageAccountAccessMethod\": \"MSI\",       \"StorageAccountSASUriKeyVaultSecretName\": null,       \"RelativePath\": \"/Unprocessed/adsgofastdatakakeaccelsqlsvr/AWSample/SalesLT/2020/06/08/17/\",       \"DataFileName\": \"Customer_Data.parquet\",       \"SchemaFileName\": \"Customer_Schema.json\"     },     \"Target\": {       \"StorageAccountName\": \"https://adsgofastdatalakeadls.dfs.core.windows.net\",       \"Type\": \"ADLS\",       \"StorageAccountContainer\": \"datalakelanding\",       \"StorageAccountAccessMethod\": \"MSI\",       \"StorageAccountSASUriKeyVaultSecretName\": null,       \"RelativePath\": \"/Processed/adsgofastdatakakeaccelsqlsvr/AWSample/SalesLT/2020/06/08/17/\",       \"DataFileName\": \"Customer_Data.parquet\",       \"SchemaFileName\": \"Customer_Schema.json\"     },     \"DataFactory\": {       \"Id\": 1,       \"Name\": \"adsgofastdatakakeacceladf\",       \"ResourceGroup\": \"AdsGoFastDataLakeAccel\",       \"SubscriptionId\": \"035a1364-f00d-48e2-b582-4fe125905ee3\",     }   } ]]"
    }
}
else
{ }