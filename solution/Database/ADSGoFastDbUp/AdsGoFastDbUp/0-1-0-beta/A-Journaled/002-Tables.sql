/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
PRINT N'Creating [dbo].[ActivityLevelLogs]...';


GO
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
PRINT N'Creating [dbo].[ActivityLevelLogs].[IX_ActivityLevelLogs]...';


GO
CREATE CLUSTERED INDEX [IX_ActivityLevelLogs]
    ON [dbo].[ActivityLevelLogs]([timestamp] ASC);


GO
PRINT N'Creating [dbo].[ActivityLevelLogs].[IX_ActivityLevelLogs_TaskInstanceId]...';


GO
CREATE NONCLUSTERED INDEX [IX_ActivityLevelLogs_TaskInstanceId]
    ON [dbo].[ActivityLevelLogs]([TaskInstanceId] ASC);


GO
PRINT N'Creating [dbo].[ADFActivityErrors]...';


GO
CREATE TABLE [dbo].[ADFActivityErrors] (
    [DatafactoryId]               BIGINT           NULL,
    [TenantId]                    VARCHAR (MAX)    NULL,
    [SourceSystem]                VARCHAR (MAX)    NULL,
    [TimeGenerated]               DATETIME         NULL,
    [ResourceId]                  VARCHAR (MAX)    NULL,
    [OperationName]               VARCHAR (MAX)    NULL,
    [Category]                    VARCHAR (MAX)    NULL,
    [CorrelationId]               UNIQUEIDENTIFIER NOT NULL,
    [Level]                       VARCHAR (MAX)    NULL,
    [Location]                    VARCHAR (MAX)    NULL,
    [Tags]                        VARCHAR (MAX)    NULL,
    [Status]                      VARCHAR (MAX)    NULL,
    [UserProperties]              VARCHAR (MAX)    NULL,
    [Annotations]                 VARCHAR (MAX)    NULL,
    [EventMessage]                VARCHAR (MAX)    NULL,
    [Start]                       DATETIME         NULL,
    [ActivityName]                VARCHAR (MAX)    NULL,
    [ActivityRunId]               VARCHAR (MAX)    NULL,
    [PipelineRunId]               UNIQUEIDENTIFIER NULL,
    [EffectiveIntegrationRuntime] VARCHAR (MAX)    NULL,
    [ActivityType]                VARCHAR (MAX)    NULL,
    [ActivityIterationCount]      INT              NULL,
    [LinkedServiceName]           VARCHAR (MAX)    NULL,
    [End]                         DATETIME         NULL,
    [FailureType]                 VARCHAR (MAX)    NULL,
    [PipelineName]                VARCHAR (MAX)    NULL,
    [Input]                       VARCHAR (MAX)    NULL,
    [Output]                      VARCHAR (MAX)    NULL,
    [ErrorCode]                   INT              NULL,
    [ErrorMessage]                VARCHAR (MAX)    NULL,
    [Error]                       VARCHAR (MAX)    NULL,
    [Type]                        VARCHAR (MAX)    NULL
);


GO
PRINT N'Creating [dbo].[ADFActivityErrors].[IX_ADFActivityErrors]...';


GO
CREATE CLUSTERED INDEX [IX_ADFActivityErrors]
    ON [dbo].[ADFActivityErrors]([TimeGenerated] ASC);


GO
PRINT N'Creating [dbo].[ADFActivityRun]...';


GO
CREATE TABLE [dbo].[ADFActivityRun] (
    [PipelineRunUid]                 UNIQUEIDENTIFIER   NOT NULL,
    [DataFactoryId]                  BIGINT             NOT NULL,
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
    CONSTRAINT [PK_ADFActivityRun] PRIMARY KEY CLUSTERED ([PipelineRunUid] ASC, [DataFactoryId] ASC)
);


GO
PRINT N'Creating [dbo].[ADFPipelineRun]...';


