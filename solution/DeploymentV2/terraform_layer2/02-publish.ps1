#----------------------------------------------------------------------------------------------------------------
# You must be logged into the Azure CLI to run this script
#----------------------------------------------------------------------------------------------------------------
# This script will: 
# - Deploy the required AAD objects (Application Registrations etc)
# 
# This is intended for creating a once off deployment from your development machine. You should setup the
# GitHub actions for your long term prod/non-prod environments
#
# Intructions
# - Ensure that you have run the Prepare.ps1 script first. This will prepare your azure subscription for deployment
# - Ensure that you have run az login and az account set
# - Ensure you have Contributor Access to the subscription you are deploying to. 
# - Ensure you have Application.ReadWrite.OwnedBy on the Azure AD. 
# - Run this script
# 
# You can run this script multiple times if needed.
# 
#----------------------------------------------------------------------------------------------------------------
param (
    [Parameter(Mandatory=$false)]
    [string]$FeatureTemplate=""
)



#------------------------------------------------------------------------------------------------------------
# Module Imports #Mandatory
#------------------------------------------------------------------------------------------------------------
import-Module ./../pwshmodules/GatherOutputsFromTerraform.psm1 -force
import-Module ./../pwshmodules/Deploy_0_Prep.psm1 -force
#------------------------------------------------------------------------------------------------------------
# Preparation #Mandatory
#------------------------------------------------------------------------------------------------------------
$PathToReturnTo = (Get-Location).Path
$deploymentFolderPath = Convert-Path -Path ((Get-Location).tostring() + './../')

$gitDeploy = ([System.Environment]::GetEnvironmentVariable('gitDeploy')  -eq 'true')
$skipTerraformDeployment = ([System.Environment]::GetEnvironmentVariable('skipTerraformDeployment')  -eq 'true')
$ipaddress = $env:TF_VAR_ip_address
$ipaddress2 = $env:TF_VAR_ip_address2

PrepareDeployment -gitDeploy $gitDeploy -deploymentFolderPath $deploymentFolderPath -FeatureTemplate $FeatureTemplate -PathToReturnTo $PathToReturnTo

if($env:TF_VAR_deployment_layer3_complete -eq $false -or $null -eq $env:TF_VAR_deployment_layer3_complete)
{
    Write-Error "Layer 3 Deployment is not complete. Code will now exit. Run terraform layer 3 for this deployment before running this layer (layer two) again."
    exit 
}

#------------------------------------------------------------------------------------------------------------
# Get Outputs #Mandatory
#------------------------------------------------------------------------------------------------------------
$tout = GatherOutputsFromTerraform -TerraformFolderPath $PathToReturnTo

#------------------------------------------------------------------------------------------------------------
# Publish
#------------------------------------------------------------------------------------------------------------

import-Module ./../pwshmodules/Deploy_4_PrivateLinks.psm1 -force
#DeployPrivateLinks -tout $tout  

import-Module ./../pwshmodules/Deploy_5_WebApp.psm1 -force
#DeployWebApp -tout $tout  -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

import-Module ./../pwshmodules/Deploy_6_FuncApp.psm1 -force
#DeployFuncApp -tout $tout  -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

import-Module ./../pwshmodules/Deploy_7_MetadataDB.psm1 -force
#DeployMetaDataDB -publish_metadata_database $true -tout $tout  -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

import-Module ./../pwshmodules/Deploy_9_DataFactory.psm1 -force
DeployDataFactoryAndSynapseArtefacts -tout $tout  -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

import-Module ./../pwshmodules/Deploy_10_SampleFiles.psm1 -force
#DeploySampleFiles -tout $tout  -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

import-Module ./../pwshmodules/Deploy_11_VirtualMachine.psm1 -force
ConfigureVirtualMachine -tout $tout  -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

import-Module ./../pwshmodules/Deploy_12_MetadataCICD_DbUp.psm1 -force
DeployMetadataCICDDbUp -tout $tout -deploymentFolderPath $deploymentFolderPath -PathToReturnTo $PathToReturnTo

#import-Module ./../pwshmodules/ConfigureAzurePurview.psm1 -force
#ConfigureAzurePurview -tout $tout  


#----------------------------------------------------------------------------------------------------------------
#   Set up Purview
#----------------------------------------------------------------------------------------------------------------
# This is a WIP - not recommended to use for standard user
#----------------------------------------------------------------------------------------------------------------
#
if($skipConfigurePurview -or $null -eq $skipConfigurePurview) {
    Write-Host "Skipping experimental Purview Configuration"
}
else {
    Write-Host "Running Purview Configuration (experimental) Script"
    Set-Location $deploymentFolderPath
    Invoke-Expression ./ConfigureAzurePurview.ps1
}


#----------------------------------------------------------------------------------------------------------------
#   Deploy Functional Tests
#----------------------------------------------------------------------------------------------------------------
# This is for development purposes primarily - If using, understand these may not be all working with most recent platform version as tests can become outdated / missing new required fields.
#----------------------------------------------------------------------------------------------------------------
if($skipFunctionalTests -or $null -eq $skipFunctionalTests) {
    Write-Host "Skipping Functional Tests Upload"
}
else {
    Write-Host "Deploying Functional Tests to Web App"
    Set-Location $deploymentFolderPath
    Invoke-Expression ./GenerateAndUploadFunctionalTests.ps1
}