/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


CREATE procedure [dbo].[GetTaskGroups]
as
BEGIN
With 
NewTasks as 
(
	Select TaskGroupId, NewTasks = Count(distinct TaskInstanceId), 0 as TasksAssigned
	from [dbo].[GetTasksToBeAssignedToRunners]()
	Group by TaskGroupId, TaskGroupPriority
), 
AssignedTasks as 
(
	Select TaskGroupId, 0 NewTasks, count(TaskInstanceId) TasksAssigned
	from 
	[dbo].[GetTasksAssignedToRunners](null,1)
	group by TaskGroupId
), 
NewAndAssigned as 
(
	Select TaskGroupId, sum(NewTasks) NewTasks, sum(TasksAssigned) TasksAssigned 
	from 
	(
	Select TaskGroupId, NewTasks, 0 TasksAssigned from NewTasks 	
	union all 
	Select TaskGroupId, 0 NewTasks, TasksAssigned from AssignedTasks 	
	) a	
	Group by TaskGroupId
) 

Select	TG.*,  
		NewTasks TaskCount--,  
		--TasksAssigned, 
		--ConcurrencySlotsAvailableInGroup = TaskGroupConcurrency - TasksAssigned,
		--PercOfMaxConcurrencyConsumed = cast(TasksAssigned as numeric(18,4))/cast(TaskGroupConcurrency as numeric(18,4))
from TaskGroup TG
inner join NewAndAssigned NA on NA.TaskGroupId = TG.TaskGroupId
where NewTasks > 0
order by cast(TasksAssigned as numeric(18,4))/cast(TaskGroupConcurrency as numeric(18,4)) 
END
