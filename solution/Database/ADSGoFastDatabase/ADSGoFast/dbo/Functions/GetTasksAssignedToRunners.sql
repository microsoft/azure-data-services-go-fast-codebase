/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
--select * from [dbo].[GetTasksAssignedToRunners](null, 1)
CREATE Function [dbo].[GetTasksAssignedToRunners](@TaskRunnerId int = null, @IncludeInProgress bit) returns Table  
AS
RETURN
Select  b.TaskGroupId, TaskInstanceId
from [dbo].[TaskInstance] a
inner join TaskMaster b on a.TaskMasterId = b.TaskMasterId
where 
	(
		(@TaskRunnerId is null and a.TaskRunnerId is not null) 
		or 
		(@TaskRunnerId = a.TaskRunnerId)
	)
	and 
	(
		(LastExecutionStatus in ('Untried','FailedRetry') and @IncludeInProgress = 0)
		or 
		(LastExecutionStatus in ('Untried','FailedRetry', 'InProgress') and @IncludeInProgress = 1)
	)
