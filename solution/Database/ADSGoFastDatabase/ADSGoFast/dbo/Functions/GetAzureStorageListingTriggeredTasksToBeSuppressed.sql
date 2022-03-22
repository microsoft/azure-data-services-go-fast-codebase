/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
create function [dbo].[GetAzureStorageListingTriggeredTasksToBeSuppressed] () returns table as
return
Select 
	distinct a.TaskInstanceId
from dbo.TaskInstance a
inner join dbo.TaskMaster b on a.TaskMasterId = b.TaskMasterId
inner join dbo.SourceAndTargetSystems s1 on s1.SystemId = b.SourceSystemId
cross apply
(Select TaskInstanceFilePathAndName = case when  ISJSON(a.TaskInstanceJson) = 1 and ISJSON(b.TaskMasterJSON) = 1 and  ISJSON(s1.SystemJSON)=1  then  JSON_Value(s1.SystemJSON,'$.Container')  + '/' + JSON_Value(a.TaskInstanceJson,'$.SourceRelativePath') + JSON_Value(b.TaskMasterJSON,'$.Source.DataFileName') else null end) c1
left join dbo.AzureStorageListing c on c1.TaskInstanceFilePathAndName = c.FilePath
where 
	a.LastExecutionStatus in ('Untried', 'FailedRetry') and a.TaskRunnerId is null
	and s1.SystemType in ('Azure Blob', 'ADLS')
	and ISJSON(a.TaskInstanceJson) = 1 and ISJSON(b.TaskMasterJSON) = 1 
	and a.ActiveYN = 1 and b.ActiveYN = 1
	and JSON_Value(b.TaskMasterJSON,'$.Source.TriggerUsingAzureStorageCache') = 'true'
	and c.FilePath is null
