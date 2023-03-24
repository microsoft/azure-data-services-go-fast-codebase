Import-Module ./GatherOutputsFromTerraform_SynapseFolder.psm1 -Force
$tout = GatherOutputsFromTerraform_SynapseFolder

$sqlserver_name=$tout.sqlserver_name
$metadatadb_name=$tout.metadatadb_name
$adls_vm_cmd_executor_name = $tout.adls_vm_cmd_executor_name

#$execution_engine_json = '{"endpoint": "' + $synapse_workspace_endpoint + '", "DeltaProcessingNotebook": "' + $delta_processing_notebook + '", "PurviewAccountName": "' + $purview_account_name + '", "DefaultSparkPoolName": "' + $synapse_spark_pool_name + '"}'
$execution_engine_json = @"
{
    "StorageAccountName:" "$($adls_vm_cmd_executor_name)"
}
"@
$SqlInstalled = Get-InstalledModule SqlServer
if($null -eq $SqlInstalled)
{
    Write-Verbose "Installing SqlServer Module"
    Install-Module -Name SqlServer -Scope CurrentUser -Force
}
#assuming synapse engine id = -2
$sql += @"
    BEGIN    
    UPDATE [dbo].[ExecutionEngine]
    SET EngineJson = '$($execution_engine_json)'
    WHERE EngineId = -3
    END 
"@

#----------------------------------------------------------------------------------------------------------------
#   Upload
#----------------------------------------------------------------------------------------------------------------
  
    Write-Verbose "_____________________________"
    Write-Verbose "Updating VM Execution Engine Json: " 
    Write-Verbose "_____________________________"
    $token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
    Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sql   

