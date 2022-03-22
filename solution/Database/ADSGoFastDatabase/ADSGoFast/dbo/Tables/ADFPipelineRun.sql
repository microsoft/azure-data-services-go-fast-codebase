/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ADFPipelineRun] (
    [TaskInstanceId]           BIGINT             NOT NULL,
    [ExecutionUid]             UNIQUEIDENTIFIER   NOT NULL,
    [EngineId]                 BIGINT             NOT NULL,
    [PipelineRunUid]           UNIQUEIDENTIFIER   NOT NULL,
    [Start]                    DATETIMEOFFSET (7) NULL,
    [End]                      DATETIMEOFFSET (7) NULL,
    [PipelineName]             VARCHAR (255)      NULL,
    [PipelineRunStatus]        VARCHAR (100)      NOT NULL,
    [MaxPipelineTimeGenerated] DATETIMEOFFSET (7) NOT NULL,
    CONSTRAINT [PK_ADFPipelineRun] PRIMARY KEY CLUSTERED ([TaskInstanceId] ASC, [ExecutionUid] ASC, [EngineId] ASC, [PipelineRunUid] ASC)
);











