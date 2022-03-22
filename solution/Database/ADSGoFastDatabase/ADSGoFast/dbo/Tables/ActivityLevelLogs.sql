/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ActivityLevelLogs] (
    [timestamp]         DATETIME         NULL,
    [operation_Id]      VARCHAR (MAX)    NULL,
    [operation_Name]    VARCHAR (MAX)    NULL,
    [severityLevel]     INT              NULL,
    [ExecutionUid]      UNIQUEIDENTIFIER NULL,
    [TaskInstanceId]    INT              NULL,
    [ActivityType]      VARCHAR (MAX)    NULL,
    [LogSource]         VARCHAR (MAX)    NULL,
    [LogDateUTC]        DATETIME         NULL,
    [LogDateTimeOffset] DATETIME         NULL,
    [Status]            VARCHAR (MAX)    NULL,
    [TaskMasterId]      INT              NULL,
    [Comment]           VARCHAR (MAX)    NULL,
    [message]           VARCHAR (MAX)    NULL
);


GO
CREATE NONCLUSTERED INDEX [IX_ActivityLevelLogs_TaskInstanceId]
    ON [dbo].[ActivityLevelLogs]([TaskInstanceId] ASC);


GO
CREATE CLUSTERED INDEX [IX_ActivityLevelLogs]
    ON [dbo].[ActivityLevelLogs]([timestamp] ASC);

