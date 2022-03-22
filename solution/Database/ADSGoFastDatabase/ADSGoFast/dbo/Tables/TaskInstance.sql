/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskInstance] (
    [TaskInstanceId]       BIGINT             IDENTITY (1, 1) NOT NULL,
    [TaskMasterId]         BIGINT             NOT NULL,
    [ScheduleInstanceId]   BIGINT             NOT NULL,
    [ExecutionUid]         UNIQUEIDENTIFIER   NOT NULL,
    [ADFPipeline]          NVARCHAR (128)     NOT NULL,
    [TaskInstanceJson]     NVARCHAR (MAX)     NULL,
    [LastExecutionStatus]  VARCHAR (25)       NULL,
    [LastExecutionUid]     UNIQUEIDENTIFIER   NULL,
    [LastExecutionComment] VARCHAR (255)      NULL,
    [NumberOfRetries]      INT                CONSTRAINT [DF__TaskInsta__Numbe__32767D0B] DEFAULT ((0)) NOT NULL,
    [ActiveYN]             BIT                NULL,
    [CreatedOn]            DATETIMEOFFSET (7) CONSTRAINT [DF__TaskInsta__Creat__3FD07829] DEFAULT (getutcdate()) NULL,
    [UpdatedOn]            DATETIMEOFFSET (7) CONSTRAINT [DF_TaskInstance_UpdatedOn] DEFAULT (getutcdate()) NULL,
    [TaskRunnerId]         INT                NULL,
    CONSTRAINT [PK__TaskInst__548FCBDED6C62FEB] PRIMARY KEY CLUSTERED ([TaskInstanceId] ASC)
);












GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_B5B588158C01F320F9EC80B7B88A2418]
    ON [dbo].[TaskInstance]([TaskMasterId] ASC, [LastExecutionStatus] ASC);


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_A8DC1B064B0B11088227C31A5B65513B]
    ON [dbo].[TaskInstance]([LastExecutionStatus] ASC)
    INCLUDE([TaskMasterId], [TaskRunnerId]);


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_67CB7E97C34F783EB26BEBAEACEC0D7E]
    ON [dbo].[TaskInstance]([LastExecutionStatus] ASC)
    INCLUDE([ScheduleInstanceId], [TaskMasterId]);


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_0EEF2CCAE417C39EAA3C6FFC345D5787]
    ON [dbo].[TaskInstance]([ActiveYN] ASC, [TaskRunnerId] ASC, [LastExecutionStatus] ASC)
    INCLUDE([ScheduleInstanceId], [TaskMasterId]);


GO
CREATE NONCLUSTERED INDEX [ix_taskinstance_taskmasterid]
    ON [dbo].[TaskInstance]([TaskMasterId] ASC);

