#----------------------------------------------------------------------------------------------------------------
# You must be logged into the Azure CLI to run this script
#  WARNING  use only for development purposes!!! If you are not sure what this does please use terragrunt destroy instead
#----------------------------------------------------------------------------------------------------------------

Import-Module .\pwshmodules\GetSelectionFromUser.psm1 -force
$environmentName = Get-SelectionFromUser -Options ('local','staging') -Prompt "Select deployment environment"
if ($environmentName -eq "Quit")
{
    Exit
}
[System.Environment]::SetEnvironmentVariable('TFenvironmentName',$environmentName)

Set-Location ".\terraform"

#------------------------------------------------------------------------------------------------------------
# Get all the outputs from terraform so we can use them in subsequent steps
#------------------------------------------------------------------------------------------------------------
Write-Host "Reading Terraform Outputs"
Import-Module .\..\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform

#Delete Resource Group
az group delete --name $tout.resource_group_name 

#Delete App and SP for Web App Auth 
az ad app delete --id $tout.aad_webreg_id

#Delete App and SP for Function App Auth
az ad app delete --id $tout.aad_funcreg_id

#Remove Terraform State and Backend Files 
rm ./terraform.tfstate
rm ./backend.tf