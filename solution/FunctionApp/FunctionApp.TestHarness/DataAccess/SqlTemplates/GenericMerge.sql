/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
 
Begin TRY


MERGE {TargetFullName} AS a  
    USING (SELECT * from {SourceFullName}) AS b   
    ON ({PrimaryKeyJoin_AB})  
    WHEN MATCHED THEN
        UPDATE SET {UpdateClause}  
    WHEN NOT MATCHED THEN  
        INSERT ({InsertList})  
        VALUES ({SelectListForInsert});  
    

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
