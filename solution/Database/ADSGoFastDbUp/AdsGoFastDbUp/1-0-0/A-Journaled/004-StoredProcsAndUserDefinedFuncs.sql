/****** Object:  UserDefinedFunction [dbo].[GetAzureStorageListingTriggeredTasksToBeSuppressed]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  UserDefinedFunction [dbo].[GetTasksToBeAssignedToRunners]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  UserDefinedFunction [dbo].[GetTasksAssignedToRunners]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
--select * from [dbo].[GetTasksAssignedToRunners](null, 1)
CREATE Function [dbo].[GetTasksAssignedToRunners](@TaskRunnerId int = null, @IncludeInProgress bit) returns Table  
AS
RETURN
Select  b.TaskGroupId, TaskInstanceId
from [dbo].[TaskInstance] a
inner join TaskMaster b on a.TaskMasterId = b.TaskMasterId
where 
	(
		(@TaskRunnerId is null and a.TaskRunnerId is not null) 
		or 
		(@TaskRunnerId = a.TaskRunnerId)
	)
	and 
	(
		(LastExecutionStatus in ('Untried','FailedRetry') and @IncludeInProgress = 0)
		or 
		(LastExecutionStatus in ('Untried','FailedRetry', 'InProgress') and @IncludeInProgress = 1)
	)
GO
/****** Object:  UserDefinedFunction [WebApp].[GetTaskStats]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--select * from [WebApp].[GetTaskStats](2, null, 2, null)
CREATE function [WebApp].[GetTaskStats](@GroupByLevel tinyint, @TaskGroupId BigInt = null, @TaskMasterId BigInt = null, @TaskInstanceId BigInt = null) returns table as
return
(
Select 
	c1.TaskGroupId,
	c1.TaskGroupName,
	c1.TaskMasterId,
	c1.TaskMasterName,
	c1.TaskInstanceId,
	c1.ScheduledDateTime ,
	count(distinct tm.TaskMasterId) Tasks,
	count(distinct ti.TaskInstanceId) TaskInstances,
	count(distinct sm.ScheduleMasterId) Schedules,
	count(distinct si.ScheduleInstanceId) ScheduleInstances,
	count(distinct cast(tei.ExecutionUid as varchar(200))+cast(tei.TaskInstanceId as varchar(200))) Executions,
	sum(aps.TotalCost) EstimatedCost,
	sum(aps.rowsCopied) RowsCopied,
	sum(aps.DataRead) DataRead,
	sum(aps.DataWritten) DataWritten
from 	
	TaskGroup tg
	left join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
	left join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
	left join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId
	left join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
	left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	left join ADFPipelineStats aps on aps.TaskInstanceId = ti.TaskInstanceId
cross apply 
(
Select 
	TaskGroupId = case when @GroupByLevel >= 0 then tg.TaskGroupId else null end,
	TaskGroupName = case when @GroupByLevel >= 0 then tg.TaskGroupName else null end,
	TaskMasterId = case when @GroupByLevel >= 1 then tm.TaskMasterId else null end,
	TaskMasterName = case when @GroupByLevel >= 1 then tm.TaskMasterName else null end, 
	TaskInstanceId = case when @GroupByLevel >= 2 then ti.TaskInstanceId else null end,
	ScheduledDateTime = case when @GroupByLevel >= 2 then si.ScheduledDateTimeOffset else null end
) c1
where tg.TaskGroupId = isnull(@TaskGroupId,tg.TaskGroupId)
group by 
	c1.TaskGroupId,
	c1.TaskGroupName,
	c1.TaskMasterId,
	c1.TaskMasterName,
	c1.TaskInstanceId,
	c1.ScheduledDateTime 
)
GO
/****** Object:  StoredProcedure [dbo].[DistributeTasksToRunnners]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DistributeTasksToRunnners](@systemwideconcurrency integer) as
BEGIN
	DROP TABLE IF EXISTS #NewTasks
	Select TaskGroupId, NewTasks = Count(distinct TaskInstanceId), 0 as TasksAssigned
	into #NewTasks
	from [dbo].[GetTasksToBeAssignedToRunners]()
	Group by TaskGroupId, TaskGroupPriority

	DROP TABLE IF EXISTS #AssignedTasks
	Select TaskGroupId, 0 NewTasks, count(TaskInstanceId) TasksAssigned
	into #AssignedTasks
	from
		[dbo].[GetTasksAssignedToRunners](null,1)
	group by TaskGroupId

	DROP TABLE IF EXISTS #NewAndAssigned
	Select TaskGroupId, sum(NewTasks) NewTasks, sum(TasksAssigned) TasksAssigned
	into #NewAndAssigned
	from
		(
				Select TaskGroupId, NewTasks, 0 TasksAssigned
			from #NewTasks
		union all

			Select TaskGroupId, 0 NewTasks, TasksAssigned
			from #AssignedTasks 	
		) a
	Group by TaskGroupId

	Declare @TasksRunning int = (Select top 1 TasksAssigned from #NewAndAssigned)
	Declare @TasksToRun int = (Select top 1 NewTasks from #NewAndAssigned)

	DROP TABLE IF EXISTS #SummaryByTaskGroup
	Select TG.*,
		NewTasks TaskCount,
		TasksAssigned,
		ConcurrencySlotsAvailableInGroup = TaskGroupConcurrency - TasksAssigned,
		PercOfMaxConcurrencyConsumed = cast(TasksAssigned as numeric(18,4))/cast(TaskGroupConcurrency as numeric(18,4))
	into #SummaryByTaskGroup
	from TaskGroup TG
		inner join #NewAndAssigned NA on NA.TaskGroupId = TG.TaskGroupId
	where NewTasks > 0
	order by TaskGroupPriority, cast(TasksAssigned as numeric(18,4))/cast(TaskGroupConcurrency as numeric(18,4))

	DROP TABLE IF EXISTS #SystemWideView
	Select c0.*,
		c1.AdjustedSlotsToBeAssigned,
		SlotsToBeAssignedPerGroup = case when c0.TaskGroups = 0 then 0
									else 
									case 
										when floor(c1.AdjustedSlotsToBeAssigned/ c0.TaskGroups) = 0 then 1 
										else floor(c1.AdjustedSlotsToBeAssigned/ c0.TaskGroups) 
									end
									end
	into #SystemWideView
	from
		(Select 1 as dummy) d
		cross apply
		(
			Select 
			SlotsConsumed = isnull(sum(TasksAssigned),0),
			isnull(sum(ConcurrencySlotsAvailableInGroup),0) AdditionalSlotsAvailable,
			isnull(count(TaskGroupId),0) TaskGroups,
			@systemwideconcurrency SystemWideConcurrency
			from #SummaryByTaskGroup
		) c0
		cross apply
		(
			Select AdjustedSlotsToBeAssigned = case when (c0.SlotsConsumed + c0.AdditionalSlotsAvailable) >= @systemwideconcurrency then (@systemwideconcurrency-SlotsConsumed) else c0.AdditionalSlotsAvailable end
		) c1

	DROP TABLE IF EXISTS #NewAllocationsByTaskGroup
	Select
		tg.TaskGroupId,
		tg.TaskGroupPriority,
		tg.TaskCount NewTasks,
		SlotsToBeAssignedPerGroup,
		c0.NewSlotAllocation,
		UsedSlotAllocation = case when tg.TaskCount <= c0.NewSlotAllocation then tg.TaskCount else c0.NewSlotAllocation end,
		SystemWideSlots = AdjustedSlotsToBeAssigned,
		GroupOrder = ROW_NUMBER() over (order by tg.TaskGroupPriority, PercOfMaxConcurrencyConsumed)
	into #NewAllocationsByTaskGroup
	from
		#SystemWideView sw cross join 
		#SummaryByTaskGroup tg
	cross apply
		(Select NewSlotAllocation = case when sw.SlotsToBeassignedPerGroup <= tg.ConcurrencySlotsAvailableInGroup 
						then  sw.SlotsToBeassignedPerGroup else tg.ConcurrencySlotsAvailableInGroup end) c0


	DROP TABLE IF EXISTS #NewAllocationsByTaskGroupWithRSum
	select
		x1.*,
		RsumUsedSlotAllocation=(select sum(UsedSlotAllocation)
									from #NewAllocationsByTaskGroup as x2
									where x2.GroupOrder <= x1.GroupOrder)
	into #NewAllocationsByTaskGroupWithRSum
	from #NewAllocationsByTaskGroup x1
	order by GroupOrder



	DROP TABLE IF EXISTS #FinalTaskGroups
	Select
		*
	into #FinalTaskGroups
	from
		#NewAllocationsByTaskGroupWithRSum
	where RsumUsedSlotAllocation <= SystemWideSlots

	DROP TABLE IF EXISTS #FinalTaskGroups_WithTaskInstances
	Select 
		*,
		TaskOrder = ROW_NUMBER() over (partition by TaskGroupId order by TaskInstanceId)  
	into #FinalTaskGroups_WithTaskInstances
	from 
	(
	Select 
		ftg.taskgroupid,
		ftg.TaskGroupPriority, 
		nt.TaskInstanceId,
		UsedSlotAllocation	
	from 
	[dbo].[GetTasksToBeAssignedToRunners]() nt
	inner join #FinalTaskGroups ftg on nt.TaskGroupId = ftg.TaskGroupId
	) a

	DROP TABLE IF EXISTS #SeqencedRunners
	Select 
		TaskRunnerId, 
		RunnerSequenceNumber = ROW_NUMBER() OVER (Order by TaskRunnerId)  
	into #SeqencedRunners
	from FrameworkTaskRunner where ActiveYN = 1

	DROP TABLE IF EXISTS #TasksToUpdate
	DECLARE @TaskRunners as int = ((Select count(*) from #SeqencedRunners))
	Select 
		TaskInstanceId,
		NTILE(@TaskRunners) OVER(ORDER BY TaskInstanceId) as RunnerSequenceNumber
	into #TasksToUpdate
	from
	#FinalTaskGroups_WithTaskInstances
	where UsedSlotAllocation >=  TaskOrder

	DROP TABLE IF EXISTS #TasksToUpdate_WithRunnerId
	Select ttu.*,sr.TaskRunnerId 
	into  #TasksToUpdate_WithRunnerId
	from #TasksToUpdate ttu
	inner join #SeqencedRunners sr on sr.RunnerSequenceNumber = ttu.RunnerSequenceNumber


	Update dbo.TaskInstance
	Set TaskRunnerId = ttu.TaskRunnerId
	from dbo.TaskInstance ti 
	inner join #TasksToUpdate_WithRunnerId ttu on ttu.TaskInstanceId = ti.TaskInstanceId


	Select * from #SystemWideView
	
	

END
GO
/****** Object:  StoredProcedure [dbo].[GetFrameworkTaskRunners]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE procedure [dbo].[GetFrameworkTaskRunners] as 

declare @Output as Table (TaskRunnerId int)

Update FrameworkTaskRunner
Set Status = 'Running', LastExecutionStartDateTime = GETUTCDATE()
OUTPUT inserted.TaskRunnerId into @Output (TaskRunnerId)
where ActiveYN = 1 and Status = 'Idle'

Select FTR.* from FrameworkTaskRunner FTR inner join @Output O on O.TaskRunnerId = FTR.TaskRunnerId
GO
/****** Object:  StoredProcedure [dbo].[GetTaskGroups]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


CREATE procedure [dbo].[GetTaskGroups]
as
BEGIN
With 
NewTasks as 
(
	Select TaskGroupId, NewTasks = Count(distinct TaskInstanceId), 0 as TasksAssigned
	from [dbo].[GetTasksToBeAssignedToRunners]()
	Group by TaskGroupId, TaskGroupPriority
), 
AssignedTasks as 
(
	Select TaskGroupId, 0 NewTasks, count(TaskInstanceId) TasksAssigned
	from 
	[dbo].[GetTasksAssignedToRunners](null,1)
	group by TaskGroupId
), 
NewAndAssigned as 
(
	Select TaskGroupId, sum(NewTasks) NewTasks, sum(TasksAssigned) TasksAssigned 
	from 
	(
	Select TaskGroupId, NewTasks, 0 TasksAssigned from NewTasks 	
	union all 
	Select TaskGroupId, 0 NewTasks, TasksAssigned from AssignedTasks 	
	) a	
	Group by TaskGroupId
) 

Select	TG.*,  
		NewTasks TaskCount--,  
		--TasksAssigned, 
		--ConcurrencySlotsAvailableInGroup = TaskGroupConcurrency - TasksAssigned,
		--PercOfMaxConcurrencyConsumed = cast(TasksAssigned as numeric(18,4))/cast(TaskGroupConcurrency as numeric(18,4))
from TaskGroup TG
inner join NewAndAssigned NA on NA.TaskGroupId = TG.TaskGroupId
where NewTasks > 0
order by cast(TasksAssigned as numeric(18,4))/cast(TaskGroupConcurrency as numeric(18,4)) 
END
GO
/****** Object:  StoredProcedure [dbo].[GetTaskInstanceJSON]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


--[dbo].[GetTaskInstanceJSON] 2,1000

CREATE proc [dbo].[GetTaskInstanceJSON] (@TaskRunnerId int, @ExecutionUid uniqueidentifier )
as
BEGIN 

--TODO - Wrap in transaction
Declare @TasksInProgress as table (TaskInstanceId bigint)

Update [dbo].[TaskInstance]
Set LastExecutionStatus='InProgress', 
	LastExecutionUid = @ExecutionUid, 
	LastExecutionComment = 'Task Picked Up For Execution by Runner ' + cast(@TaskRunnerId as varchar(20)),
	UpdatedOn = GETUTCDATE()
OUTPUT inserted.TaskInstanceId
INTO @TasksInProgress
from [dbo].[TaskInstance] a
inner join 
[dbo].[GetTasksAssignedToRunners](@TaskRunnerId, 0) b on a.TaskInstanceId = b.TaskInstanceId


SELECT 	
	TI.TaskInstanceId,
	TI.ADFPipeline,
	TI.NumberOfRetries,
	TI.TaskInstanceJson,
	SI.ScheduleMasterId, 
	TI.LastExecutionStatus as TaskStatus,
	tt.TaskTypeId as TaskTypeId,
	tt.TaskTypeName as TaskType,
	tt.TaskExecutionType,
	EF.DefaultKeyVaultURL as KeyVaultBaseUrl,
	EF.EngineId as EngineId,
	EF.EngineName as EngineName,
	EF.SystemType as EngineSystemType,
	EF.ResourceGroup as EngineResourceGroup,
	EF.SubscriptionUid as EngineSubscriptionId,
	EF.EngineJson as EngineJson, 
	TM.TaskMasterJSON,
	TM.TaskMasterId,
	TM.DegreeOfCopyParallelism,
	TG.TaskGroupConcurrency,
	TG.TaskGroupPriority,
	TM.TaskDatafactoryIR,

	--SOURCE
	SS.SystemId as SourceSystemId,
	SS.SystemJSON as SourceSystemJSON,
	SS.SystemType as SourceSystemType,
	SS.SystemServer as SourceSystemServer,
	SS.SystemKeyVaultBaseUrl as SourceKeyVaultBaseUrl,
	SS.SystemAuthType as SourceSystemAuthType,
	SS.SystemSecretName as SourceSystemSecretName,
	SS.SystemUserName as SourceSystemUserName,
	
	--TARGET
	TS.SystemId as TargetSystemId,
	TS.SystemJSON as TargetSystemJSON,
	TS.SystemType as TargetSystemType,
	TS.SystemServer as TargetSystemServer,
	TS.SystemKeyVaultBaseUrl as TargetKeyVaultBaseUrl,
	TS.SystemAuthType as TargetSystemAuthType,
	TS.SystemSecretName as TargetSystemSecretName,
	TS.SystemUserName as TargetSystemUserName


FROM 
@TasksInProgress TIP
INNER JOIN [dbo].[TaskInstance] TI on TIP.TaskInstanceId = TI.TaskInstanceId
INNER JOIN [dbo].[ScheduleInstance] SI ON TI.ScheduleInstanceId = SI.ScheduleInstanceId
INNER JOIN [dbo].[TaskMaster] TM ON TI.TaskMasterID = TM.TaskMasterID
	--AND TM.ActiveYN = 1
INNER JOIN [dbo].[TaskType] tt on tt.TaskTypeId = TM.TaskTypeId
INNER JOIN [dbo].[TaskGroup] TG ON TM.TaskGroupId = TG.TaskGroupId
	--AND TG.ActiveYN = 1
INNER JOIN [dbo].[SourceAndTargetSystems] SS ON SS.SystemId = TM.[SourceSystemId]
	--AND SS.ActiveYN = 1
INNER JOIN [dbo].[SourceAndTargetSystems] TS ON TS.SystemId = TM.TargetSystemId
	--AND TS.ActiveYN = 1
INNER JOIN [dbo].[ExecutionEngine] EF on EF.EngineId = TM.EngineId



END
GO
/****** Object:  StoredProcedure [dbo].[GetTaskMaster]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
/****** Object:  StoredProcedure [dbo].[InsertActivityAudit]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[InsertActivityAudit]
	@ActivityAuditId bigint
	,@ExecutionUid uniqueidentifier
	,@TaskInstanceId bigint
	,@AdfRunUid uniqueidentifier
	,@LogTypeId int
	,@LogSource nvarchar(50)
	,@ActivityType nvarchar(200)
	,@FileCount bigint
	,@LogDateUTC date
	,@LogDateTimeOffSet datetimeoffset(7)
	,@StartDateTimeOffSet datetimeoffset(7)
	,@EndDateTimeOffSet datetimeoffset(7)
	,@RowsInserted bigint
	,@RowsUpdated bigint
	,@Status nvarchar(50)
	,@Comment nvarchar(4000)

AS

	INSERT INTO [dbo].[ActivityAudit]
           (ActivityAuditId
           ,[ExecutionUid]
           ,[TaskInstanceId]
           ,[AdfRunUid]
           ,[LogTypeId]
           ,[LogSource]
           ,[ActivityType]
           ,[FileCount]
           ,[LogDateUTC]
           ,[LogDateTimeOffSet]
           ,[StartDateTimeOffSet]
           ,[EndDateTimeOffSet]
           ,[RowsInserted]
           ,[RowsUpdated]
           ,[Status]
           ,[Comment])
     VALUES
           (@ActivityAuditId 
           ,@ExecutionUid 
           ,@TaskInstanceId 
           ,@AdfRunUid 
           ,@LogTypeId 
           ,@LogSource 
           ,@ActivityType 
           ,@FileCount 
           ,@LogDateUTC 
           ,@LogDateTimeOffSet 
           ,@StartDateTimeOffSet 
           ,@EndDateTimeOffSet 
           ,@RowsInserted 
		   ,@RowsUpdated 
		   ,@Status 
           ,@Comment)
GO
/****** Object:  StoredProcedure [dbo].[UpdFrameworkTaskRunner]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
Create procedure [dbo].[UpdFrameworkTaskRunner] (@TaskRunnerId as int) as 
Update FrameworkTaskRunner
Set Status = 'Idle', LastExecutionEndDateTime = GETUTCDATE()
GO
/****** Object:  StoredProcedure [dbo].[UpdTaskInstanceExecution]    Script Date: 3/03/2022 1:10:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE procedure [dbo].[UpdTaskInstanceExecution] (@ExecutionStatus varchar(200), @TaskInstanceId bigint, @ExecutionUid uniqueidentifier, @AdfRunUid uniqueidentifier = null, @Comment varchar(255) = '')
as
Begin 

	Update [dbo].[TaskInstance] 
	SET LastExecutionStatus = c0.LastExecutionStatus, 		
		TaskRunnerId = Null, 
		LastExecutionComment = @Comment,
		UpdatedOn = GETUTCDATE(), 
		NumberOfRetries = c1.NumberOfRetries
	from [dbo].[TaskInstance] ti 
	join TaskMaster tm on tm.TaskMasterId = ti.TaskMasterId
	join TaskGroup tg on tg.TaskGroupId = tm.TaskGroupId
	cross apply 
	(
		Select
		LastExecutionStatus = 
			case 
				when @ExecutionStatus like 'Failed%' and ti.NumberOfRetries <  (tg.MaximumTaskRetries-1) then 'FailedRetry' 
				when @ExecutionStatus  like 'Failed%' and ti.NumberOfRetries >=  (tg.MaximumTaskRetries-1) then 'FailedNoRetry' 
				when @ExecutionStatus  = 'FailedNoRetry' then 'FailedNoRetry' 
				else @ExecutionStatus end
	) c0
	cross apply 
	(
		Select
		NumberOfRetries = case when @ExecutionStatus like 'Failed%' then (ti.NumberOfRetries + 1) else ti.NumberOfRetries end 
	) c1
	Where ti.TaskInstanceId = @TaskInstanceId                    
	
	--If the schedule is RunOnceOnly then Set Task to Inactive once complete or FailedNoRetry
	UPDATE dbo.TaskMaster 
		SET ActiveYN = 0
	FROM dbo.TaskMaster TM
	INNER JOIN  dbo.TaskInstance  TI
	ON TM.TaskMasterId = TI.TaskMasterId
	INNER JOIN dbo.ScheduleMaster SM
	ON SM.ScheduleMasterId = TM.ScheduleMasterId
	AND SM.ScheduleDesciption = 'Run Once Only'
	WHERE TI.TaskInstanceId = @TaskInstanceId
	and @ExecutionStatus in ('Complete', 'FailedNoRetry')

	UPDATE [dbo].[TaskInstanceExecution]
	SET [Status] = @ExecutionStatus, 
		EndDateTime = GetDate(), 
		AdfRunUid = @AdfRunUid
	Where TaskInstanceId = @TaskInstanceId and ExecutionUid = @ExecutionUid




END
GO
