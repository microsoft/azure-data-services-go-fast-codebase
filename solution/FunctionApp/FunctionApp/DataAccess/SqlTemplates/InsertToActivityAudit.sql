/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
 
Begin TRY

    INSERT INTO dbo.ActivityAudit ([logdatetimeoffset],[logdateutc],[startdatetimeoffset],[enddatetimeoffset],[logtypeid],[executionuid],[logsource],[taskmasterid],[taskinstanceid],[adfrunuid],[activitytype],[comment],[status])
    SELECT b.[logdatetimeoffset],b.[logdateutc],b.[startdatetimeoffset],b.[enddatetimeoffset],b.[logtypeid],b.[executionuid],b.[logsource],b.[taskmasterid],b.[taskinstanceid],b.[adfrunuid],b.[activitytype],b.[comment],b.[status]
    FROM [{TempTableName}] AS b

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
