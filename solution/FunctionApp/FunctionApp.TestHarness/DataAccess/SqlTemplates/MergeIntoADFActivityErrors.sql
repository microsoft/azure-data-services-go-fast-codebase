/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/



Begin TRY

delete dbo.AdfActivityErrors
from dbo.AdfActivityErrors a
inner join 
 {TempTable} b on a.TimeGenerated = b.TimeGenerated

insert into dbo.AdfActivityErrors
(
     [EngineId]
    ,[TenantId]
    ,[SourceSystem]
    ,[TimeGenerated]
    ,[ResourceId]
    ,[OperationName]
    ,[Category]
    ,[CorrelationId]
    ,[Level]
    ,[Location]
    ,[Tags]
    ,[Status]
    ,[UserProperties]
    ,[Annotations]
    ,[EventMessage]
    ,[Start]
    ,[ActivityName]
    ,[ActivityRunId]
    ,[PipelineRunId]
    ,[EffectiveIntegrationRuntime]
    ,[ActivityType]
    ,[ActivityIterationCount]
    ,[LinkedServiceName]
    ,[End]
    ,[FailureType]
    ,[PipelineName]
    ,[Input]
    ,[Output]
    ,[ErrorCode]
    ,[ErrorMessage]
    ,[Error]
    ,[Type]
)
Select 
    {EngineId}
    ,[TenantId]
    ,[SourceSystem]
    ,[TimeGenerated]
    ,[ResourceId]
    ,[OperationName]
    ,[Category]
    ,[CorrelationId]
    ,[Level]
    ,[Location]
    ,[Tags]
    ,[Status]
    ,[UserProperties]
    ,[Annotations]
    ,[EventMessage]
    ,[Start]
    ,[ActivityName]
    ,[ActivityRunId]
    ,[PipelineRunId]
    ,[EffectiveIntegrationRuntime]
    ,[ActivityType]
    ,[ActivityIterationCount]
    ,[LinkedServiceName]
    ,[End]
    ,[FailureType]
    ,[PipelineName]
    ,[Input]
    ,[Output]
    ,[ErrorCode]
    ,[ErrorMessage]
    ,[Error]
    ,[Type]
from  {TempTable}
   

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
