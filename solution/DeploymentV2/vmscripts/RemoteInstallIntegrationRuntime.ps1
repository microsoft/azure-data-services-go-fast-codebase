$deploymentFolderPath = (Get-Location).Path
Import-Module .\pwshmodules\GatherOutputsFromTerraform.psm1 -force
Set-Location "./terraform_layer2"

#------------------------------------------------------------------------------------------------------------
# Get all the outputs from terraform so we can use them in subsequent steps
#------------------------------------------------------------------------------------------------------------
Write-Host "Reading Terraform Outputs"

$tout = GatherOutputsFromTerraform -TerraformFolderPath './'

$irKey1 = az datafactory integration-runtime list-auth-key --factory-name $tout.datafactory_name --name $tout.integration_runtimes[1].name --resource-group $tout.resource_group_name --query authKey1 --out tsv
Write-Debug " irKey1 retrieved."
               
$ScriptUri = "https://gist.githubusercontent.com/jrampono/09093e22a8da010b6e1a27a9232cbb9b/raw/Install_AzureIntegrationRuntime.ps1"

#Run  Remote Script
az vm run-command create --name "InstallIR" --vm-name $tout.selfhostedsqlvm_name --resource-group $tout.resource_group_name --parameters authkey=$irKey1 --script-uri $ScriptUri

#Check Results
az vm run-command show --name "InstallIR" --vm-name $tout.selfhostedsqlvm_name --resource-group $tout.resource_group_name --instance-view

Set-Location $deploymentFolderPath
#sqlcmd -Q "EXEC sys.sp_cdc_enable_table @source_schema = N'SalesLT',  @source_name   = N'Product',  @role_name     = NULL,  @supports_net_changes = 1" -d "Adventureworks"
#sqlcmd -Q "EXEC sys.sp_cdc_enable_table @source_schema = N'SalesLT',  @source_name   = N'Customer',  @role_name     = NULL,  @supports_net_changes = 1" -d "Adventureworks"
#sqlcmd -Q "EXEC sys.sp_cdc_enable_table @source_schema = N'SalesLT',  @source_name   = N'SalesOrderHeader',  @role_name     = NULL,  @supports_net_changes = 1" -d "Adventureworks"
