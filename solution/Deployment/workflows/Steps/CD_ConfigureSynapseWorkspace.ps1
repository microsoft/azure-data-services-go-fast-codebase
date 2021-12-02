#TO DO:
#1.Deploy Synapse ARM (Workspace, Storage, Dedicated Pool, Spark Pool) (ARM + PS) - DONE [CD_DeploySynapseWorkspace.ps1]
#2.To allow secured storage a/c acces from workspace, under storage a/c networking, allow Synapse Workspace under Resource instances (MANUAL from Portal) - PENDING as az cli support is not yet available
#   a. workspace's storage a/c
#   b. Any other secured storage a/c e.g. adls 
#3.Create a Synapse Managed PE to:  (az cli + PS) - DONE [CD_ConfigureSynapseWorkspace.ps1]
#   a. ADS GF adls gen2 storage account
#4. Grant workspace service managed identity access to your Azure Data Lake Storage Gen2. - DONE [CD_ConfigureSynapseWorkspace.ps1]
#   a. ADS GF adls gen2 storage account

#Synapse Workspace 

$Synapse_ResourceGroup_Name = $env:AdsOpts_CD_ResourceGroup_Name #Specify resource group here if needs to be deployed to resource group other than ADS GF


if($env:AdsOpts_CD_Services_Synapse_Enable -eq "True")
{
    Write-Host "Action: To allow secured storage a/c acces from Synapse workspace, please allow Synapse Workspace under Resource instances within under storage a/c networking tab of adls storage accounts. "
    Read-Host "Continue to next step once the above action is done"

    Write-Host "Configuring Synapse Workspace. Requires az version >=2.30.0 (https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?tabs=azure-cli)"
    
    #ADS GF adls storage account resource id
    $resource_id_adls = az storage account show -g $env:AdsOpts_CD_ResourceGroup_Name -n $env:AdsOpts_CD_Services_Storage_ADLS_Name --query '[id][0]' --output tsv

    az synapse managed-private-endpoints create --workspace-name $env:AdsOpts_CD_Services_Synapse_Name `
    --pe-name "synapse-ws-adgf-adls" `
    --resource-id $resource_id_adls `
    --group-Id "dfs"

    Read-Host "Please go to storage account -> Networking -> Private Endpoints and approve the new PE pending request. Please press enter once done."
}
else 
{
    Write-Host "Skipped Configuration of Synapse Workspace."
}

#Grant workspace service "managed identity" access to your Azure Data Lake Storage Gen2.
if($env:AdsOpts_CD_Services_Synapse_Enable -eq "True")
{
    Write-Host "Setting RBAC (BLOB Data Contributor) on ADSGF adls storage."   

    #Synapse resource id (Does not work, requires MI object id)
    # $resource_id_synapse = az synapse workspace show -g $Synapse_ResourceGroup_Name -n $env:AdsOpts_CD_Services_Synapse_Name --query '[id][0]' --output tsv

    #Synapse Managed Identity Object Id
    $mi_objectid_synapse = az synapse workspace show -g $Synapse_ResourceGroup_Name -n $env:AdsOpts_CD_Services_Synapse_Name --query '[identity.principalId]' --output tsv

    #ADS GF adls storage account resource id
    $resource_id_adls = az storage account show -g $env:AdsOpts_CD_ResourceGroup_Name -n $env:AdsOpts_CD_Services_Storage_ADLS_Name --query '[id][0]' --output tsv

    # MSI Access from Synapse to ADLS Gen2    
    az role assignment create --assignee $mi_objectid_synapse --role "Storage Blob Data Contributor" --scope $resource_id_adls    
}
else 
{
    Write-Host "Skipped setting RBAC on ADSGF adls storage."    
}