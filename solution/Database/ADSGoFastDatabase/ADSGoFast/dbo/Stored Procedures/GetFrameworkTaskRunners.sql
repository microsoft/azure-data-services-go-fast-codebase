/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE procedure [dbo].[GetFrameworkTaskRunners] as 

declare @Output as Table (TaskRunnerId int)

Update FrameworkTaskRunner
Set Status = 'Running', LastExecutionStartDateTime = GETUTCDATE()
OUTPUT inserted.TaskRunnerId into @Output (TaskRunnerId)
where ActiveYN = 1 and Status = 'Idle'

Select FTR.* from FrameworkTaskRunner FTR inner join @Output O on O.TaskRunnerId = FTR.TaskRunnerId
