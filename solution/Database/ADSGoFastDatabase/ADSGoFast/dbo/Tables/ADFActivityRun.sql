/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ADFActivityRun] (
    [PipelineRunUid]                 UNIQUEIDENTIFIER   NOT NULL,
    [EngineId]                       BIGINT             NOT NULL,
    [Activities]                     BIGINT             NULL,
    [TotalCost]                      REAL               NULL,
    [CloudOrchestrationCost]         REAL               NULL,
    [SelfHostedOrchestrationCost]    REAL               NULL,
    [SelfHostedDataMovementCost]     REAL               NULL,
    [SelfHostedPipelineActivityCost] REAL               NULL,
    [CloudPipelineActivityCost]      REAL               NULL,
    [rowsCopied]                     BIGINT             NULL,
    [dataRead]                       BIGINT             NULL,
    [dataWritten]                    BIGINT             NULL,
    [TaskExecutionStatus]            VARCHAR (MAX)      NULL,
    [FailedActivities]               BIGINT             NULL,
    [Start]                          DATETIMEOFFSET (7) NULL,
    [End]                            DATETIMEOFFSET (7) NULL,
    [MaxActivityTimeGenerated]       DATETIMEOFFSET (7) NULL,
    CONSTRAINT [PK_ADFActivityRun] PRIMARY KEY CLUSTERED ([PipelineRunUid] ASC, [EngineId] ASC)
);



