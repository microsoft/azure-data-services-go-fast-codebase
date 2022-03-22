/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskInstanceExecution] (
    [ExecutionUid]   UNIQUEIDENTIFIER   NOT NULL,
    [TaskInstanceId] BIGINT             NOT NULL,
    [EngineId]       UNIQUEIDENTIFIER   NULL,
    [PipelineName]   VARCHAR (200)      NULL,
    [AdfRunUid]      UNIQUEIDENTIFIER   NULL,
    [StartDateTime]  DATETIMEOFFSET (7) NULL,
    [EndDateTime]    DATETIMEOFFSET (7) NULL,
    [Status]         VARCHAR (25)       NOT NULL,
    [Comment]        VARCHAR (255)      NULL,
    CONSTRAINT [PK_TaskInstanceExecution] PRIMARY KEY CLUSTERED ([ExecutionUid] ASC, [TaskInstanceId] ASC)
);


GO

