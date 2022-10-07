$deploymentFolderPath = (Get-Location).Path
Import-Module .\pwshmodules\GatherOutputsFromTerraform.psm1 -force
Set-Location "./terraform_layer2"

#------------------------------------------------------------------------------------------------------------
# Get all the outputs from terraform so we can use them in subsequent steps
#------------------------------------------------------------------------------------------------------------
Write-Host "Reading Terraform Outputs"

$tout = GatherOutputsFromTerraform -TerraformFolderPath './'
              
$ScriptUri = "https://gist.githubusercontent.com/jrampono/91076c406345c1d2487a82b1f106dfaa/raw/AW_EnableCDC.ps1"

#Run  Remote Script
az vm run-command create --name "InstallSQLCDC1" --vm-name $tout.selfhostedsqlvm_name --resource-group $tout.resource_group_name --parameters test="test" --script-uri $ScriptUri

#Check Results
az vm run-command show --name "InstallSQLCDC1" --vm-name $tout.selfhostedsqlvm_name --resource-group $tout.resource_group_name --instance-view


Set-Location $deploymentFolderPath

