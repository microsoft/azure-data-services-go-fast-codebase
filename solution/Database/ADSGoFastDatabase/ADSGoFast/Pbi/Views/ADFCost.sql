/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
--Create view [Pbi].[ADFCost]
--as
--select 
--	PR.PipelineName As ParentPipelineName
--	,PR.ExecutionUid
--	,PR.TaskInstanceId
--	,PR.TaskMasterId
--	,PR.RunId
--	,PR.DurationInMs As ParentDurationInMs
--	,PR.RunStart
--	,PR.RunEnd
--	,PR.Status As ParentStatus
--	,AC.ActivityName
--	,AC.PipelineName
--	,AC.ActivityType
--	,AC.DurationInMs
--	,AC.ActivityRunStart
--	,AC.ActivityRunEnd
--	,AC.Status
--	,JSON_VALUE(AC.OutPut,'$.effectiveIntegrationRuntime') as effectiveIntegrationRuntime 
--	,JSON_VALUE(AC.OutPut,'$.billingReference.billableDuration[0].meterType') as meterType
--	,JSON_VALUE(AC.OutPut,'$.billingReference.billableDuration[0].duration') as duration
--	,JSON_VALUE(AC.OutPut,'$.billingReference.billableDuration[0].unit') as unit
--	,AP_Orch.Price as OrchestrationCost
--	,AP_Exec.Price * JSON_VALUE(AC.OutPut,'$.billingReference.billableDuration[0].duration') as ExecutionCost
--from 
--	dbo.ADFPipelineRun PR

--	LEFT JOIN dbo.ADFActivity AC
--	On PR.RunId = AC.RunId

--	LEFT JOIN dbo.ADFPrice AP_Orch
--	ON COALESCE(JSON_VALUE(AC.OutPut,'$.billingReference.billableDuration[0].meterType'),'AzureIR') = AP_Orch.IntegrationRunTime
--	AND AP_Orch.Type = 'Orchestration'

--	LEFT JOIN dbo.ADFPrice AP_Exec
--	ON JSON_VALUE(AC.OutPut,'$.billingReference.billableDuration[0].meterType') = AP_Exec.IntegrationRunTime
--	AND (
--			(AC.ActivityType = 'Copy' and AP_Exec.Type = 'Execution-Data movement activities')
--			OR
--			(AC.ActivityType != 'Copy' and AP_Exec.Type = 'Execution-Pipeline activities')
--		)
