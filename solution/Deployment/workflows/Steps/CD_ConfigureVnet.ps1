if($env:AdsOpts_CD_Services_Vnet_Enable -eq "True")
{
    ##############################################################################################################
    #Firewall and Virtual Network Rules for Services
    ##############################################################################################################
    Write-Debug " Configuring VNet rules for provisioned services"

    #Enable Service Endpoints on the subnet. Required to be done before adding network rules.
    $result = az network vnet subnet update --resource-group $env:AdsOpts_CD_ResourceGroup_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --name $env:AdsOpts_CD_Services_Vnet_DataSubnetName --service-endpoints Microsoft.Sql Microsoft.Storage Microsoft.KeyVault Microsoft.Web
    Write-Debug " Configured Microsoft.Storage Service Endpoint to subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName"
    
    #adls
    $result = az storage account network-rule add --resource-group $env:AdsOpts_CD_ResourceGroup_Name --account-name $env:AdsOpts_CD_Services_Storage_ADLS_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName 
    $result = az storage account update --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_Storage_ADLS_Name --default-action Deny #Default action to apply when no rule matches i.e. allow access from selected network/PE only.
    Write-Debug " Completed network rule configuration for storage $env:AdsOpts_CD_Services_Storage_ADLS_Name"

    #adlstran
    #Note: Skipping as it will be outside for importing data into it.
    
    #Logging
    #Note: Commented below to allow App Insights access to Storage account.
    # az storage account network-rule add --resource-group $env:AdsOpts_CD_ResourceGroup_Name --account-name $env:AdsOpts_CD_Services_Storage_Logging_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName 
    # az storage account update --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_Storage_Logging_Name --default-action Deny #Default action to apply when no rule matches i.e. allow access from selected network/PE only.
    # Write-Debug " Completed network rule configuration for storage $env:AdsOpts_CD_Services_Storage_Logging_Name"

    #Blob
    $result = az storage account network-rule add --resource-group $env:AdsOpts_CD_ResourceGroup_Name --account-name $env:AdsOpts_CD_Services_Storage_Blob_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName 
    $result = az storage account update --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_Storage_Blob_Name --default-action Deny #Default action to apply when no rule matches i.e. allow access from selected network/PE only.
    Write-Debug " Completed network rule configuration for storage $env:AdsOpts_CD_Services_Storage_Blob_Name"

    #Azure Sql
    #Note: Commenting below as will use the PE for SQL, so vNet rule is not required.
    # az sql server vnet-rule create --server $env:AdsOpts_CD_Services_AzureSQLServer_Name --name $env:AdsOpts_CD_Services_Vnet_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName    
    # Write-Debug " Completed network rule configuration for Azure SQL Server $env:AdsOpts_CD_Services_AzureSQLServer_Name"

    #Key Vault
    #Note: Commenting below as will use the PE for AKV, so vNet rule is not required.
    # az keyvault network-rule add --name $env:AdsOpts_CD_Services_KeyVault_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName
    # az keyvault update --name $env:AdsOpts_CD_Services_KeyVault_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --default-action Deny #Default action to apply when no rule matches i.e. allow access from selected network/PE only.
    # Write-Debug " Completed network rule configuration for Azure Key Vault $env:AdsOpts_CD_Services_KeyVault_Name"

    #Azure Function App
    $result = az appservice plan update --name $env:AdsOpts_CD_Services_AppPlans_FunctionApp_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --sku P1V2 #Upgrade SKU to 'P1V2' to support PE and vNet Integration.
    $result = az functionapp vnet-integration add --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --vnet $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_FuncAppSubnetName
    $result = az functionapp config access-restriction add --priority 100 --rule-name "Allow FuncApp Subnet" --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_FuncAppSubnetName --description "Allow vNet" --action Allow #Configure Access Restrictions.
    $result = az functionapp config access-restriction add --priority 200 --rule-name "Allow Data Subnet" --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName --description "Allow vNet" --action Allow #Configure Access Restrictions.
    $result = az functionapp config access-restriction add --priority 300 --rule-name "Allow WebApp Subnet" --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_WebAppSubnetName --description "Allow vNet" --action Allow #Configure Access Restrictions.
    $result = az functionapp config access-restriction add --priority 400 --rule-name "Allow Azure Portal" --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --service-tag AzurePortal --description "Allow vNet" --action Allow #Configure Access Restrictions.
    $result = az functionapp config access-restriction add --priority 500 --rule-name "Allow ADF" --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --service-tag DataFactory --description "Allow vNet" --action Allow #Configure Access Restrictions.
    Write-Debug " Completed network rule configuration for Azure Function App $env:AdsOpts_CD_Services_CoreFunctionApp_Name"

    #Azure Web App
    $result = az appservice plan update --name $env:AdsOpts_CD_Services_AppPlans_WebApp_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --sku P1V2 #Upgrade SKU to 'P1V2' to support PE.
    $result = az webapp vnet-integration add --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_Website_Name --vnet $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_WebAppSubnetName    
    #Note: Commented below to keep Web App accessible over internet. For customers who have VPN/Express Route/use Bastion -> Uncomment below.
    #az functionapp config access-restriction add --priority 100 --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_Website_Name --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_WebAppSubnetName --description "Allow vNet" --action Allow #Configure Access Restrictions.    
    Write-Debug " Completed network rule configuration for Azure Web App $env:AdsOpts_CD_Services_Website_Name" 
}
else 
{
    Write-Warning "Skipped Configuration of Vnet rules for provisioned services"
}

