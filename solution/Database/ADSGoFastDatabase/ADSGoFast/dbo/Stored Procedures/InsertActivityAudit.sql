/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

CREATE PROCEDURE [dbo].[InsertActivityAudit]
	@ActivityAuditId bigint
	,@ExecutionUid uniqueidentifier
	,@TaskInstanceId bigint
	,@AdfRunUid uniqueidentifier
	,@LogTypeId int
	,@LogSource nvarchar(50)
	,@ActivityType nvarchar(200)
	,@FileCount bigint
	,@LogDateUTC date
	,@LogDateTimeOffSet datetimeoffset(7)
	,@StartDateTimeOffSet datetimeoffset(7)
	,@EndDateTimeOffSet datetimeoffset(7)
	,@RowsInserted bigint
	,@RowsUpdated bigint
	,@Status nvarchar(50)
	,@Comment nvarchar(4000)

AS

	INSERT INTO [dbo].[ActivityAudit]
           (ActivityAuditId
           ,[ExecutionUid]
           ,[TaskInstanceId]
           ,[AdfRunUid]
           ,[LogTypeId]
           ,[LogSource]
           ,[ActivityType]
           ,[FileCount]
           ,[LogDateUTC]
           ,[LogDateTimeOffSet]
           ,[StartDateTimeOffSet]
           ,[EndDateTimeOffSet]
           ,[RowsInserted]
           ,[RowsUpdated]
           ,[Status]
           ,[Comment])
     VALUES
           (@ActivityAuditId 
           ,@ExecutionUid 
           ,@TaskInstanceId 
           ,@AdfRunUid 
           ,@LogTypeId 
           ,@LogSource 
           ,@ActivityType 
           ,@FileCount 
           ,@LogDateUTC 
           ,@LogDateTimeOffSet 
           ,@StartDateTimeOffSet 
           ,@EndDateTimeOffSet 
           ,@RowsInserted 
		   ,@RowsUpdated 
		   ,@Status 
           ,@Comment)