GO
CREATE TABLE [dbo].[ADFPipelineRun] (
    [TaskInstanceId]           BIGINT             NOT NULL,
    [ExecutionUid]             UNIQUEIDENTIFIER   NOT NULL,
    [DatafactoryId]            BIGINT             NOT NULL,
    [PipelineRunUid]           UNIQUEIDENTIFIER   NOT NULL,
    [Start]                    DATETIMEOFFSET (7) NULL,
    [End]                      DATETIMEOFFSET (7) NULL,
    [PipelineName]             VARCHAR (255)      NULL,
    [PipelineRunStatus]        VARCHAR (100)      NOT NULL,
    [MaxPipelineTimeGenerated] DATETIMEOFFSET (7) NOT NULL,
    CONSTRAINT [PK_ADFPipelineRun] PRIMARY KEY CLUSTERED ([TaskInstanceId] ASC, [ExecutionUid] ASC, [DatafactoryId] ASC, [PipelineRunUid] ASC)
);


GO
PRINT N'Creating [dbo].[ADFPipelineStats]...';


GO
CREATE TABLE [dbo].[ADFPipelineStats] (
    [TaskInstanceId]                 INT                NOT NULL,
    [ExecutionUid]                   UNIQUEIDENTIFIER   NOT NULL,
    [DataFactoryId]                  BIGINT             NOT NULL,
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
    [MaxPipelineDateGenerated]       AS                 (CONVERT (DATE, [MaxPipelineTimeGenerated])) PERSISTED,
    [MaxActivityDateGenerated]       AS                 (CONVERT (DATE, [MaxActivityTimeGenerated])) PERSISTED,
    CONSTRAINT [PK_ADFPipelineStats] PRIMARY KEY CLUSTERED ([TaskInstanceId] ASC, [ExecutionUid] ASC, [DataFactoryId] ASC)
);


GO
PRINT N'Creating [dbo].[AzureStorageChangeFeed]...';


GO
CREATE TABLE [dbo].[AzureStorageChangeFeed] (
    [EventTime]                                DATETIMEOFFSET (7) NULL,
    [EventType]                                VARCHAR (MAX)      NULL,
    [Subject]                                  VARCHAR (MAX)      NULL,
    [Topic]                                    VARCHAR (MAX)      NULL,
    [EventData.BlobOperationName]              VARCHAR (MAX)      NULL,
    [EventData.BlobType]                       VARCHAR (MAX)      NULL,
    [Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff] BIGINT             IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff] ASC)
);


GO
PRINT N'Creating [dbo].[AzureStorageChangeFeedCursor]...';


GO
CREATE TABLE [dbo].[AzureStorageChangeFeedCursor] (
    [SourceSystemId]   BIGINT        NOT NULL,
    [ChangeFeedCursor] VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([SourceSystemId] ASC)
);


GO
PRINT N'Creating [dbo].[AzureStorageListing]...';


GO
CREATE TABLE [dbo].[AzureStorageListing] (
    [SystemId]     BIGINT         NOT NULL,
    [PartitionKey] VARCHAR (50)   NOT NULL,
    [RowKey]       VARCHAR (50)   NOT NULL,
    [FilePath]     VARCHAR (2000) NULL,
    CONSTRAINT [PK_AzureStorageListing] PRIMARY KEY CLUSTERED ([SystemId] ASC, [PartitionKey] ASC, [RowKey] ASC)
);


GO
PRINT N'Creating [dbo].[DataFactory]...';


GO
CREATE TABLE [dbo].[DataFactory] (
    [Id]                      BIGINT           IDENTITY (1, 1) NOT NULL,
    [Name]                    VARCHAR (255)    NULL,
    [ResourceGroup]           VARCHAR (255)    NULL,
    [SubscriptionUid]         UNIQUEIDENTIFIER NULL,
    [DefaultKeyVaultURL]      VARCHAR (255)    NULL,
    [LogAnalyticsWorkspaceId] UNIQUEIDENTIFIER NULL
);


GO
PRINT N'Creating [dbo].[Execution]...';


GO
CREATE TABLE [dbo].[Execution] (
    [ExecutionUid]  UNIQUEIDENTIFIER   NOT NULL,
    [StartDateTime] DATETIMEOFFSET (7) NULL,
    [EndDateTime]   DATETIMEOFFSET (7) NULL,
    PRIMARY KEY CLUSTERED ([ExecutionUid] ASC)
);


GO
PRINT N'Creating [dbo].[ExecutionEngine]...';


