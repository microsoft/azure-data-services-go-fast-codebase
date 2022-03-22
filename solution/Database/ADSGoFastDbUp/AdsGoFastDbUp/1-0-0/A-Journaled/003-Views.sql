/****** Object:  View [Pbi].[ADFPipelineRun]    Script Date: 3/03/2022 12:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

CREATE view [Pbi].[ADFPipelineRun] as 
select
	b.TaskInstanceId, 
	b.ExecutionUid, 
	b.EngineId, 
	b.PipelineRunUid, 
	b.[Start], 
	b.[End],
	b.PipelineRunStatus,
	b.MaxPipelineTimeGenerated,		
	a.Activities						   ,
	a.TotalCost							   ,
	a.CloudOrchestrationCost			   ,
	a.SelfHostedOrchestrationCost		   ,
	a.SelfHostedDataMovementCost		   ,
	a.SelfHostedPipelineActivityCost	   ,
	a.CloudPipelineActivityCost			   ,
	a.rowsCopied						   ,
	a.dataRead							   ,
	a.dataWritten						   ,
	a.TaskExecutionStatus				   ,
	a.FailedActivities					   ,
	a.MaxActivityTimeGenerated
from dbo.ADFActivityRun a
join dbo.ADFPipelineRun b on a.PipelineRunUid = b.PipelineRunUid
GO
/****** Object:  View [Pbi].[ADFPipelineStats]    Script Date: 3/03/2022 12:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
create view [Pbi].[ADFPipelineStats] as
select a.ExecutionUid, a.TaskInstanceId, a.PipelineRunStatus,  b.* 
from ADFPipelineRun a 
left join ADFActivityRun b on a.EngineId = b.EngineId and a.PipelineRunUid = b.PipelineRunUid
GO
/****** Object:  View [Pbi].[TaskInstanceAndScheduleInstance]    Script Date: 3/03/2022 12:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
create view [Pbi].[TaskInstanceAndScheduleInstance] as 
Select a.*, b.ScheduledDateUtc, b.ScheduledDateTimeOffset from dbo.TaskInstance a join dbo.ScheduleInstance b on a.ScheduleInstanceId = b.ScheduleInstanceId
GO
/****** Object:  View [WebApp].[TaskGroupStats]    Script Date: 3/03/2022 12:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [WebApp].[TaskGroupStats] as
Select 
	tg.TaskGroupId,
	tg.TaskGroupName, 
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
group by Tg.TaskGroupId, Tg.TaskGroupName
GO
/****** Object:  View [WebApp].[TaskMasterStats]    Script Date: 3/03/2022 12:56:03 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
GO
