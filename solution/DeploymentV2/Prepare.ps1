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
# /azure-data-services-go-fast-codebase/solution/DeploymentV2/terraform/vars/local/terragrunt.hcl
#
# This file is used by the ./Deploy.ps1 script by default and will be used if no enviroment vars are available
#
# Once this script has finished, you then run Deploy.ps1 to create your environment
# ------------------------------------------------------------------------------------------------------------

function Get-SelectionFromUser {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Options,
        [Parameter(Mandatory=$true)]
        [string]$Prompt        
    )
    
    [int]$Response = 0;
    [bool]$ValidResponse = $false    

    while (!($ValidResponse)) {            
        [int]$OptionNo = 0

        Write-Host $Prompt -ForegroundColor DarkYellow
        Write-Host "[0]: Quit"

        foreach ($Option in $Options) {
            $OptionNo += 1
            Write-Host ("[$OptionNo]: {0}" -f $Option)
        }

        if ([Int]::TryParse((Read-Host), [ref]$Response)) {
            if ($Response -eq 0) {
                return ''
            }
            elseif($Response -le $OptionNo) {
                $ValidResponse = $true
            }
        }
    }

    return $Options.Get($Response - 1)
} 

$environmentName = Get-SelectionFromUser -Options ('Local','Staging') -Prompt "Select deployment environment"
if ($environmentName -eq "Quit")
{
    Exit
}


$environmentFile = "./EnvironmentTemplate_" + $environmentName + ".hcl"
$environmentFileContents = Get-Content $environmentFile

$env:TF_VAR_resource_group_name = Read-Host "Enter the name of the resource group to create (enter to skip)"
$env:TF_VAR_storage_account_name = Read-Host "Enter a unique name for the terraform state storage account (enter to skip)"
$CONTAINER_NAME="tstate"



# ------------------------------------------------------------------------------------------------------------
# Ensure that you have all of the require Azure resource providers enabled before you begin deploying the solution.
# ------------------------------------------------------------------------------------------------------------
$RegRps = Get-SelectionFromUser -Options ('Yes','No') -Prompt "Do you want to register the Azure resource providers? (the recommended answer is 'Yes')"
if ($RegRps -eq "Quit")
{
    Exit
}

