/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
 
Begin TRY

--Truncate TargetTable
TRUNCATE TABLE {TargetFullName}

--Insert all records from Source Table Into Target Table
insert into {TargetFullName}
(
{InsertList}
)
Select
{InsertList}
from
{SourceFullName}
 
END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
