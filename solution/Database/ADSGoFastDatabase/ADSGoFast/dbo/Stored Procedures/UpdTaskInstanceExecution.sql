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