GO
CREATE TABLE [dbo].[ExecutionEngine] (
    [EngineId]                BIGINT           IDENTITY (1, 1) NOT NULL,
    [EngineName]              VARCHAR (255)    NOT NULL,
    [ResouceName]             VARCHAR (255)    NULL,
    [ResourceGroup]           VARCHAR (255)    NULL,
    [SubscriptionUid]         UNIQUEIDENTIFIER NULL,
    [DefaultKeyVaultURL]      VARCHAR (255)    NULL,
    [LogAnalyticsWorkspaceId] UNIQUEIDENTIFIER NULL,
    [EngineJson]              VARCHAR (MAX)    NOT NULL,
    CONSTRAINT [PK_ExecutionEngine] PRIMARY KEY CLUSTERED ([EngineId] ASC)
);


GO
PRINT N'Creating [dbo].[FrameworkTaskRunner]...';


GO
CREATE TABLE [dbo].[FrameworkTaskRunner] (
    [TaskRunnerId]               INT                NOT NULL,
    [TaskRunnerName]             VARCHAR (255)      NULL,
    [ActiveYN]                   BIT                NULL,
    [Status]                     VARCHAR (25)       NULL,
    [MaxConcurrentTasks]         INT                NULL,
    [LastExecutionStartDateTime] DATETIMEOFFSET (7) NULL,
    [LastExecutionEndDateTime]   DATETIMEOFFSET (7) NULL,
    PRIMARY KEY CLUSTERED ([TaskRunnerId] ASC)
);


GO
PRINT N'Creating [dbo].[ScheduleInstance]...';


GO
CREATE TABLE [dbo].[ScheduleInstance] (
    [ScheduleInstanceId]      BIGINT             IDENTITY (1, 1) NOT NULL,
    [ScheduleMasterId]        BIGINT             NULL,
    [ScheduledDateUtc]        DATETIME           NULL,
    [ScheduledDateTimeOffset] DATETIMEOFFSET (7) NULL,
    [ActiveYN]                BIT                NULL,
    PRIMARY KEY CLUSTERED ([ScheduleInstanceId] ASC)
);


GO
PRINT N'Creating [dbo].[ScheduleMaster]...';


