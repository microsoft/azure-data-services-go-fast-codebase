/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

Begin TRY


MERGE dbo.AzureStorageListing AS a  
    USING (SELECT * from {TempTable}) AS b   
    ON (a.[PartitionKey] = b.[PartitionKey] and a.[RowKey] = b.[RowKey] and a.SystemId = b.SystemId)  
    WHEN NOT MATCHED THEN  
        INSERT ([SystemId], [PartitionKey], [RowKey], [FilePath])  
        VALUES (b.[SystemId], b.[PartitionKey], b.[RowKey], b.[FilePath]);  
    

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
