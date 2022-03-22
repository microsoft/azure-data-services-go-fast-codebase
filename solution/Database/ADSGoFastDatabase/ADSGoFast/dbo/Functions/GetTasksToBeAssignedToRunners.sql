/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/



--Select * from dbo.[GetTasksToBeAssignedToRunners]()
CREATE Function [dbo].[GetTasksToBeAssignedToRunners]() returns Table  
AS
RETURN
With AllTasksToBeRun as
(
SELECT 	
	TG.TaskGroupPriority, TG.TaskGroupId, TI.TaskInstanceId, SI.ScheduledDateTimeOffset
FROM 
[dbo].[TaskInstance] TI 
INNER JOIN [dbo].[ScheduleInstance] SI ON TI.ScheduleInstanceId = SI.ScheduleInstanceId
INNER JOIN [dbo].[TaskMaster] TM ON TI.TaskMasterID = TM.TaskMasterID
INNER JOIN [dbo].[TaskGroup] TG ON TM.TaskGroupId = TG.TaskGroupId
INNER JOIN [dbo].[SourceAndTargetSystems] SS ON SS.SystemId = TM.[SourceSystemId]
INNER JOIN [dbo].[SourceAndTargetSystems] TS ON TS.SystemId = TM.TargetSystemId
WHERE TI.ActiveYN = 1 and TI.LastExecutionStatus in ('Untried', 'FailedRetry') and TaskRunnerId is null
), 
TasksWithAnscestors as 
(
Select  TIP.TaskInstanceId, count(TGD.AncestorTaskGroupId) AscestorsNotReady 
from 			
	AllTasksTobeRun TIP
	INNER JOIN [dbo].[TaskInstance] TIDesc on TIP.TaskInstanceId = TIDesc.TaskInstanceId
	inner join [dbo].[TaskMaster] TMDesc on TIDesc.TaskMasterId = TMDesc.TaskMasterId
	Inner Join [dbo].[TaskGroup] TGDesc on TGDesc.TaskGroupId = TMDesc.TaskGroupId	
	Inner Join [dbo].[TaskGroupDependency] TGD on TGD.DescendantTaskGroupId = TMDesc.TaskGroupId 
	Inner Join [dbo].[TaskGroup] TGAnc on TGAnc.TaskGroupId = TGD.AncestorTaskGroupId  
	inner join [dbo].[TaskMaster] TMAnc on TMAnc.TaskGroupId = TGAnc.TaskGroupId and (TGD.DependencyType = 'EntireGroup' or TMAnc.DependencyChainTag = TMDesc.DependencyChainTag)
	inner join [dbo].[TaskInstance] TIAnc on TIAnc.TaskMasterId = TMAnc.TaskMasterId 
Where TIAnc.LastExecutionStatus in ('Untried', 'FailedRetry', 'InProgress') 
Group by TIP.TaskInstanceId
HAVING Count(*) > 0
union all
Select TaskInstanceId, 1 
from [GetAzureStorageListingTriggeredTasksToBeSuppressed]()
),
Result as 
(Select a.*
from AllTasksTobeRun a
left outer join
TasksWithAnscestors b on a.TaskInstanceId = b.TaskInstanceId
where b.TaskInstanceId is null
)
Select  *, IntraGroupExecutionOrder = ROW_NUMBER() over (Partition by TaskGroupid Order by ScheduledDateTimeOffset) 
from Result
