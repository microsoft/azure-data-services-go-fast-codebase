/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/







Create proc [dbo].[GetTaskMaster]
as

Select 
	SM.ScheduleMasterId, 

	TM.TaskMasterJSON,
	TM.TaskMasterId,
	TM.TaskDatafactoryIR,
	TM.TaskTypeId,
	TT.[TaskExecutionType],

	--SOURCE
	SS.SystemJSON as SourceSystemJSON,
	SS.SystemType as SourceSystemType,
	
	--TARGET
	TS.SystemJSON as TargetSystemJSON,
	TS.SystemType as TargetSystemType

INTO #AllTasksTobeCreated

From
	[dbo].[ScheduleMaster] SM 

	Inner Join [dbo].[TaskMaster] TM
	ON TM.ScheduleMasterId = SM.ScheduleMasterId
	and TM.ActiveYN = 1	

	INNER Join [dbo].[TaskType] TT
	ON TT.TaskTypeId = TM.TaskTypeId

	Inner Join [dbo].[TaskGroup] TG
	ON TG.TaskGroupId = TM.TaskGroupId
	AND TG.ActiveYN = 1

	left Join [dbo].[TaskInstance] TI
	ON TI.TaskMasterId = TM.TaskMasterId
	AND TI.LastExecutionStatus in ('Untried','FailedRetry','InProgress')

	Inner Join [dbo].[SourceAndTargetSystems] SS
	ON SS.SystemId = TM.[SourceSystemId]
	and SS.ActiveYN = 1
	
	Inner Join [dbo].[SourceAndTargetSystems] TS
	ON TS.SystemId = TM.TargetSystemId
	and TS.ActiveYN = 1

Where SM.ActiveYN = 1
AND (
		(TM.AllowMultipleActiveInstances = 0 and TI.TaskMasterId is null)
		OR
		(TM.AllowMultipleActiveInstances = 1)
	)


--List of Task to be excluded due to incomplete dependencies (PARENT)
Select  TMAnc.TaskMasterId
into #TasksToBeExcludedParent
from 			
	[dbo].[TaskInstance] TI
	
	inner join [dbo].[TaskMaster] TM
	on TI.TaskMasterId = TM.TaskMasterId

	Inner Join [dbo].[TaskGroup] TG 
	on TG.TaskGroupId = TM.TaskGroupId	

	Inner Join [dbo].[TaskGroupDependency] TGD 
	on TGD.DescendantTaskGroupId = TM.TaskGroupId 
	and TGD.DependencyType = 'TasksMatchedByTagAndSchedule'

	Inner Join [dbo].[TaskGroup] TGAnc 
	on TGAnc.TaskGroupId = TGD.AncestorTaskGroupId  
	
	inner join [dbo].[TaskMaster] TMAnc
	on TMAnc.TaskGroupId = TGAnc.TaskGroupId 
	and TMAnc.DependencyChainTag = TM.DependencyChainTag
	
Where TI.LastExecutionStatus in ('Untried', 'FailedRetry', 'InProgress') 
AND TM.DependencyChainTag is not null

--List of Task to be excluded due to incomplete dependencies (CHILD)
Select  TM.TaskMasterId
into #TasksToBeExcludedCHILD
from 			
	[dbo].[TaskInstance] TI
	
	inner join [dbo].[TaskMaster] TM
	on TI.TaskMasterId = TM.TaskMasterId

	Inner Join [dbo].[TaskGroup] TG 
	on TG.TaskGroupId = TM.TaskGroupId	

	Inner Join [dbo].[TaskGroupDependency] TGD 
	on TGD.DescendantTaskGroupId = TM.TaskGroupId 
	and TGD.DependencyType = 'TasksMatchedByTagAndSchedule'

	Inner Join [dbo].[TaskGroup] TGAnc 
	on TGAnc.TaskGroupId = TGD.AncestorTaskGroupId  
	
	inner join [dbo].[TaskMaster] TMAnc
	on TMAnc.TaskGroupId = TGAnc.TaskGroupId 
	and TMAnc.DependencyChainTag = TM.DependencyChainTag
	
Where TI.LastExecutionStatus in ('Untried', 'FailedRetry', 'InProgress') 
AND TMAnc.DependencyChainTag is not null

--Delete Tasks from temp table that have incomplete dependencies 
Delete #AllTasksTobeCreated
from #AllTasksTobeCreated a
inner join #TasksToBeExcludedParent b
on a.TaskMasterId = b.TaskMasterId

Delete #AllTasksTobeCreated
from #AllTasksTobeCreated a
inner join #TasksToBeExcludedChild b
on a.TaskMasterId = b.TaskMasterId

select 
TaskMaster.*
,WaterMark.[TaskMasterWaterMarkColumn]
,WaterMark.[TaskMasterWaterMarkColumnType]
,WaterMark.[TaskMasterWaterMark_DateTime]
,WaterMark.[TaskMasterWaterMark_BigInt]
from #AllTasksTobeCreated AS TaskMaster
Left Join [dbo].[TaskMasterWaterMark] as WaterMark
On WaterMark.[TaskMasterId] = TaskMaster.[TaskMasterId]
and WaterMark.[ActiveYN] = 1
