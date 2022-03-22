/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
 
Begin TRY


MERGE [dbo].[TaskMaster] AS a  
    USING (SELECT * from [{TempTableName}]) AS b   
    ON (a.TaskMasterName = b.TaskMasterName and a.TaskGroupId = b.TaskGroupId and a.TaskTypeId = b.TaskTypeId)  
    WHEN MATCHED THEN
        UPDATE SET [taskmastername] = b.[taskmastername],[tasktypeid] = b.[tasktypeid],[taskgroupid] = b.[taskgroupid],[schedulemasterid] = b.[schedulemasterid],[sourcesystemid] = b.[sourcesystemid],[targetsystemid] = b.[targetsystemid],[degreeofcopyparallelism] = b.[degreeofcopyparallelism],[allowmultipleactiveinstances] = b.[allowmultipleactiveinstances],[taskdatafactoryir] = b.[taskdatafactoryir],[activeyn] = b.[activeyn],[dependencychaintag] = b.[dependencychaintag],[engineid] = b.[engineid],[taskmasterjson] = b.[taskmasterjson]  
    WHEN NOT MATCHED THEN  
        INSERT ([taskmastername],[tasktypeid],[taskgroupid],[schedulemasterid],[sourcesystemid],[targetsystemid],[degreeofcopyparallelism],[allowmultipleactiveinstances],[taskdatafactoryir],[activeyn],[dependencychaintag],[engineid],[taskmasterjson])  
        VALUES (b.[taskmastername],b.[tasktypeid],b.[taskgroupid],b.[schedulemasterid],b.[sourcesystemid],b.[targetsystemid],b.[degreeofcopyparallelism],b.[allowmultipleactiveinstances],b.[taskdatafactoryir],b.[activeyn],b.[dependencychaintag],b.[engineid],b.[taskmasterjson]);  
    

END TRY
 
Begin Catch

  -- Raise an error with the details of the exception
  DECLARE @ErrMsg nvarchar(4000), @ErrSeverity int
  SELECT @ErrMsg = ERROR_MESSAGE(),
         @ErrSeverity = ERROR_SEVERITY()
 
  RAISERROR(@ErrMsg, @ErrSeverity, 1)
 
End Catch
