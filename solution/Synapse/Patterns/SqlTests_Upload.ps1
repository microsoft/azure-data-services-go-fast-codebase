Import-Module .\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform
$sqlserver_name=$tout.sqlserver_name
$stagingdb_name=$tout.stagingdb_name
$metadatadb_name=$tout.metadatadb_name


$SqlInstalled = Get-InstalledModule SqlServer
if($null -eq $SqlInstalled)
{
    write-host "Installing SqlServer Module"
    Install-Module -Name SqlServer -Scope CurrentUser -Force
}

$sqlcommand = (Get-Content ./SqlTests.sql -raw)
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   