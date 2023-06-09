<#
 * Copyright (c) Microsoft Corporation.
 * Licensed under the MIT license.

* General Description *
This script is for preparing a deployment. It takes in four parameters: $gitDeploy, $deploymentFolderPath, $FeatureTemplate, and $PathToReturnTo. $gitDeploy is a boolean and is mandatory. $deploymentFolderPath is a string and is also mandatory. $FeatureTemplate and $PathToReturnTo are optional strings.
The script changes the current location to $deploymentFolderPath and checks if the SqlServer PowerShell module is installed. If it's not, the script installs it. The script then checks if $gitDeploy is true or false. 
If it's true, it sets the resource group name and synapse workspace name environment variables. 
If it's false, it prompts the user to select a feature template if it's not already set. 
The script then sets the environment variable TF_VAR_ip_address or TF_VAR_ip_address2 with the IP address obtained from an external website.
The script then purges environment variables prefixed with "TF_VAR" if the variable $PurgeTFVARS is set to true.
Finally, the script re-processes the environment configuration files by running the PreprocessEnvironment.ps1 script with the provided parameters. 
It then changes the location back to $deploymentFolderPath or $PathToReturnTo if it's not null.

#>


function PrepareDeployment (
    [Parameter(Mandatory = $true)]
    [System.Boolean]$gitDeploy = $false,
    [Parameter(Mandatory = $true)]
    [String]$deploymentFolderPath,
    [Parameter(Mandatory = $false)]
    [String]$FeatureTemplate="",
    [Parameter(Mandatory = $false)]
    [String]$PathToReturnTo = ""    
    
) {
    Set-Location $deploymentFolderPath

    #Check for SQLServer Module
    $SqlInstalled = false
    try { 
        $SqlInstalled = Get-InstalledModule SqlServer
    }
    catch { "SqlServer PowerShell module not installed." }

    if ($null -eq $SqlInstalled) {
        write-host "Installing SqlServer Module"
        Install-Module -Name SqlServer -Scope CurrentUser -Force
    }

    #needed for git integration
    #az extension add --upgrade --name datafactory

    #accept custom image terms
    #https://docs.microsoft.com/en-us/cli/azure/vm/image/terms?view=azure-cli-latest

    #az vm image terms accept --urn h2o-ai:h2o-driverles-ai:h2o-dai-lts:latest


    #purge TF_VAR environment variables so we don't get issues from jumping between environments
    #this can be an issue if you have different features enabled between environments
    #as old features may persist otherwise
    $PurgeTFVARS = $false #Disabled for now as causes passwords not to persist. Will add to prepare script or separate as separate script
    if($PurgeTFVARS)
    {
        $envVariables = gci env:
        foreach($var in $envVariables)
        {
            if($var.Name -clike 'TF_VAR*')
            {
                [System.Environment]::SetEnvironmentVariable($var.Name, '')
            }
        }
    }

    if ($gitDeploy) {
        Write-Host "GitDeploy is true"
        $resourceGroupName = [System.Environment]::GetEnvironmentVariable('ARM_RESOURCE_GROUP_NAME')
        $synapseWorkspaceName = [System.Environment]::GetEnvironmentVariable('ARM_RESOURCE_SYNAPSE_WORKSPACE_NAME')
        $env:TF_VAR_ip_address = (Invoke-WebRequest ifconfig.me/ip).Content 
    }
    else {
    
        $environmentName = GetEnvVar_environmentName

        $env:TF_VAR_ip_address2 = (Invoke-WebRequest ifconfig.me/ip).Content     

        #Prompt if Feature Template has not been set
        if ([string]::IsNullOrEmpty($FeatureTemplate) -eq $true) {   
            if ([string]::IsNullOrEmpty($env:ARM_FEATURE_TEMPLATE) -eq $false) {
               $FeatureTemplate =  $env:ARM_FEATURE_TEMPLATE
            }
            else {
                $fts = (Get-ChildItem -Path ./environments/featuretemplates | Select-Object -Property Name).Name.replace(".jsonc", "")
                $templateName = Get-SelectionFromUser -Options ($fts) -Prompt "Select feature template"
                if ($templateName -eq "Quit") {
                    Exit
                }
                else {
                    $FeatureTemplate = $templateName    
                    $env:ARM_FEATURE_TEMPLATE = $FeatureTemplate
                }
            }
            
        }

    }



    $environmentName = [System.Environment]::GetEnvironmentVariable('environmentName')

    if ($environmentName -eq "Quit" -or [string]::IsNullOrEmpty($environmentName)) {
        write-host "environmentName is currently: $environmentName"
        Write-Error "Environment is not set"
        Exit
    }


    #Re-process Environment Config Files. 
    Set-Location ./environments/vars/
    ./PreprocessEnvironment.ps1 -Environment $environmentName -FeatureTemplate $FeatureTemplate -gitDeploy $gitDeploy
    Set-Location $deploymentFolderPath

    [System.Environment]::SetEnvironmentVariable('TFenvironmentName', $environmentName)
    if (($env:TF_VAR_ip_address -ne "") -and ($env:TF_VAR_ip_address -ne $env:TF_VAR_ip_address2) -and (($env:TF_VAR_delay_private_access) -or $env:(TF_VAR_is_vnet_isolated -eq False)))
    {
        try {
            #state
            $resourcecheck = ((az storage account list --resource-group $env:TF_VAR_resource_group_name | ConvertFrom-Json -Depth 10) | Where-Object {$_.name -eq $env:TF_VAR_state_storage_account_name}).count
            if($resourcecheck -gt 0) 
            {
                $hiddenoutput = az storage account network-rule add --resource-group $env:TF_VAR_resource_group_name --account-name  $env:TF_VAR_state_storage_account_name --ip-address $env:TF_VAR_ip_address --only-show-errors
            }            

            #DataLake
            $resourcecheck = ((az storage account list --resource-group $env:TF_VAR_resource_group_name | ConvertFrom-Json -Depth 10) | Where-Object {$_.name -eq $env:datalakeName}).count
            if($resourcecheck -gt 0) {
                $hiddenoutput = az storage account network-rule add --resource-group $env:TF_VAR_resource_group_name --account-name  $env:datalakeName --ip-address $env:TF_VAR_ip_address --only-show-errors
            }

            #Key Vault
            $resourcecheck = ( (az keyvault list --resource-group $env:TF_VAR_resource_group_name | convertfrom-json -depth 10) | Where-Object {$_.name -eq $env:keyVaultName}).count
            if($resourcecheck -gt 0) {
                $hiddenoutput = az keyvault network-rule add -g $env:TF_VAR_resource_group_name --name $env:keyVaultName --ip-address $env:TF_VAR_ip_address/32 --only-show-errors
            }
              
            #Synapse
            $resourcecheck = ( (az synapse workspace list --resource-group $env:TF_VAR_resource_group_name | convertfrom-json -depth 10) | Where-Object {$_.name -eq $env:ARM_SYNAPSE_WORKSPACE_NAME}).count
            if($resourcecheck -gt 0) {
                $hiddenoutput = az synapse workspace firewall-rule create --name CICDAgent --resource-group $env:TF_VAR_resource_group_name --start-ip-address $env:TF_VAR_ip_address --end-ip-address $env:TF_VAR_ip_address --workspace-name $env:ARM_SYNAPSE_WORKSPACE_NAME --only-show-errors
            }
            
        }
        catch {
            Write-Warning 'Opening Firewalls for IP Address One Failed'
        }
    }

    if ($env:TF_VAR_ip_address2 -ne "" -and (($env:TF_VAR_delay_private_access) -or $env:(TF_VAR_is_vnet_isolated -eq False)))
    {
        try {
             #state
             $resourcecheck = ((az storage account list --resource-group $env:TF_VAR_resource_group_name | ConvertFrom-Json -Depth 10) | Where-Object {$_.name -eq $env:TF_VAR_state_storage_account_name}).count
             if($resourcecheck -gt 0) 
             {
                 $hiddenoutput = az storage account network-rule add --resource-group $env:TF_VAR_resource_group_name --account-name  $env:TF_VAR_state_storage_account_name --ip-address $env:TF_VAR_ip_address2 --only-show-errors
             }            
 
             #DataLake
             $resourcecheck = ((az storage account list --resource-group $env:TF_VAR_resource_group_name | ConvertFrom-Json -Depth 10) | Where-Object {$_.name -eq $env:datalakeName}).count
             if($resourcecheck -gt 0) {
                 $hiddenoutput = az storage account network-rule add --resource-group $env:TF_VAR_resource_group_name --account-name  $env:datalakeName --ip-address $env:TF_VAR_ip_address2 --only-show-errors
             }
 
             #Key Vault
             $resourcecheck = ( (az keyvault list --resource-group $env:TF_VAR_resource_group_name | convertfrom-json -depth 10) | Where-Object {$_.name -eq $env:keyVaultName}).count
             if($resourcecheck -gt 0) {
                 $hiddenoutput = az keyvault network-rule add -g $env:TF_VAR_resource_group_name --name $env:keyVaultName --ip-address $env:TF_VAR_ip_address2/32 --only-show-errors
             }
               
             #Synapse
             $resourcecheck = ( (az synapse workspace list --resource-group $env:TF_VAR_resource_group_name | convertfrom-json -depth 10) | Where-Object {$_.name -eq $env:ARM_SYNAPSE_WORKSPACE_NAME}).count
             if($resourcecheck -gt 0) {
                 $hiddenoutput = az synapse workspace firewall-rule create --name CICDUser --resource-group $env:TF_VAR_resource_group_name --start-ip-address $env:TF_VAR_ip_address2 --end-ip-address $env:TF_VAR_ip_address2 --workspace-name $env:ARM_SYNAPSE_WORKSPACE_NAME --only-show-errors
             }
        }
        catch {
            Write-Warning 'Opening Firewalls for IP Address Two Failed'
        }    
    }


    if ([string]::IsNullOrEmpty($PathToReturnTo) -ne $true) {
        Write-Debug "Returning to $PathToReturnTo"
        Set-Location $PathToReturnTo
    }
    else {
        Write-Debug "Path to return to is null"
    }

}

function GetEnvVar_environmentName(
)
{
    #Prompt if Environment Variable has not been set
    if ($null -eq [System.Environment]::GetEnvironmentVariable('environmentName')) {        
        $envlist = (Get-ChildItem -Directory -Path ./environments/vars | Select-Object -Property Name).Name
        Import-Module ./pwshmodules/GetSelectionFromUser.psm1 -Force   
        $environmentName = Get-SelectionFromUser -Options ($envlist) -Prompt "Select deployment environment"
        [System.Environment]::SetEnvironmentVariable('environmentName', $environmentName)
        return $environmentName
    }
    else 
    {
        return [System.Environment]::GetEnvironmentVariable('environmentName')
    }
}