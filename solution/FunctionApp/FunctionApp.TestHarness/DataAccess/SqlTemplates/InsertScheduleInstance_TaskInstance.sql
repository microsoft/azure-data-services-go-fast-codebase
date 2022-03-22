/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
 
Begin TRY

DECLARE @tmpOutPut table( ScheduleInstanceId bigint,  
                           ScheduleMasterId bigint); 

INSERT INTO [dbo].[ScheduleInstance] ([schedulemasterid],[scheduleddateutc],[scheduleddatetimeoffset],[activeyn])
  OUTPUT INSERTED.ScheduleInstanceId,   
         INSERTED.ScheduleMasterId
  INTO @tmpOutPut
SELECT [schedulemasterid],[scheduleddateutc],[scheduleddatetimeoffset],[activeyn]
FROM {tmpScheduleInstance}


INSERT INTO [dbo].[TaskInstance] ([executionuid],[taskmasterid],[scheduleinstanceid],[adfpipeline],[taskinstancejson],[lastexecutionstatus],[activeyn])
SELECT [executionuid],tmpTI.[taskmasterid],B.[scheduleinstanceid],[adfpipeline],[taskinstancejson],[lastexecutionstatus],tmpTI.[activeyn]
FROM {tmpTaskInstance} tmpTI
INNER JOIN [dbo].[TaskMaster] TM
on TM.TaskMasterId = tmpTI.TaskMasterId
INNER JOIN @tmpOutPut B
ON B.ScheduleMasterId = TM.ScheduleMasterId

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
