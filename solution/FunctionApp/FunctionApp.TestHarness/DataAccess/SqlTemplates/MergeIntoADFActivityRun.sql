/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

Begin TRY


MERGE dbo.ADFActivityRun AS a  
    USING (SELECT * from {TempTable}) AS b   
    ON (b.[PipelineRunUid] = a.[PipelineRunUid])  
    WHEN MATCHED THEN
        UPDATE SET 
            [activities] = b.[activities],[totalcost] = b.[totalcost],[cloudorchestrationcost] = b.[cloudorchestrationcost],[selfhostedorchestrationcost] = b.[selfhostedorchestrationcost],[selfhosteddatamovementcost] = b.[selfhosteddatamovementcost],[selfhostedpipelineactivitycost] = b.[selfhostedpipelineactivitycost],[cloudpipelineactivitycost] = b.[cloudpipelineactivitycost],[rowscopied] = b.[rowscopied],[dataread] = b.[dataread],[datawritten] = b.[datawritten],[failedactivities] = b.[failedactivities], [MaxActivityTimeGenerated] = b.[MaxActivityTimeGenerated]
    WHEN NOT MATCHED THEN  
        INSERT ([PipelineRunUid],[EngineId], [activities],[totalcost],[cloudorchestrationcost],[selfhostedorchestrationcost],[selfhosteddatamovementcost],[selfhostedpipelineactivitycost],[cloudpipelineactivitycost],[rowscopied],[dataread],[datawritten],[failedactivities], [MaxActivityTimeGenerated])  
        VALUES (b.[PipelineRunUid],{EngineId}, b.[activities],b.[totalcost],b.[cloudorchestrationcost],b.[selfhostedorchestrationcost],b.[selfhosteddatamovementcost],b.[selfhostedpipelineactivitycost],b.[cloudpipelineactivitycost],b.[rowscopied],b.[dataread],b.[datawritten],b.[failedactivities], b.[MaxActivityTimeGenerated]);  
    

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
