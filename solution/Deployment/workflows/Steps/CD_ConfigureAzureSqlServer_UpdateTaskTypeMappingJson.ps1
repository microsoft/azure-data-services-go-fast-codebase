
#Get Access Token for SQL --Note that the deployment principal or user running locally will need rights on the database
$token=$(az account get-access-token --resource=https://database.windows.net/ --query accessToken --output tsv)     
$targetserver = $env:AdsOpts_CD_Services_AzureSQLServer_Name + ".database.windows.net"

$jsonbase = "./../../TaskTypeJson/"   
Get-ChildItem "$jsonbase" -Filter *.json | 
Foreach-Object {
    $lsName = $_.BaseName 
    $fileName = $_.FullName
    $jsonobject = ($_ | Get-Content).Replace("'", "''")
    $Name = $_.BaseName
    $sql = "Update TaskTypeMapping
    Set TaskMasterJsonSchema = new.TaskMasterJsonSchema
    from TaskTypeMapping ttm 
    inner join 
    (
        Select MappingName = N'$Name' , TaskMasterJsonSchema = N'$jsonobject'
    ) new on ttm.MappingName = new.MappingName"
    Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query $sql
}


#Loop through all Existing Task Master JSON Entries in DB
#$tm = Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query "Select * from dbo.TaskMaster"

#$ttm = Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query "Select * from dbo.TaskTypeMapping"




