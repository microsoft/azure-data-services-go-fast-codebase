function ConfigureVirtualMachine (    
    [Parameter(Mandatory = $true)]
    [pscustomobject]$tout = $false,
    [Parameter(Mandatory = $true)]
    [string]$deploymentFolderPath = "",
    [Parameter(Mandatory = $true)]
    [String]$PathToReturnTo = ""
) {

    #----------------------------------------------------------------------------------------------------------------
    #   Configure Virtual Machines
    #----------------------------------------------------------------------------------------------------------------
    $skipVirtualMachines = if ($tout.deploy_cmd_executor_vm) { $false } else { $true }
    if ($skipVirtualMachines) {
        Write-Host "Skipping Virtual Machine Configuration"    
    }
    else {
        Set-Location $deploymentFolderPath
        $localDest = "./Upload/"
        $container = "util"
        $accountName = $tout.adls_vm_cmd_executor_name
        $path = "/Scripts/"

        
        Set-Location "./utilities/VM_Executor_Scripts/"
        Write-Host "Configuring Virtual Machine"
        if ($tout.is_vnet_isolated -eq $true) {
            $result = az storage account update --resource-group $tout.resource_group_name --name $accountName --default-action Allow --only-show-errors
        }

        $result = az storage container create --name $container --account-name $accountName --auth-mode login --only-show-errors

        $result = az storage blob upload-batch --overwrite --destination $container --account-name $accountName --source $localDest --destination-path $path --auth-mode login --only-show-errors


#at the moment this is only doing 1 file download -> may need to iterate or do batch download later on if more files are required
$bashCommandString = @"
az login --identity
local_path="/home/adminuser/scripts/Linux_DBT_crontab.ps1"
remote_path="/Scripts/Linux_DBT_crontab.ps1"
container=$($container)
account_name=$($accountName)
az storage fs file download -p `$remote_path -d `$local_path -f `$container --account-name `$account_name --auth-mode login
"@

        $result = az vm run-command invoke -g $tout.resource_group_name -n ads-uat-vm-cmdexe --command-id RunShellScript --scripts $bashCommandString
#crontab output will likely be 'no crontab for user' as this is first cron job being added (from the crontab -l)
#we are setting the crontab up for adminuser -> as the default run-command runs off root
$bashCommandString = @"
crontab -u adminuser -l | { cat; echo '*/5 * * * * pwsh -executionpolicy bypass -File "/home/adminuser/scripts/Linux_DBT_crontab.ps1"'; } | crontab -u adminuser -
"@

        $result = az vm run-command invoke -g $tout.resource_group_name -n ads-uat-vm-cmdexe --command-id RunShellScript --scripts $bashCommandString

        if ($tout.is_vnet_isolated -eq $true) {
            $result = az storage account update --resource-group $tout.resource_group_name --name $tout.adlsstorage_name --default-action Deny --only-show-errors
        }

        Set-Location $deploymentFolderPath

        if ([string]::IsNullOrEmpty($PathToReturnTo) -ne $true) {
            Write-Debug "Returning to $PathToReturnTo"
            Set-Location $PathToReturnTo
        }
        else {
            Write-Debug "Path to return to is null"
        }

    }



}