GO
CREATE TABLE [dbo].[ScheduleMaster] (
    [ScheduleMasterId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [ScheduleCronExpression] NVARCHAR (200) NOT NULL,
    [ScheduleDesciption]     VARCHAR (200)  NOT NULL,
    [ActiveYN]               BIT            NULL,
    PRIMARY KEY CLUSTERED ([ScheduleMasterId] ASC)
);


GO
PRINT N'Creating [dbo].[SourceAndTargetSystems]...';


GO
CREATE TABLE [dbo].[SourceAndTargetSystems] (
    [SystemId]              BIGINT          IDENTITY (1, 1) NOT NULL,
    [SystemName]            NVARCHAR (128)  NOT NULL,
    [SystemType]            NVARCHAR (128)  NOT NULL,
    [SystemDescription]     NVARCHAR (128)  NOT NULL,
    [SystemServer]          NVARCHAR (128)  NOT NULL,
    [SystemAuthType]        NVARCHAR (20)   NOT NULL,
    [SystemUserName]        NVARCHAR (128)  NULL,
    [SystemSecretName]      NVARCHAR (128)  NULL,
    [SystemKeyVaultBaseUrl] NVARCHAR (500)  NULL,
    [SystemJSON]            NVARCHAR (4000) NULL,
    [ActiveYN]              BIT             NOT NULL,
    [IsExternal]            BIT             NOT NULL,
    PRIMARY KEY CLUSTERED ([SystemId] ASC)
);


GO
PRINT N'Creating [dbo].[SourceAndTargetSystems_JsonSchema]...';


GO
CREATE TABLE [dbo].[SourceAndTargetSystems_JsonSchema] (
    [SystemType] VARCHAR (255)  NOT NULL,
    [JsonSchema] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([SystemType] ASC)
);


GO
PRINT N'Creating [dbo].[SubjectAreaFormHistory]...';


GO
CREATE TABLE [dbo].[SubjectAreaFormHistory] (
    [SubjectAreaFormId] INT           NOT NULL,
    [FormJson]          VARCHAR (MAX) NULL,
    [FormStatus]        TINYINT       NULL,
    [UpdatedBy]         VARCHAR (255) NULL,
    [ValidFrom]         DATETIME2 (0) NOT NULL,
    [ValidTo]           DATETIME2 (0) NOT NULL
);


GO
PRINT N'Creating [dbo].[SubjectAreaHistory]...';


GO
CREATE TABLE [dbo].[SubjectAreaHistory] (
    [SubjectAreaId]       INT           NOT NULL,
    [SubjectAreaName]     VARCHAR (255) NULL,
    [ActiveYN]            BIT           NULL,
    [SubjectAreaFormId]   INT           NULL,
    [DefaultTargetSchema] VARCHAR (255) NULL,
    [UpdatedBy]           VARCHAR (255) NULL,
    [ValidFrom]           DATETIME2 (0) NOT NULL,
    [ValidTo]             DATETIME2 (0) NOT NULL
);


GO
PRINT N'Creating [dbo].[SubjectAreaHistory].[ix_SubjectAreaHistory]...';


GO
CREATE CLUSTERED INDEX [ix_SubjectAreaHistory]
    ON [dbo].[SubjectAreaHistory]([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating [dbo].[SubjectAreaRoleMapHistory]...';


GO
CREATE TABLE [dbo].[SubjectAreaRoleMapHistory] (
    [SubjectAreaId]       INT              NOT NULL,
    [AadGroupUid]         UNIQUEIDENTIFIER NOT NULL,
    [ApplicationRoleName] VARCHAR (255)    NOT NULL,
    [ExpiryDate]          DATE             NOT NULL,
    [ActiveYN]            BIT              NOT NULL,
    [UpdatedBy]           VARCHAR (255)    NULL,
    [ValidFrom]           DATETIME2 (0)    NOT NULL,
    [ValidTo]             DATETIME2 (0)    NOT NULL
);


GO
PRINT N'Creating [dbo].[SubjectAreaRoleMapHistory].[ix_SubjectAreaRoleMapHistory]...';


GO
CREATE CLUSTERED INDEX [ix_SubjectAreaRoleMapHistory]
    ON [dbo].[SubjectAreaRoleMapHistory]([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating [dbo].[SubjectAreaSystemMapHistory]...';


GO
CREATE TABLE [dbo].[SubjectAreaSystemMapHistory] (
    [SubjectAreaId]       INT           NOT NULL,
    [SystemId]            BIGINT        NOT NULL,
    [MappingType]         TINYINT       NOT NULL,
    [AllowedSchemas]      VARCHAR (MAX) NOT NULL,
    [ActiveYN]            BIT           NULL,
    [SubjectAreaFormId]   INT           NULL,
    [DefaultTargetSchema] VARCHAR (255) NULL,
    [UpdatedBy]           VARCHAR (255) NULL,
    [ValidFrom]           DATETIME2 (0) NOT NULL,
    [ValidTo]             DATETIME2 (0) NOT NULL
);


GO
PRINT N'Creating [dbo].[SubjectAreaSystemMapHistory].[ix_SubjectAreaSystemMapHistory]...';


GO
CREATE CLUSTERED INDEX [ix_SubjectAreaSystemMapHistory]
    ON [dbo].[SubjectAreaSystemMapHistory]([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);


GO
PRINT N'Creating [dbo].[TaskGroup]...';


GO
CREATE TABLE [dbo].[TaskGroup] (
    [TaskGroupId]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [SubjectAreaId]        INT             NOT NULL,
    [TaskGroupName]        NVARCHAR (200)  NOT NULL,
    [TaskGroupPriority]    INT             NOT NULL,
    [TaskGroupConcurrency] INT             NOT NULL,
    [TaskGroupJSON]        NVARCHAR (4000) NULL,
    [MaximumTaskRetries]   INT             NOT NULL,
    [ActiveYN]             BIT             NULL,
    CONSTRAINT [PK__TaskGrou__1EAD70161628472C] PRIMARY KEY CLUSTERED ([TaskGroupId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskGroupDependency]...';


GO
CREATE TABLE [dbo].[TaskGroupDependency] (
    [AncestorTaskGroupId]   BIGINT        NOT NULL,
    [DescendantTaskGroupId] BIGINT        NOT NULL,
    [DependencyType]        VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_TaskGroupDependency] PRIMARY KEY CLUSTERED ([AncestorTaskGroupId] ASC, [DescendantTaskGroupId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskInstance]...';


GO
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
    [NumberOfRetries]      INT                NOT NULL,
    [ActiveYN]             BIT                NULL,
    [CreatedOn]            DATETIMEOFFSET (7) NULL,
    [UpdatedOn]            DATETIMEOFFSET (7) NULL,
    [TaskRunnerId]         INT                NULL,
    CONSTRAINT [PK__TaskInst__548FCBDED6C62FEB] PRIMARY KEY CLUSTERED ([TaskInstanceId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskInstance].[nci_wi_TaskInstance_B5B588158C01F320F9EC80B7B88A2418]...';


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_B5B588158C01F320F9EC80B7B88A2418]
    ON [dbo].[TaskInstance]([TaskMasterId] ASC, [LastExecutionStatus] ASC);


GO
PRINT N'Creating [dbo].[TaskInstance].[nci_wi_TaskInstance_A8DC1B064B0B11088227C31A5B65513B]...';


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_A8DC1B064B0B11088227C31A5B65513B]
    ON [dbo].[TaskInstance]([LastExecutionStatus] ASC)
    INCLUDE([TaskMasterId], [TaskRunnerId]);


GO
PRINT N'Creating [dbo].[TaskInstance].[nci_wi_TaskInstance_67CB7E97C34F783EB26BEBAEACEC0D7E]...';


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_67CB7E97C34F783EB26BEBAEACEC0D7E]
    ON [dbo].[TaskInstance]([LastExecutionStatus] ASC)
    INCLUDE([ScheduleInstanceId], [TaskMasterId]);


GO
PRINT N'Creating [dbo].[TaskInstance].[nci_wi_TaskInstance_0EEF2CCAE417C39EAA3C6FFC345D5787]...';


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskInstance_0EEF2CCAE417C39EAA3C6FFC345D5787]
    ON [dbo].[TaskInstance]([ActiveYN] ASC, [TaskRunnerId] ASC, [LastExecutionStatus] ASC)
    INCLUDE([ScheduleInstanceId], [TaskMasterId]);


GO
PRINT N'Creating [dbo].[TaskInstance].[ix_taskinstance_taskmasterid]...';


GO
CREATE NONCLUSTERED INDEX [ix_taskinstance_taskmasterid]
    ON [dbo].[TaskInstance]([TaskMasterId] ASC);


GO
PRINT N'Creating [dbo].[TaskInstanceExecution]...';


GO
CREATE TABLE [dbo].[TaskInstanceExecution] (
    [ExecutionUid]               UNIQUEIDENTIFIER   NOT NULL,
    [TaskInstanceId]             BIGINT             NOT NULL,
    [DatafactorySubscriptionUid] UNIQUEIDENTIFIER   NULL,
    [DatafactoryResourceGroup]   VARCHAR (255)      NULL,
    [DatafactoryName]            VARCHAR (255)      NULL,
    [PipelineName]               VARCHAR (200)      NULL,
    [AdfRunUid]                  UNIQUEIDENTIFIER   NULL,
    [StartDateTime]              DATETIMEOFFSET (7) NULL,
    [EndDateTime]                DATETIMEOFFSET (7) NULL,
    [Status]                     VARCHAR (25)       NOT NULL,
    [Comment]                    VARCHAR (255)      NULL,
    CONSTRAINT [PK_TaskInstanceExecution] PRIMARY KEY CLUSTERED ([ExecutionUid] ASC, [TaskInstanceId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskMaster]...';


GO
CREATE TABLE [dbo].[TaskMaster] (
    [TaskMasterId]                 BIGINT          IDENTITY (1, 1) NOT NULL,
    [TaskMasterName]               NVARCHAR (200)  NOT NULL,
    [TaskTypeId]                   INT             NOT NULL,
    [TaskGroupId]                  BIGINT          NOT NULL,
    [ScheduleMasterId]             BIGINT          NOT NULL,
    [SourceSystemId]               BIGINT          NOT NULL,
    [TargetSystemId]               BIGINT          NOT NULL,
    [DegreeOfCopyParallelism]      INT             NOT NULL,
    [AllowMultipleActiveInstances] BIT             NOT NULL,
    [TaskDatafactoryIR]            NVARCHAR (20)   NOT NULL,
    [TaskMasterJSON]               NVARCHAR (4000) NULL,
    [ActiveYN]                     BIT             NOT NULL,
    [DependencyChainTag]           VARCHAR (50)    NULL,
    [DataFactoryId]                BIGINT          NOT NULL,
    CONSTRAINT [PK__TaskMast__EB7286F6C9A58EA9] PRIMARY KEY CLUSTERED ([TaskMasterId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskMaster].[nci_wi_TaskMaster_D7BDAE69478BDFB67BBA9E4F9BB3DD7F]...';


GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskMaster_D7BDAE69478BDFB67BBA9E4F9BB3DD7F]
    ON [dbo].[TaskMaster]([TaskGroupId] ASC, [DependencyChainTag] ASC)
    INCLUDE([SourceSystemId], [TargetSystemId]);


GO
PRINT N'Creating [dbo].[TaskMasterDependency]...';


GO
CREATE TABLE [dbo].[TaskMasterDependency] (
    [AncestorTaskMasterId]   BIGINT NOT NULL,
    [DescendantTaskMasterId] BIGINT NOT NULL,
    CONSTRAINT [PK_TaskMasterDependency] PRIMARY KEY CLUSTERED ([AncestorTaskMasterId] ASC, [DescendantTaskMasterId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskMasterWaterMark]...';


GO
CREATE TABLE [dbo].[TaskMasterWaterMark] (
    [TaskMasterId]                  BIGINT             NOT NULL,
    [TaskMasterWaterMarkColumn]     NVARCHAR (200)     NOT NULL,
    [TaskMasterWaterMarkColumnType] NVARCHAR (50)      NOT NULL,
    [TaskMasterWaterMark_DateTime]  DATETIME           NULL,
    [TaskMasterWaterMark_BigInt]    BIGINT             NULL,
    [TaskWaterMarkJSON]             NVARCHAR (4000)    NULL,
    [ActiveYN]                      BIT                NOT NULL,
    [UpdatedOn]                     DATETIMEOFFSET (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([TaskMasterId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskType]...';


GO
CREATE TABLE [dbo].[TaskType] (
    [TaskTypeId]        INT            IDENTITY (1, 1) NOT NULL,
    [TaskTypeName]      NVARCHAR (128) NOT NULL,
    [TaskExecutionType] NVARCHAR (5)   NOT NULL,
    [TaskTypeJson]      NVARCHAR (MAX) NULL,
    [ActiveYN]          BIT            NOT NULL,
    CONSTRAINT [PK__TaskType__66B23E33F65B5D8C] PRIMARY KEY CLUSTERED ([TaskTypeId] ASC)
);


GO
PRINT N'Creating [dbo].[TaskTypeMapping]...';


GO
CREATE TABLE [dbo].[TaskTypeMapping] (
    [TaskTypeMappingId]      INT            IDENTITY (1, 1) NOT NULL,
    [TaskTypeId]             INT            NOT NULL,
    [MappingType]            NVARCHAR (128) NOT NULL,
    [MappingName]            NVARCHAR (128) NOT NULL,
    [SourceSystemType]       NVARCHAR (128) NOT NULL,
    [SourceType]             NVARCHAR (128) NOT NULL,
    [TargetSystemType]       NVARCHAR (128) NOT NULL,
    [TargetType]             NVARCHAR (128) NOT NULL,
    [TaskDatafactoryIR]      NVARCHAR (128) NOT NULL,
    [TaskTypeJson]           NVARCHAR (MAX) NULL,
    [ActiveYN]               BIT            NOT NULL,
    [TaskMasterJsonSchema]   VARCHAR (MAX)  NULL,
    [TaskInstanceJsonSchema] VARCHAR (MAX)  NULL,
    CONSTRAINT [PK__TaskType__C274052A4E989D69] PRIMARY KEY CLUSTERED ([TaskTypeMappingId] ASC)
);


GO
PRINT N'Creating [dbo].[SubjectArea]...';


GO
CREATE TABLE [dbo].[SubjectArea] (
    [SubjectAreaId]       INT                                         IDENTITY (1, 1) NOT NULL,
    [SubjectAreaName]     VARCHAR (255)                               NULL,
    [ActiveYN]            BIT                                         NULL,
    [SubjectAreaFormId]   INT                                         NULL,
    [DefaultTargetSchema] VARCHAR (255)                               NULL,
    [UpdatedBy]           VARCHAR (255)                               NULL,
    [ValidFrom]           DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]             DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaId] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaHistory], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating [dbo].[SubjectAreaForm]...';


GO
CREATE TABLE [dbo].[SubjectAreaForm] (
    [SubjectAreaFormId] INT                                         IDENTITY (1, 1) NOT NULL,
    [FormJson]          VARCHAR (MAX)                               NULL,
    [FormStatus]        TINYINT                                     NULL,
    [UpdatedBy]         VARCHAR (255)                               NULL,
    [ValidFrom]         DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]           DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaFormId] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaFormHistory], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating [dbo].[SubjectAreaRoleMap]...';


GO
CREATE TABLE [dbo].[SubjectAreaRoleMap] (
    [SubjectAreaId]       INT                                         NOT NULL,
    [AadGroupUid]         UNIQUEIDENTIFIER                            NOT NULL,
    [ApplicationRoleName] VARCHAR (255)                               NOT NULL,
    [ExpiryDate]          DATE                                        NOT NULL,
    [ActiveYN]            BIT                                         NOT NULL,
    [UpdatedBy]           VARCHAR (255)                               NULL,
    [ValidFrom]           DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]             DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaId] ASC, [AadGroupUid] ASC, [ApplicationRoleName] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaRoleMapHistory], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating [dbo].[SubjectAreaSystemMap]...';


GO
CREATE TABLE [dbo].[SubjectAreaSystemMap] (
    [SubjectAreaId]       INT                                         NOT NULL,
    [SystemId]            BIGINT                                      NOT NULL,
    [MappingType]         TINYINT                                     NOT NULL,
    [AllowedSchemas]      VARCHAR (MAX)                               NOT NULL,
    [ActiveYN]            BIT                                         NULL,
    [SubjectAreaFormId]   INT                                         NULL,
    [DefaultTargetSchema] VARCHAR (255)                               NULL,
    [UpdatedBy]           VARCHAR (255)                               NULL,
    [ValidFrom]           DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]             DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaId] ASC, [SystemId] ASC, [MappingType] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaSystemMapHistory], DATA_CONSISTENCY_CHECK=ON));


GO
PRINT N'Creating [dbo].[DF_ExecutionEngine_EngineJson]...';


GO
ALTER TABLE [dbo].[ExecutionEngine]
    ADD CONSTRAINT [DF_ExecutionEngine_EngineJson] DEFAULT ('{}') FOR [EngineJson];


GO
PRINT N'Creating [dbo].[DF_TaskGroup_MaximumTaskRetries]...';


GO
ALTER TABLE [dbo].[TaskGroup]
    ADD CONSTRAINT [DF_TaskGroup_MaximumTaskRetries] DEFAULT ((3)) FOR [MaximumTaskRetries];


GO
PRINT N'Creating [dbo].[DF__TaskInsta__Numbe__32767D0B]...';


GO
ALTER TABLE [dbo].[TaskInstance]
    ADD CONSTRAINT [DF__TaskInsta__Numbe__32767D0B] DEFAULT ((0)) FOR [NumberOfRetries];


GO
PRINT N'Creating [dbo].[DF__TaskInsta__Creat__3FD07829]...';


GO
ALTER TABLE [dbo].[TaskInstance]
    ADD CONSTRAINT [DF__TaskInsta__Creat__3FD07829] DEFAULT (getutcdate()) FOR [CreatedOn];


GO
PRINT N'Creating [dbo].[DF_TaskInstance_UpdatedOn]...';


GO
ALTER TABLE [dbo].[TaskInstance]
    ADD CONSTRAINT [DF_TaskInstance_UpdatedOn] DEFAULT (getutcdate()) FOR [UpdatedOn];


GO
PRINT N'Creating [dbo].[DF__TaskMaste__Degre__43A1090D]...';


GO
ALTER TABLE [dbo].[TaskMaster]
    ADD CONSTRAINT [DF__TaskMaste__Degre__43A1090D] DEFAULT ((1)) FOR [DegreeOfCopyParallelism];


GO
PRINT N'Creating [dbo].[DF__TaskMaste__Allow__42ACE4D4]...';


GO
ALTER TABLE [dbo].[TaskMaster]
    ADD CONSTRAINT [DF__TaskMaste__Allow__42ACE4D4] DEFAULT ((0)) FOR [AllowMultipleActiveInstances];
