Import-Module .\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform
$sqlserver_name=$tout.sqlserver_name
$stagingdb_name=$tout.stagingdb_name
$metadatadb_name=$tout.metadatadb_name
$sifdb_name=$tout.sifdb_name


$SqlInstalled = Get-InstalledModule SqlServer
if($null -eq $SqlInstalled)
{
    write-host "Installing SqlServer Module"
    Install-Module -Name SqlServer -Scope CurrentUser -Force
}

$sqlcommand = (Get-Content ./SqlTests.sql -raw)
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   

#Insert any missing CDC watermarks"
$sqlcommand = @"
insert into [dbo].[TaskMasterWaterMark]
Select a.	, 'lsn', 'lsn', null, null, '', null, 1, getdate() 
from [dbo].[TaskMaster] a left outer join [dbo].[TaskMasterWaterMark] b on a.TaskMasterID=  b.TaskMasterId
where a.[TaskTypeId] = -4 and b.TaskMasterId is null
"@
Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   


#Insert any missing INT watermarks"
$sqlcommand = @"
insert into TaskMasterWaterMark
Select a.TaskMasterId, 'CustomerId', 'BigInt', null, 0,'','{}', 1, getdate() 
from [dbo].[TaskMaster] a 
left outer join [dbo].[TaskMasterWaterMark] b on a.TaskMasterID=  b.TaskMasterId
where a.[TaskTypeId] = -3 and b.TaskMasterId is null and JSON_VALUE(a.TaskMasterJson,'$.Source.IncrementalType') = 'Watermark'
"@
Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   


#Add Group Level Dependencies 
$sqlcommand = @"
insert into [dbo].[TaskGroupDependency]  
(
	[AncestorTaskGroupid]                          ,
	[DescendantTaskGroupId]                        ,
	[DependencyType]                                   
)
Select a.* from 
(
	Select 
		-5 AncestorTaskGroupid,
		-6 DescendantTaskGroupId,
		'EntireGroup' DependencyType
	union all 
	Select 
		-6,
		-7,
		'EntireGroup'
) a
right join [dbo].[TaskGroupDependency]  b on a.AncestorTaskGroupid = b.AncestorTaskGroupid and a.DescendantTaskGroupId = b.DescendantTaskGroupId
where b.AncestorTaskGroupid is null
"@
Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   

