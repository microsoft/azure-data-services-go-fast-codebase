/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ADFPipelineStats] (
    [TaskInstanceId]                 INT                NOT NULL,
    [ExecutionUid]                   UNIQUEIDENTIFIER   NOT NULL,
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
    [MaxPipelineTimeGenerated]       DATETIMEOFFSET (7) NOT NULL,
    [MaxPipelineDateGenerated]       AS                 (CONVERT([date],[MaxPipelineTimeGenerated])) PERSISTED,
    [MaxActivityDateGenerated]       AS                 (CONVERT([date],[MaxActivityTimeGenerated])) PERSISTED,
    CONSTRAINT [PK_ADFPipelineStats] PRIMARY KEY CLUSTERED ([TaskInstanceId] ASC, [ExecutionUid] ASC, [EngineId] ASC)
);



