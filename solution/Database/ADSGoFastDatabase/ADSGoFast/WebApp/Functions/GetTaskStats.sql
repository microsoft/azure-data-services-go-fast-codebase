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