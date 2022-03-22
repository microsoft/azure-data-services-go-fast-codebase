create procedure DistributeTasksToRunnners(@systemwideconcurrency integer) as
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