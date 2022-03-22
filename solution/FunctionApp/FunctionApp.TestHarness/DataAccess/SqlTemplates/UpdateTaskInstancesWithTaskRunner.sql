/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
Declare @TotalConcurrencySlots numeric(18,4), @ActiveRunners int, @TasksPerRunner int, @MaxRunnerIndex int
Set @TotalConcurrencySlots = (Select sum(ConcurrencySlotsAllocated) from {TempTable})
Set @ActiveRunners = (Select count(*) from FrameworkTaskRunner where ActiveYN = 1)
Set @TasksPerRunner =  floor(@TotalConcurrencySlots / @ActiveRunners)

Set @MaxRunnerIndex = @ActiveRunners
if(@TasksPerRunner < 1)
BEGIN 
	Select @MaxRunnerIndex = 1, @TasksPerRunner =1
END

DROP TABLE IF EXISTS #TasksToBeRun
Select ttbr.TaskGroupPriority, TI.TaskInstanceId, ttbr.IntraGroupExecutionOrder, InterGroupExecutionOrder = ROW_NUMBER() over (order by ttbr.TaskGroupPriority, ttbr.IntraGroupExecutionOrder)
into #TasksToBeRun
from 
TaskInstance TI
inner join 
TaskMaster TM on TM.TaskMasterId = TI.TaskMasterId
inner join {TempTable} TTG on TM.TaskGroupId = TTG.TaskGroupId
inner join [GetTasksToBeAssignedToRunners]() ttbr on TTG.TaskGroupId = ttbr.TaskGroupId and ttbr.TaskInstanceId = TI.TaskInstanceId
WHERE 
TTG.ConcurrencySlotsAllocated >= ttbr.IntraGroupExecutionOrder


DROP TABLE IF EXISTS #TasksWithRunnerAssignments
Create table #TasksWithRunnerAssignments (TaskInstanceId bigint, TaskRunnerId int)

Declare @LoopCounter int = 0
while @LoopCounter < @MaxRunnerIndex
begin 
insert into #TasksWithRunnerAssignments
Select ttbr.TaskInstanceId, FMR.TaskRunnerId
from 
#TasksToBeRun ttbr
inner join TaskInstance TI on TI.TaskInstanceId = ttbr.TaskInstanceId
inner join FrameworkTaskRunner FMR on FMR.TaskRunnerId = (@LoopCounter + 1)
where 
	InterGroupExecutionOrder > ((FMR.TaskRunnerId-1)*@TasksPerRunner) and InterGroupExecutionOrder <= (FMR.TaskRunnerId*@TasksPerRunner)    
Set @LoopCounter = @LoopCounter + 1
end


Update TaskInstance 
Set TaskRunnerId = TWRA.TaskRunnerId
from TaskInstance TI 
inner join #TasksWithRunnerAssignments TWRA on TWRA.TaskInstanceId = TI.TaskInstanceId
