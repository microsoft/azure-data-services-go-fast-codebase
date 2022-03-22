create view [WebApp].[TaskMasterStats] as
Select 
	tg.TaskGroupId,
	tg.TaskGroupName, 
	tm.TaskMasterId, 
	tm.TaskMasterName, 
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
	join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
	left join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
	left join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId
	left join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
	left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	left join ADFPipelineStats aps on aps.TaskInstanceId = ti.TaskInstanceId
group by 
	Tg.TaskGroupId, 
	Tg.TaskGroupName,
	tm.TaskMasterId, 
	tm.TaskMasterName