if ($RegRps -eq 'Yes')
{
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
    'Microsoft.PolicyInsights',
    'Microsoft.OperationsManagement',
    'Microsoft.Synapse',
    'Microsoft.DataFactory',
    'Microsoft.Sql')

    $progress = 0
    Write-Progress -Activity "Registering Azure Resource Providers" -Status "${progress}% Complete:" -PercentComplete $progress

    ForEach ($provider in $providers) {
        $progress += 5;
        az provider register --namespace $provider
        Write-Progress -Activity "Registering Azure Resource Providers" -Status "${progress}% Complete:" -PercentComplete $progress
    }
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
if([string]::IsNullOrEmpty($env:TF_VAR_resource_group_name) -eq $false) {
    $progress = 0
    Write-Progress -Activity "Creating Resource Group" -Status "${progress}% Complete:" -PercentComplete $progress 
    $rg = az group create -n $env:TF_VAR_resource_group_name -l australiaeast

    if([string]::IsNullOrEmpty($env:TF_VAR_storage_account_name) -eq $false) {
        $progress+=5
        Write-Progress -Activity "Creating Storage Account" -Status "${progress}% Complete:" -PercentComplete $progress
        $storageId = az storage account create --resource-group $env:TF_VAR_resource_group_name --name $env:TF_VAR_storage_account_name --sku Standard_LRS --allow-blob-public-access false --https-only true --min-tls-version TLS1_2 --query id -o tsv

        $progress+=5
        $userObjectId = az ad signed-in-user show --query objectId -o tsv
        Write-Progress -Activity "Assigning Blob Contributor" -Status "${progress}% Complete:" -PercentComplete $progress
        $assignment = az role assignment create --role "Storage Blob Data Contributor" --assignee-object-id $userObjectId --assignee-principal-type User

        $progress+=5
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

#------------------------------------------------------------------------------------------------------------
# Persist into relevant environment file
#------------------------------------------------------------------------------------------------------------
$PersistEnv = Get-SelectionFromUser -Options ('Yes','No') -Prompt "Do you want to automatically persist the configuration information into your environment file? WARNING this will overwrite your existing hcl file."
if ($PersistEnv -eq "Quit")
{
    Exit
}

if ($PersistEnv -eq "Yes")
{
    $environmentFileTarget = "./terraform/vars/" + $environmentName.ToLower() + "/terragrunt.hcl"
    
    $environmentFileContents = $environmentFileContents.Replace("{prefix}","ads")

    $environmentFileContents = $environmentFileContents.Replace("{resource_group_name}","$env:TF_VAR_resource_group_name")
    $environmentFileContents = $environmentFileContents.Replace("{storage_account_name}","$env:TF_VAR_storage_account_name")
    $environmentFileContents = $environmentFileContents.Replace("{subscription_id}","$env:TF_VAR_subscription_id")
    $environmentFileContents = $environmentFileContents.Replace("{tenant_id}","$env:TF_VAR_tenant_id")
    $environmentFileContents = $environmentFileContents.Replace("{ip_address}","$env:TF_VAR_ip_address")
    $environmentFileContents = $environmentFileContents.Replace("{domain}","$env:TF_VAR_domain")
    
    
    #------------------------------------------------------------------------------------------------------------
    # Templated Configurations
    #------------------------------------------------------------------------------------------------------------

    $templateName = Get-SelectionFromUser -Options ('Minimal-NoVNET,No Purview, No Synapse','Full-AllFeatures','FunctionalTests-NoVNET,No Purview, No Synapse, Includes SQL IAAS') -Prompt "Select deployment fast start template"
    if ($templateName -eq "Quit")
    {
        Exit
    }

    if ($templateName -eq "Full-AllFeatures")
    {
        $environmentFileContents = $environmentFileContents.Replace("{deploy_sentinel}","true")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_purview}","true")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_synapse}","true")
        $environmentFileContents = $environmentFileContents.Replace("{is_vnet_isolated}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_web_app}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_function_app}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_sample_files}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_database}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_sif}","true")
        $environmentFileContents = $environmentFileContents.Replace("{configure_networking}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_datafactory_pipelines}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_web_app_addcurrentuserasadmin}","true")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_selfhostedsql}","false")
        $environmentFileContents = $environmentFileContents.Replace("{is_onprem_datafactory_ir_registered}","false")

    } 

    if ($templateName -eq "Minimal-NoVNET,No Purview, No Synapse")
    {
        $environmentFileContents = $environmentFileContents.Replace("{deploy_sentinel}","false")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_purview}","false")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_synapse}","false")
        $environmentFileContents = $environmentFileContents.Replace("{is_vnet_isolated}","false")
        $environmentFileContents = $environmentFileContents.Replace("{publish_web_app}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_function_app}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_sample_files}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_database}","true")
        $environmentFileContents = $environmentFileContents.Replace("{configure_networking}","false")
        $environmentFileContents = $environmentFileContents.Replace("{publish_datafactory_pipelines}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_web_app_addcurrentuserasadmin}","true")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_selfhostedsql}","false")
        $environmentFileContents = $environmentFileContents.Replace("{is_onprem_datafactory_ir_registered}","false")

    } 

    if ($templateName -eq "FunctionalTests-NoVNET,No Purview, No Synapse, Includes SQL IAAS")
    {
        $environmentFileContents = $environmentFileContents.Replace("{deploy_sentinel}","false")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_purview}","false")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_synapse}","false")
        $environmentFileContents = $environmentFileContents.Replace("{is_vnet_isolated}","false")
        $environmentFileContents = $environmentFileContents.Replace("{publish_web_app}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_function_app}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_sample_files}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_database}","true")
        $environmentFileContents = $environmentFileContents.Replace("{configure_networking}","false")
        $environmentFileContents = $environmentFileContents.Replace("{publish_datafactory_pipelines}","true")
        $environmentFileContents = $environmentFileContents.Replace("{publish_web_app_addcurrentuserasadmin}","true")
        $environmentFileContents = $environmentFileContents.Replace("{deploy_selfhostedsql}","true")
        $environmentFileContents = $environmentFileContents.Replace("{is_onprem_datafactory_ir_registered}","false")

    } 
    
    
    
    $environmentFileContents | Set-Content $environmentFileTarget
}