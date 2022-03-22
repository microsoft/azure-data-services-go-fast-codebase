
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
	EF.ResourceGroup as EngineResourceGroup,
	EF.SubscriptionUid as EngineSubscriptionId,
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
