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
SET IDENTITY_INSERT [dbo].[TaskType] ON 

INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (1, N'Azure Storage to SQL Database', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (2, N'Azure Storage to Azure Storage', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (3, N'SQL Database to Azure Storage', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (4, N'Execute ADF Pipeline', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (5, N'Execute SSIS Pipeline', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (6, N'Execute Databricks Notebook', N'ADB', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (7, N'Execute SQL Statement', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (8, N'Generate Task Masters', N'ADF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (9, N'Generate and Send SAS URI File Upload Link', N'AF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (10, N'Cache Azure Storage File List', N'AF', NULL, 1)
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (11, N'Send Email Alert Triggered by File in FileList Cache', N'AF', NULL, 1)
SET IDENTITY_INSERT [dbo].[TaskType] OFF
