/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

/*
SCHEDULEMASTER
*/


TRUNCATE TABLE [dbo].[ScheduleMaster]
GO

INSERT INTO [dbo].[ScheduleMaster] ([ScheduleCronExpression],[ScheduleDesciption],[ActiveYN])
VALUES ('* * * * * *','Every Second',1)
GO

INSERT INTO [dbo].[ScheduleMaster] ([ScheduleCronExpression],[ScheduleDesciption],[ActiveYN])
VALUES ('0 0 * * * *','Every Hour',1)
GO

INSERT INTO [dbo].[ScheduleMaster] ([ScheduleCronExpression],[ScheduleDesciption],[ActiveYN])
VALUES ('0 * * * * *','Every Minute',1)
GO

INSERT INTO [dbo].[ScheduleMaster] ([ScheduleCronExpression],[ScheduleDesciption],[ActiveYN])
VALUES ('N/A','Run Once Only',1)
GO

INSERT INTO [dbo].[ScheduleMaster] ([ScheduleCronExpression],[ScheduleDesciption],[ActiveYN])
VALUES ('0 0 1 */3 * *','At 00:00 on day-of-month 1 in every 3rd month',1)
GO



/*
Subject Area
*/
SET IDENTITY_INSERT [dbo].[SubjectArea] ON
INSERT INTO [dbo].[SubjectArea] ([SubjectAreaId], [SubjectAreaName], [ActiveYN], [SubjectAreaFormId], [DefaultTargetSchema], [UpdatedBy]) VALUES (1, N'Default - Admin', 1, NULL, N'**ALL**', N'jorampon@microsoft.com')
INSERT INTO [dbo].[SubjectArea] ([SubjectAreaId], [SubjectAreaName], [ActiveYN], [SubjectAreaFormId], [DefaultTargetSchema], [UpdatedBy]) VALUES (2, N'Secured - Test SubjectArea', 1, NULL, N'TestSubjectArea', N'jorampon@microsoft.com')
SET IDENTITY_INSERT [dbo].[SubjectArea] OFF



/*
TASKGROUP
*/

TRUNCATE TABLE [dbo].[TaskGroup]
Go

INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Load Excel',1, 0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Load AwSample', 1,0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Load OnPrem Adventureworks', 1,0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Persist AwSample in Azure SQL', 1,0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Generate Task Masters',1, 0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Persist Adventureworks in Azure SQL',1, 0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Move between Storage',1, 0,10,null,1)
GO
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Build Dimensions',1, 0,10,null,1)
GO
/*SasURI Sample Group*/
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Generate SAS URI',1, 0,10,null,1)
GO

/*
TASKGROUPDEPENDENCY
*/

TRUNCATE TABLE [dbo].[TaskGroupDependency]
GO

INSERT INTO [dbo].[TaskGroupDependency] ([AncestorTaskGroupId],[DescendantTaskGroupId],[DependencyType])
VALUES (2, 4 ,'TasksMatchedByTagAndSchedule')
GO

INSERT INTO [dbo].[TaskGroupDependency] ([AncestorTaskGroupId],[DescendantTaskGroupId],[DependencyType])
VALUES (3, 6 ,'TasksMatchedByTagAndSchedule')
GO

/*
[dbo].[FrameworkTaskRunner]
*/
TRUNCATE TABLE [dbo].[FrameworkTaskRunner]
GO

INSERT INTO [dbo].[FrameworkTaskRunner] values (1,'Runner 1',1,'Idle',null)
INSERT INTO [dbo].[FrameworkTaskRunner] values (2,'Runner 2',1,'Idle',null)
INSERT INTO [dbo].[FrameworkTaskRunner] values (3,'Runner 3',1,'Idle',null)
INSERT INTO [dbo].[FrameworkTaskRunner] values (4,'Runner 4',1,'Idle',null)
GO
/*
DATAFACTORY
*/
TRUNCATE TABLE [dbo].[DataFactory]
GO

INSERT INTO [dbo].[DataFactory] ([Name],[ResourceGroup],[SubscriptionUid],[DefaultKeyVaultURL]) 
VALUES ('','','','')

INSERT INTO [dbo].[DataFactory] ([Name],[ResourceGroup],[SubscriptionUid],[DefaultKeyVaultURL]) 
VALUES ('adsgofastdatakakeacceladf','AdsGoFastDataLakeAccel','xxxxxxxxxxxxxxxxxxx','https://xxxxxxxxxxxxxxxxxxxx.vault.azure.net/')
GO
