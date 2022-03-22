/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/



Begin TRY

delete dbo.ActivityLevelLogs
from dbo.ActivityLevelLogs a
inner join 
 {TempTable} b on a.[timestamp] = b.[timestamp]

insert into dbo.ActivityLevelLogs
(
[timestamp]
,[operation_Id]
,[operation_Name]
,[severityLevel]
,[ExecutionUid]
,[TaskInstanceId]
,[ActivityType]
,[LogSource]
,[LogDateUTC]
,[LogDateTimeOffset]
,[Status]
,[TaskMasterId]
,[Comment]
,[message]
)
Select 
[timestamp]
,[operation_Id]
,[operation_Name]
,[severityLevel]
,[ExecutionUid]
,[TaskInstanceId]
,[ActivityType]
,[LogSource]
,[LogDateUTC]
,[LogDateTimeOffset]
,[Status]
,[TaskMasterId]
,[Comment]
,[message]
from  {TempTable}
   

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
