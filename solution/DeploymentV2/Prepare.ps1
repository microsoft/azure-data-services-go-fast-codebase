# ------------------------------------------------------------------------------------------------------------
# You must be logged into the Azure CLI to run this script
# ------------------------------------------------------------------------------------------------------------
# 
# The purpose of this script is to set your Azure environment ready for the deployment
# - This should be run once per environment.
# - To run it, provide the request parameters
# - resource group name to be created. If you skip this, only the providers will be registered
# - storage account name to store your terraform state. If you skip this, no storage account will be created
# 
# At the end of the execution, you will be provided the outputs from the preparation steps.
# These are pre-loaded into environment variables so that you can directly run the ./Deploy.ps1 script
# to create a new environment using local terraform state. 
# 
# To save you double handling and finding them later, I recommend that you copy them down and update
# the values directly into the following file:
#
# /azure-data-services-go-fast-codebase/solution/Deployment/terraform/vars/local/terragrunt.hcl
#
# This file is used by the ./Deploy.ps1 script by default and will be used if no enviroment vars are available
#
# Once this script has finished, you then run Deploy.ps1 to create your environment
# ------------------------------------------------------------------------------------------------------------

$env:TF_VAR_resource_group_name = Read-Host "Enter the name of the resource group to create (enter to skip)"
$env:TF_VAR_storage_account_name = Read-Host "Enter a unique name for the terraform state storage account (enter to skip)"
$CONTAINER_NAME="tstate"

# ------------------------------------------------------------------------------------------------------------
# Ensure that you have all of the require Azure resource providers enabled before you begin deploying the solution.
# ------------------------------------------------------------------------------------------------------------
$providers = @('Microsoft.Storage',
'Microsoft.Network',
'Microsoft.Web',
'microsoft.insights',
'Microsoft.ManagedIdentity',
'Microsoft.KeyVault',
'Microsoft.OperationalInsights',
'Microsoft.Purview',
'Microsoft.EventHub',
'Microsoft.Compute',
'Microsoft.PolicyInsights')

$progress = 0
Write-Progress -Activity "Registering Azure Resource Providers" -Status "${progress}% Complete:" -PercentComplete $progress

ForEach ($provider in $providers) {
    $progress += 5;
    az provider register --namespace $provider
    Write-Progress -Activity "Registering Azure Resource Providers" -Status "${progress}% Complete:" -PercentComplete $progress
}

# ------------------------------------------------------------------------------------------------------------
# Save the current tenant/sub details for use bt TF later
# ------------------------------------------------------------------------------------------------------------
$currentAccount = az account show | ConvertFrom-Json
$env:TF_VAR_tenant_id = $currentAccount.tenantId
$env:TF_VAR_subscription_id = $currentAccount.id
$env:TF_VAR_ip_address = (Invoke-WebRequest ifconfig.me/ip).Content

$env:TF_VAR_domain = az account show --query 'user.name' | cut -d '@' -f 2 | sed 's/\"//'

#------------------------------------------------------------------------------------------------------------
# Create the resource group and terraform state store 
#------------------------------------------------------------------------------------------------------------
# Note that this will create the account without any firewall rules. Depending on your environment
# You will potentially want to connect this to a Vnet via private link, Deny public internet access
# and restrict it so that only GitHub / AzDO can access it.
#------------------------------------------------------------------------------------------------------------
if($env:TF_VAR_resource_group_name -ne "") {
    Write-Progress -Activity "Creating Resource Group" -Status "${progress}% Complete:" -PercentComplete $progress 
    $rg = az group create -n $env:TF_VAR_resource_group_name -l australiaeast

    if($env:TF_VAR_storage_account_name -ne "") {
        $progress+=10
        Write-Progress -Activity "Creating Storage Account" -Status "${progress}% Complete:" -PercentComplete $progress
        $storageId = az storage account create --resource-group $env:TF_VAR_resource_group_name --name $env:TF_VAR_storage_account_name --sku Standard_LRS --allow-blob-public-access false --https-only true --min-tls-version TLS1_2 --query id -o tsv

        $progress+=10
        $userObjectId = az ad signed-in-user show --query objectId -o tsv
        Write-Progress -Activity "Assigning Blob Contributor" -Status "${progress}% Complete:" -PercentComplete $progress
        $assignment = az role assignment create --role "Storage Blob Data Contributor" --assignee-object-id $userObjectId --assignee-principal-type User

        $progress+=10
        Write-Progress -Activity "Creating State Container" -Status "${progress}% Complete:" -PercentComplete $progress
        $container = az storage container create --name $CONTAINER_NAME --account-name $env:TF_VAR_storage_account_name --auth-mode login

        Write-Progress -Activity "Finished" -Completed 
    }

}
#------------------------------------------------------------------------------------------------------------
# Print pretty output for user
#------------------------------------------------------------------------------------------------------------
Write-Host " ";
Write-Host "Completed preparing subscription" -ForegroundColor green
Write-Host " ";
Write-Host "Tenant: " -NoNewline -ForegroundColor green
Write-Host "$($currentAccount.tenantId)";
Write-Host "Subscription: " -NoNewline -ForegroundColor green
Write-Host "$($currentAccount.name) " -NoNewline
Write-Host "$($currentAccount.id)"  -ForegroundColor yellow

if($env:TF_VAR_resource_group_name -ne "") {
    Write-Host "Resource Group: " -NoNewline -ForegroundColor green
    Write-Host "'${env:TF_VAR_resource_group_name}'";
}
if($env:TF_VAR_storage_account_name -ne "") {
    Write-Host "Storage Account: " -NoNewline -ForegroundColor green
    Write-Host "${env:TF_VAR_storage_account_name}";
    Write-Host "Storage Account Container: " -NoNewline -ForegroundColor green
    Write-Host "${CONTAINER_NAME}";    
}
Write-Host "The following terraform environment variables have been set:";
Write-Host " - resource_group_name = " -NoNewline -ForegroundColor green
Write-Host "${env:TF_VAR_resource_group_name}";
Write-Host " - storage_account_name = " -NoNewline -ForegroundColor green
Write-Host "${env:TF_VAR_storage_account_name}";
Write-Host " - subscription_id = " -NoNewline -ForegroundColor green
Write-Host "${env:TF_VAR_subscription_id}";
Write-Host " - tenant_id = " -NoNewline -ForegroundColor green
Write-Host "${env:TF_VAR_tenant_id}";
Write-Host " - ip_address = " -NoNewline -ForegroundColor green
Write-Host "${env:TF_VAR_ip_address}";
Write-Host " - domain = " -NoNewline -ForegroundColor green
Write-Host "${env:TF_VAR_domain}";
Write-Host " ";
Write-Host "NOTE: It is recommended you copy these into your terraform/vars/local/terragrunt.hcl file for future use" -ForegroundColor blue
Write-Host " " 
Write-Host "If you are creating a local development instance only, you can run ./Deploy.ps1 now" -ForegroundColor green
Write-Host " " 
Write-Host "Press any key to continue...";
#------------------------------------------------------------------------------------------------------------
# Pause incase this was run directly
#------------------------------------------------------------------------------------------------------------
$null = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown');
