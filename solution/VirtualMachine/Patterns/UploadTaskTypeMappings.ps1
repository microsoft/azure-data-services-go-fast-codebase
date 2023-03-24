Import-Module ./GatherOutputsFromTerraform_VMFolder.psm1 -Force
$tout = GatherOutputsFromTerraform_VMFolder

$sqlserver_name=$tout.sqlserver_name
$stagingdb_name=$tout.stagingdb_name
$metadatadb_name=$tout.metadatadb_name


$patterns = (Get-Content "Patterns.json") | ConvertFrom-Json

# Fix the MSI registrations on the other databases. I'd like a better way of doing this in the future
$SqlInstalled = Get-InstalledModule SqlServer
if($null -eq $SqlInstalled)
{
    Write-Information "Installing SqlServer Module"
    Install-Module -Name SqlServer -Scope CurrentUser -Force
}

#----------------------------------------------------------------------------------------------------------------
#   TaskTypeMappings
#----------------------------------------------------------------------------------------------------------------
foreach ($pattern in ($patterns.Folder | Sort-Object | Get-Unique))
{    
    $file = "./pipeline/" + $pattern + "/output/schemas/taskmasterjson/TaskTypeMapping.sql"
    Write-Information "_____________________________"
    Write-Information "Updating TaskTypeMappings: " $file
    Write-Information "_____________________________"
    $sqlcommand = (Get-Content $file -raw)
    $token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
    Invoke-Sqlcmd -ServerInstance "$($tout.sqlserver_name).database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   

}
