    $subid = (az account show -s $env:AdsOpts_CD_ResourceGroup_Subscription | ConvertFrom-Json).id
    $basescope = "/subscriptions/$subid/resourceGroups/$env:AdsOpts_CD_ResourceGroup_Name/providers"
    $DataFactoryId = az ad sp list --display-name $env:AdsOpts_CD_Services_DataFactory_Name --output tsv --query "[].{id:objectId}"
    $AzureFunctionId = ((az webapp identity show --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name) | ConvertFrom-Json).principalId
    $DeploymentSpId =  (az ad sp list --filter "displayname eq '$env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Name'" | ConvertFrom-Json).appId
    $WebAppID = ((az webapp identity show --resource-group  $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_WebSite_Name) | ConvertFrom-Json).principalId 
    $AADUserId = (az ad signed-in-user show | ConvertFrom-Json).objectId
    
    #RBAC Rights
    # MSI Access from Azure Function to ADF
    $result = az role assignment create --assignee $AzureFunctionId --role "Contributor" --scope "$basescope/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name"
    # Deployment Principal to ADF
    $result = az role assignment create --assignee $DeploymentSpId --role "Contributor" --scope "$basescope/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name"

    # MSI Access from Azure Function to ADF Log Analytics
    $result = az role assignment create --assignee $AzureFunctionId --role "Contributor" --scope "$basescope/microsoft.operationalinsights/workspaces/$env:AdsOpts_CD_Services_LogAnalytics_Name"
    # MSI Access from AF to ADLS Gen2
    $result = az role assignment create --assignee $AzureFunctionId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLS_Name"
    # MSI Access from AF to Blob Gen2
    $result = az role assignment create --assignee $AzureFunctionId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_Blob_Name"
    
    # MSI Access from ADF to ADLS Gen2
    $result = az role assignment create --assignee $DataFactoryId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLS_Name"

    # MSI Access from ADF to Blob
    $result = az role assignment create --assignee $DataFactoryId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_Blob_Name"

    # MSI Access from ADF to KeyVault
    $result = az keyvault set-policy --name $env:AdsOpts_CD_Services_KeyVault_Name --object-id $DataFactoryId --certificate-permissions get list --key-permissions get list --resource-group $env:AdsOpts_CD_ResourceGroup_Name --secret-permissions get list --subscription $subid
    # MSI Access from WebApp to ADLS Gen2 
    $result = az role assignment create --assignee $WebAppID --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLS_Name"
    # MSI Access from WebApp to ADF Log Analytics
    $result = az role assignment create --assignee $WebAppID --role "Contributor" --scope "$basescope/microsoft.operationalinsights/workspaces/$env:AdsOpts_CD_Services_LogAnalytics_Name"
    # MSI Access from WebApp to ADF App Insights
    $result = az role assignment create --assignee $WebAppID --role "Contributor" --scope "$basescope/microsoft.insights/components/$env:AdsOpts_CD_Services_AppInsights_Name"
    # AAD User Access to ADLS Gen2 - to upload sample data files
    $result = az role assignment create --assignee $AADUserId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLS_Name"
    $result = az role assignment create --assignee $AADUserId --role "Owner" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLS_Name"
  

#Transient Storage Account
if($env:AdsOpts_CD_Services_Storage_ADLSTransient_Enable -eq "True")
{
    Write-Debug " Granting RBAC on Transient Storage Account (ADLS)"
    
    # MSI Access from AF to ADLS Gen2
    $result = az role assignment create --assignee $AzureFunctionId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLSTransient_Name"

    # MSI Access from ADF to ADLS Gen2
    $result = az role assignment create --assignee $DataFactoryId --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLSTransient_Name"

    # MSI Access from WebApp to ADLS Gen2 
    $result = az role assignment create --assignee $WebAppID --role "Storage Blob Data Contributor" --scope "$basescope/Microsoft.Storage/storageAccounts/$env:AdsOpts_CD_Services_Storage_ADLSTransient_Name"
}
else 
{
    Write-Warning "Skipped RBAC on Transient Storage Account (ADLS)"
}