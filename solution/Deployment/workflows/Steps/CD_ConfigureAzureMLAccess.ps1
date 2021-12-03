#BLOCKER: Due to az ml cli not yet allowing to retrieve the MI object id of AzureML Workspace (MI enabled workspace).
#Workaround: Perform RBAC from portal

Write-Host "Perform 'PE creation' and 'Storage Blob Data Contributor' on storage account from portal for AzureML MI."
exit

#TO DO:
#1.Create PE from Azure ML subnet to:  (az cli + PS) - TBD
#   a. ADS GF adls gen2 storage account
#4. Grant Azure ML workspace managed identity access to your Azure Data Lake Storage Gen2. - TBD 
#   a. ADS GF adls gen2 storage account

#Azure ML Workspace 
#TO DO: Update the code below to use Environment Variables instead of hardcoding, pending as awaiting finalisation of changes to environment.json
$AzureMLConfiguration_Enable = "True"

$ADSGF_ADLS_ResourceGroup_Name = "AdsTestRG1"
$ADSGF_ADLS_Name = "adlshqimtuiyyaomx"

$AzureML_ResourceGroup_Name = "rg-name"
$AzureML_Workspace_Name = "aml-workspace-1"

Read-Host "Please install latest az cli and then run 'az extension remove -n azure-cli-ml'. Once done press enter to continue."
Read-Host "Please install az cli extension by running 'az extension add --name ml'. Once done press enter to continue."



# if($env:AdsOpts_CD_Services_AzureML_Enable -eq "True")
if($AzureMLConfiguration_Enable -eq "True")
{
    Write-Host "Configuring PE to Azure Storage from Azure ML Workspace subnet."
    
    #ADS GF adls storage account resource id
    $resource_id_adls = az storage account show -g $ADSGF_ADLS_ResourceGroup_Name -n $ADSGF_ADLS_Name --query '[id][0]' --output tsv

    #PE part pending .....
    
    Read-Host "Please go to storage account -> Networking -> Private Endpoints and approve the new PE (Azure ML) pending request. Please press enter once done."
}
else 
{
    Write-Host "Skipped Configuration of Synapse Workspace."
}

#Grant Azure ML workspace service "managed identity" access to your Azure Data Lake Storage Gen2.
# if($env:AdsOpts_CD_Services_AzureML_Enable -eq "True")
if($AzureMLConfiguration_Enable -eq "True")
{
    Write-Host "Setting AzureML RBAC (BLOB Data Contributor) on ADSGF adls storage."   

    #Synapse resource id (Does not work, requires MI object id)
    # $resource_id_synapse = az synapse workspace show -g $Synapse_ResourceGroup_Name -n $Synapse_Workspace_Name --query '[id][0]' --output tsv

    #AzureML Workspace Id (/subscriptions/xxxxxxx/resourceGroups/xxxxxxx/...)
    # $id_azureml = az ml workspace show -g $AzureML_ResourceGroup_Name -n $AzureML_Workspace_Name --query '[id]' --output tsv
    $id_azureml = az ml workspace show -g $AzureML_ResourceGroup_Name -n $AzureML_Workspace_Name --query '[id][0]'
    $id_azureml = $id_azureml.replace('"','') #To Remove the double quotes ("))
    $id_azureml = $id_azureml.replace("azureml:/","/") #To Remove the "azureml:" prefix

    #AzureML Workspace Managed Identity Object Id (**BLOCKED HERE)
    $mi_objectid_azureml = az ad sp list --query "[?alternativeNames == '$id_azureml'].[objectId]" --filter "displayname eq '$AzureML_Workspace_Name'" --output tsv    
    $mi_objectid_azureml = az ad sp list --filter "displayname eq '$AzureML_Workspace_Name' && alternativeNames[1] eq '$id_azureml'" --output tsv    
    
    
    #ADS GF adls storage account resource id
    $resource_id_adls = az storage account show -g $ADSGF_ADLS_ResourceGroup_Name -n $ADSGF_ADLS_Name --query '[id][0]' --output tsv

    # MSI Access from AzureML Workspace to ADLS Gen2    
    az role assignment create --assignee $id_azureml --role "Storage Blob Data Contributor" --scope $resource_id_adls    
}
else 
{
    Write-Host "Skipped setting AzureML RBAC on ADSGF adls storage."    
}

#############################
#Temp (Remove post testing)
# az ad sp list --query `
# "[?alternativeNames[1] == '/subscriptions/273ef1a8-c002-4acf-8ce6-829e2401ec4f/resourcegroups/rg-pta/providers/Microsoft.MachineLearningServices/workspaces/aml-workspace-01'].[objectId]" `
# --filter "displayname eq '$AzureML_Workspace_Name'" --output tsv

# az ad sp list --query `
# "[?alternativeNames[1] == '$id_azureml'].[objectId]" `
# --filter "displayname eq '$AzureML_Workspace_Name'" --output tsv

# az ad sp list --filter "alternativeNames[1] == '$id_azureml'" --output tsv
#############################