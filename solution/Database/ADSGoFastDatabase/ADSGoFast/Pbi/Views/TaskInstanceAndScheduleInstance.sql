/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
create view pbi.TaskInstanceAndScheduleInstance as 
Select a.*, b.ScheduledDateUtc, b.ScheduledDateTimeOffset from dbo.TaskInstance a join dbo.ScheduleInstance b on a.ScheduleInstanceId = b.ScheduleInstanceId