if($env:AdsOpts_CD_Services_Vnet_Enable -eq "True")
{
    ##############################################################################################################
    #Private Endpoints for Services (ADF Managed and vNet Managed)
    ##############################################################################################################
    Write-Debug " Configuring Private Endpoints for provisioned services"

    ########## ADF Managed PE

    $apiVersion = "2018-06-01"
    
    #$adfId = az datafactory show --factory-name $env:AdsOpts_CD_Services_DataFactory_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query '[id][0]' --output tsv

    #adls (ADF Managed PE)
    $managedPrivateEndpointName = "ADF-Managed-PE-"+$env:AdsOpts_CD_Services_Storage_ADLS_Name
    $privateEndpointResourceId = "$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/managedVirtualNetworks/default/managedprivateendpoints/${managedPrivateEndpointName}"
    $privateLinkResourceId = az storage account show --name $env:AdsOpts_CD_Services_Storage_ADLS_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query '[id][0]' --output tsv
    Write-Debug " Creating $managedPrivateEndpointName"
    New-AzResource -Force -ApiVersion "${apiVersion}" -ResourceId "${privateEndpointResourceId}" -Properties @{
            privateLinkResourceId = "${privateLinkResourceId}"
            groupId = "dfs"            
        }
    Write-Debug " Created $managedPrivateEndpointName"

    #Blob (ADF Managed PE)
    $managedPrivateEndpointName = "ADF-Managed-PE-"+$env:AdsOpts_CD_Services_Storage_Blob_Name
    $privateEndpointResourceId = "$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/managedVirtualNetworks/default/managedprivateendpoints/${managedPrivateEndpointName}"
    $privateLinkResourceId = az storage account show --name $env:AdsOpts_CD_Services_Storage_Blob_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query '[id][0]' --output tsv
    Write-Debug " Creating $managedPrivateEndpointName"
    New-AzResource -Force -ApiVersion "${apiVersion}" -ResourceId "${privateEndpointResourceId}" -Properties @{
            privateLinkResourceId = "${privateLinkResourceId}"
            groupId = "blob"            
        }
    Write-Debug " Created $managedPrivateEndpointName"

    #Note: Commented below to allow On-Prem SHIR to communicate with AKV (Non-VPN,Non-ExpressRoute, Non-Peering scenario)
    # #Key Vault (ADF Managed PE)
    # $managedPrivateEndpointName = "ADF-Managed-PE-"+$env:AdsOpts_CD_Services_KeyVault_Name
    # $privateEndpointResourceId = "$env:AdsOpts_CD_ResourceGroup_Id/providers/Microsoft.DataFactory/factories/$env:AdsOpts_CD_Services_DataFactory_Name/managedVirtualNetworks/default/managedprivateendpoints/${managedPrivateEndpointName}"
    # $privateLinkResourceId = az keyvault show --name $env:AdsOpts_CD_Services_KeyVault_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query '[id][0]' --output tsv
    # Write-Debug " Creating $managedPrivateEndpointName"
    # New-AzResource -Force -ApiVersion "${apiVersion}" -ResourceId "${privateEndpointResourceId}" -Properties @{
    #         privateLinkResourceId = "${privateLinkResourceId}"
    #         groupId = "vault"    
    #     }
    # Write-Debug " Created $managedPrivateEndpointName"

    
    ########## PEs

    #Note: Not using to allow SHIR to communicate with AKV (Non-VPN,Non-ExpressRoute, Peering scenario)
    #Key Vault (vNet Managed PE)
    Write-Debug " Creating PE for Azure Key Vault"
    $PE_Name = "PE-AKV"
    $Private_DNS_Zone_Name = "privatelink.vaultcore.azure.net"
    $id= az keyvault list --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query '[].[id]' --output tsv

    #PE
    $result = az network private-endpoint create `
    --name $PE_Name `
    --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
    --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName `
    --private-connection-resource-id $id `
    --group-id "vault" `
    --connection-name "PE-AKV-Connection"

    #Private DNS Zone
    $result = az network private-dns zone create `
    --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
    --name $Private_DNS_Zone_Name

    $result = az network private-dns link vnet create `
    --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
    --zone-name $Private_DNS_Zone_Name `
    --name "DnsLink-AzKeyVault" `
    --virtual-network $env:AdsOpts_CD_Services_Vnet_Name `
    --registration-enabled false

    $result = az network private-endpoint dns-zone-group create `
   --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
   --endpoint-name $PE_Name `
   --name "AkvZoneGroup" `
   --private-dns-zone $Private_DNS_Zone_Name `
   --zone-name "akv"

    Write-Debug " Completed PE creation for Azure Key Vault"


    #Azure Sql (vNet Managed)
    Write-Debug " Creating PE for Azure SQL Server"
    $PE_Name = "PE-SQL"
    $Private_DNS_Zone_Name = "privatelink.database.windows.net"
    $id= az sql server list --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query '[].[id]' --output tsv

    #PE
    $result = az network private-endpoint create `
    --name $PE_Name `
    --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
    --vnet-name $env:AdsOpts_CD_Services_Vnet_Name --subnet $env:AdsOpts_CD_Services_Vnet_DataSubnetName `
    --private-connection-resource-id $id `
    --group-id "sqlServer" `
    --connection-name "PE-SQL-Connection"

    #Private DNS Zone
    $result = az network private-dns zone create `
    --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
    --name $Private_DNS_Zone_Name

    $result = az network private-dns link vnet create `
    --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
    --zone-name $Private_DNS_Zone_Name `
    --name "DnsLink-AzSQL" `
    --virtual-network $env:AdsOpts_CD_Services_Vnet_Name `
    --registration-enabled false

    $result = az network private-endpoint dns-zone-group create `
   --resource-group $env:AdsOpts_CD_ResourceGroup_Name `
   --endpoint-name $PE_Name `
   --name "SqlZoneGroup" `
   --private-dns-zone $Private_DNS_Zone_Name `
   --zone-name "sql"

    Write-Debug " Completed PE creation for Azure SQL Server"

    ##############################

    #Post PE Addition Task
    $result = az sql server update  --name $env:AdsOpts_CD_Services_AzureSQLServer_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --enable-public-network false #Disable Public Access (Requires PE to be enabled first).
    Write-Debug " Disabled Public Access to Azure SQL"    

    #Enable soft-delete on AKV
    $result = az keyvault update --name $env:AdsOpts_CD_Services_KeyVault_Name --enable-soft-delete true
    Write-Debug " Soft-delete enabled on AKV"

    ##############################
}
else 
{
    Write-Warning "Skipped Configuration of Private Endpoints for provisioned services"
}