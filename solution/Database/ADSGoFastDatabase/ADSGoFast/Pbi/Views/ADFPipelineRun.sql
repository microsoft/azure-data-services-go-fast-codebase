
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
