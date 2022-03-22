/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

Begin TRY

--Update Tasks that have 
Update TaskInstance 
Set LastExecutionStatus = c0.LastExecutionStatus, 
    LastExecutionComment = 'Task updated by by ADF Log checker.',
    TaskRunnerId = null /*Clear the runner */, 
    NumberOfRetries = c1.NumberOfRetries
from 
TaskInstance ti 
join TaskMaster tm on tm.TaskMasterId = ti.TaskMasterId
join TaskGroup tg on tg.TaskGroupId = tm.TaskGroupId
join TaskInstanceExecution tei on ti.TaskInstanceId = tei.TaskInstanceId and ti.LastExecutionUid = tei.ExecutionUid
join {TempTable} apr on apr.TaskInstanceId = tei.TaskInstanceId and apr.ExecutionUid = tei.ExecutionUid and apr.PipelineName = tei.PipelineName
cross apply
( Select 
		LastExecutionStatus = case 
			when apr.PipelineRunStatus = 'Failed' and ti.NumberOfRetries < (tg.MaximumTaskRetries-1) then 'FailedRetry' 
			when apr.PipelineRunStatus = 'Failed' and ti.NumberOfRetries >= (tg.MaximumTaskRetries-1) then 'FailedNoRetry' 
            when apr.PipelineRunStatus = 'Cancelled' then 'FailedNoRetry' 
			else 'Succeeded' end
) c0
cross apply 
	(
		Select
		NumberOfRetries = case when apr.PipelineRunStatus = 'Failed' then (ti.NumberOfRetries) + 1 else ti.NumberOfRetries end 
	) c1
where ti.LastExecutionStatus = 'InProgress' and apr.PipelineRunStatus in ('Failed','Succeeded', 'Cancelled')

--Update TaskInstanceExecutions
Update TaskInstanceExecution 
Set 
    [Status] = c0.LastExecutionStatus, 
    EndDateTime = apr.[End], 
    Comment = 'Task updated by by ADF Log checker.'
from 
TaskInstance ti 
join TaskMaster tm on tm.TaskMasterId = ti.TaskMasterId
join TaskGroup tg on tg.TaskGroupId = tm.TaskGroupId
join TaskInstanceExecution tei on ti.TaskInstanceId = tei.TaskInstanceId and ti.LastExecutionUid = tei.ExecutionUid
join {TempTable} apr on apr.TaskInstanceId = tei.TaskInstanceId and apr.ExecutionUid = tei.ExecutionUid and apr.PipelineName = tei.PipelineName
cross apply
( Select 
		LastExecutionStatus = case 
			when apr.PipelineRunStatus = 'Failed' and ti.NumberOfRetries <  (tg.MaximumTaskRetries-1) then 'FailedRetry' 
			when apr.PipelineRunStatus = 'Failed' and ti.NumberOfRetries >=  (tg.MaximumTaskRetries-1) then 'FailedNoRetry' 
            when apr.PipelineRunStatus = 'Cancelled' then 'FailedNoRetry' 
			else 'Succeeded' end
) c0
where tei.[Status] = 'InProgress' and apr.PipelineRunStatus in ('Failed','Succeeded', 'Cancelled')


--Main Merge
MERGE dbo.ADFPipelineRun AS a  
    USING (SELECT * from {TempTable}) AS b   
    ON (b.[taskinstanceid] = a.[taskinstanceid] and b.[executionuid] = a.[executionuid] and a.EngineId = {EngineId} and a.PipelineRunUid = b.PipelineRunUid)  
    WHEN MATCHED THEN
        UPDATE SET 
            [PipelineName] = b.[PipelineName], [Start] = b.[Start], [End] = b.[End], [PipelineRunStatus] = b.[PipelineRunStatus], [MaxPipelineTimeGenerated] = b.[MaxPipelineTimeGenerated]
    WHEN NOT MATCHED THEN  
        INSERT ([TaskInstanceId], [ExecutionUid], [EngineId], [PipelineName], [PipelineRunUid],[Start], [End], [PipelineRunStatus], [MaxPipelineTimeGenerated])  
        VALUES (b.[TaskInstanceId], b.[ExecutionUid], {EngineId},b.[PipelineName],  b.[PipelineRunUid],b.[Start], b.[End], b.[PipelineRunStatus], b.[MaxPipelineTimeGenerated]);  
    

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
