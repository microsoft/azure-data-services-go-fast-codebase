/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

/****** Object:  Table [dbo].[SubjectAreaHistory]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectAreaHistory](
	[SubjectAreaId] [int] NOT NULL,
	[SubjectAreaName] [varchar](255) NULL,
	[ActiveYN] [bit] NULL,
	[SubjectAreaFormId] [int] NULL,
	[DefaultTargetSchema] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) NOT NULL,
	[ValidTo] [datetime2](0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectArea]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectArea](
	[SubjectAreaId] [int] IDENTITY(1,1) NOT NULL,
	[SubjectAreaName] [varchar](255) NULL,
	[ActiveYN] [bit] NULL,
	[SubjectAreaFormId] [int] NULL,
	[DefaultTargetSchema] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[ValidTo] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectAreaId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[SubjectAreaHistory] )
)
GO
/****** Object:  Table [dbo].[SubjectAreaFormHistory]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectAreaFormHistory](
	[SubjectAreaFormId] [int] NOT NULL,
	[FormJson] [varchar](max) NULL,
	[FormStatus] [tinyint] NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) NOT NULL,
	[ValidTo] [datetime2](0) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectAreaForm]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO 
CREATE TABLE [dbo].[SubjectAreaForm](
	[SubjectAreaFormId] [int] IDENTITY(1,1) NOT NULL,
	[FormJson] [varchar](max) NULL,
	[FormStatus] [tinyint] NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[ValidTo] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectAreaFormId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[SubjectAreaFormHistory] )
)
GO
/****** Object:  Table [dbo].[SubjectAreaRoleMapHistory]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectAreaRoleMapHistory](
	[SubjectAreaId] [int] NOT NULL,
	[AadGroupUid] [uniqueidentifier] NOT NULL,
	[ApplicationRoleName] [varchar](255) NOT NULL,
	[ExpiryDate] [date] NOT NULL,
	[ActiveYN] [bit] NOT NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) NOT NULL,
	[ValidTo] [datetime2](0) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectAreaRoleMap]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectAreaRoleMap](
	[SubjectAreaId] [int] NOT NULL,
	[AadGroupUid] [uniqueidentifier] NOT NULL,
	[ApplicationRoleName] [varchar](255) NOT NULL,
	[ExpiryDate] [date] NOT NULL,
	[ActiveYN] [bit] NOT NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[ValidTo] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectAreaId] ASC,
	[AadGroupUid] ASC,
	[ApplicationRoleName] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[SubjectAreaRoleMapHistory] )
)
GO
/****** Object:  Table [dbo].[SubjectAreaSystemMapHistory]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectAreaSystemMapHistory](
	[SubjectAreaId] [int] NOT NULL,
	[SystemId] [bigint] NOT NULL,
	[MappingType] [tinyint] NOT NULL,
	[AllowedSchemas] [varchar](max) NOT NULL,
	[ActiveYN] [bit] NULL,
	[SubjectAreaFormId] [int] NULL,
	[DefaultTargetSchema] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) NOT NULL,
	[ValidTo] [datetime2](0) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubjectAreaSystemMap]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubjectAreaSystemMap](
	[SubjectAreaId] [int] NOT NULL,
	[SystemId] [bigint] NOT NULL,
	[MappingType] [tinyint] NOT NULL,
	[AllowedSchemas] [varchar](max) NOT NULL,
	[ActiveYN] [bit] NULL,
	[SubjectAreaFormId] [int] NULL,
	[DefaultTargetSchema] [varchar](255) NULL,
	[UpdatedBy] [varchar](255) NULL,
	[ValidFrom] [datetime2](0) GENERATED ALWAYS AS ROW START NOT NULL,
	[ValidTo] [datetime2](0) GENERATED ALWAYS AS ROW END NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SubjectAreaId] ASC,
	[SystemId] ASC,
	[MappingType] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
	PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
WITH
(
SYSTEM_VERSIONING = ON ( HISTORY_TABLE = [dbo].[SubjectAreaSystemMapHistory] )
)
GO
/****** Object:  Table [dbo].[ActivityLevelLogs]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ActivityLevelLogs](
	[timestamp] [datetime] NULL,
	[operation_Id] [varchar](max) NULL,
	[operation_Name] [varchar](max) NULL,
	[severityLevel] [int] NULL,
	[ExecutionUid] [uniqueidentifier] NULL,
	[TaskInstanceId] [int] NULL,
	[ActivityType] [varchar](max) NULL,
	[LogSource] [varchar](max) NULL,
	[LogDateUTC] [datetime] NULL,
	[LogDateTimeOffset] [datetime] NULL,
	[Status] [varchar](max) NULL,
	[TaskMasterId] [int] NULL,
	[Comment] [varchar](max) NULL,
	[message] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ADFActivityErrors]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADFActivityErrors](
	[EngineId] [bigint] NULL,
	[TenantId] [varchar](max) NULL,
	[SourceSystem] [varchar](max) NULL,
	[TimeGenerated] [datetime] NULL,
	[ResourceId] [varchar](max) NULL,
	[OperationName] [varchar](max) NULL,
	[Category] [varchar](max) NULL,
	[CorrelationId] [uniqueidentifier] NOT NULL,
	[Level] [varchar](max) NULL,
	[Location] [varchar](max) NULL,
	[Tags] [varchar](max) NULL,
	[Status] [varchar](max) NULL,
	[UserProperties] [varchar](max) NULL,
	[Annotations] [varchar](max) NULL,
	[EventMessage] [varchar](max) NULL,
	[Start] [datetime] NULL,
	[ActivityName] [varchar](max) NULL,
	[ActivityRunId] [varchar](max) NULL,
	[PipelineRunId] [uniqueidentifier] NULL,
	[EffectiveIntegrationRuntime] [varchar](max) NULL,
	[ActivityType] [varchar](max) NULL,
	[ActivityIterationCount] [int] NULL,
	[LinkedServiceName] [varchar](max) NULL,
	[End] [datetime] NULL,
	[FailureType] [varchar](max) NULL,
	[PipelineName] [varchar](max) NULL,
	[Input] [varchar](max) NULL,
	[Output] [varchar](max) NULL,
	[ErrorCode] [varchar](50) NULL,
	[ErrorMessage] [varchar](max) NULL,
	[Error] [varchar](max) NULL,
	[Type] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ADFActivityRun]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADFActivityRun](
	[PipelineRunUid] [uniqueidentifier] NOT NULL,
	[EngineId] [bigint] NOT NULL,
	[Activities] [bigint] NULL,
	[TotalCost] [real] NULL,
	[CloudOrchestrationCost] [real] NULL,
	[SelfHostedOrchestrationCost] [real] NULL,
	[SelfHostedDataMovementCost] [real] NULL,
	[SelfHostedPipelineActivityCost] [real] NULL,
	[CloudPipelineActivityCost] [real] NULL,
	[rowsCopied] [bigint] NULL,
	[dataRead] [bigint] NULL,
	[dataWritten] [bigint] NULL,
	[TaskExecutionStatus] [varchar](max) NULL,
	[FailedActivities] [bigint] NULL,
	[Start] [datetimeoffset](7) NULL,
	[End] [datetimeoffset](7) NULL,
	[MaxActivityTimeGenerated] [datetimeoffset](7) NULL,
 CONSTRAINT [PK_ADFActivityRun] PRIMARY KEY CLUSTERED 
(
	[PipelineRunUid] ASC,
	[EngineId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ADFPipelineRun]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADFPipelineRun](
	[TaskInstanceId] [bigint] NOT NULL,
	[ExecutionUid] [uniqueidentifier] NOT NULL,
	[EngineId] [bigint] NOT NULL,
	[PipelineRunUid] [uniqueidentifier] NOT NULL,
	[Start] [datetimeoffset](7) NULL,
	[End] [datetimeoffset](7) NULL,
	[PipelineName] [varchar](255) NULL,
	[PipelineRunStatus] [varchar](100) NOT NULL,
	[MaxPipelineTimeGenerated] [datetimeoffset](7) NOT NULL,
 CONSTRAINT [PK_ADFPipelineRun] PRIMARY KEY CLUSTERED 
(
	[TaskInstanceId] ASC,
	[ExecutionUid] ASC,
	[EngineId] ASC,
	[PipelineRunUid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ADFPipelineStats]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ADFPipelineStats](
	[TaskInstanceId] [int] NOT NULL,
	[ExecutionUid] [uniqueidentifier] NOT NULL,
	[EngineId] [bigint] NOT NULL,
	[Activities] [bigint] NULL,
	[TotalCost] [real] NULL,
	[CloudOrchestrationCost] [real] NULL,
	[SelfHostedOrchestrationCost] [real] NULL,
	[SelfHostedDataMovementCost] [real] NULL,
	[SelfHostedPipelineActivityCost] [real] NULL,
	[CloudPipelineActivityCost] [real] NULL,
	[rowsCopied] [bigint] NULL,
	[dataRead] [bigint] NULL,
	[dataWritten] [bigint] NULL,
	[TaskExecutionStatus] [varchar](max) NULL,
	[FailedActivities] [bigint] NULL,
	[Start] [datetimeoffset](7) NULL,
	[End] [datetimeoffset](7) NULL,
	[MaxActivityTimeGenerated] [datetimeoffset](7) NULL,
	[MaxPipelineTimeGenerated] [datetimeoffset](7) NOT NULL,
	[MaxPipelineDateGenerated]  AS (CONVERT([date],[MaxPipelineTimeGenerated])) PERSISTED,
	[MaxActivityDateGenerated]  AS (CONVERT([date],[MaxActivityTimeGenerated])) PERSISTED,
 CONSTRAINT [PK_ADFPipelineStats] PRIMARY KEY CLUSTERED 
(
	[TaskInstanceId] ASC,
	[ExecutionUid] ASC,
	[EngineId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AzureStorageChangeFeed]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AzureStorageChangeFeed](
	[EventTime] [datetimeoffset](7) NULL,
	[EventType] [varchar](max) NULL,
	[Subject] [varchar](max) NULL,
	[Topic] [varchar](max) NULL,
	[EventData.BlobOperationName] [varchar](max) NULL,
	[EventData.BlobType] [varchar](max) NULL,
	[Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff] [bigint] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AzureStorageChangeFeedCursor]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AzureStorageChangeFeedCursor](
	[SourceSystemId] [bigint] NOT NULL,
	[ChangeFeedCursor] [varchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SourceSystemId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AzureStorageListing]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AzureStorageListing](
	[SystemId] [bigint] NOT NULL,
	[PartitionKey] [varchar](50) NOT NULL,
	[RowKey] [varchar](50) NOT NULL,
	[FilePath] [varchar](2000) NULL,
 CONSTRAINT [PK_AzureStorageListing] PRIMARY KEY CLUSTERED 
(
	[SystemId] ASC,
	[PartitionKey] ASC,
	[RowKey] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Table [dbo].[Execution]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Execution](
	[ExecutionUid] [uniqueidentifier] NOT NULL,
	[StartDateTime] [datetimeoffset](7) NULL,
	[EndDateTime] [datetimeoffset](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[ExecutionUid] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExecutionEngine]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExecutionEngine](
	[EngineId] [bigint] IDENTITY(1,1) NOT NULL,
	[EngineName] [varchar](255) NULL,
	[SystemType] [varchar](255) NULL,
	[ResourceGroup] [varchar](255) NULL,
	[SubscriptionUid] [uniqueidentifier] NULL,
	[DefaultKeyVaultURL] [varchar](255) NULL,
	[EngineJson] [varchar](max) NULL,
	[LogAnalyticsWorkspaceId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ExecutionEngine] PRIMARY KEY CLUSTERED 
(
	[EngineId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExecutionEngine_JsonSchema]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExecutionEngine_JsonSchema](
	[SystemType] [varchar](255) NOT NULL,
	[JsonSchema] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SystemType] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FrameworkTaskRunner]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FrameworkTaskRunner](
	[TaskRunnerId] [int] NOT NULL,
	[TaskRunnerName] [varchar](255) NULL,
	[ActiveYN] [bit] NULL,
	[Status] [varchar](25) NULL,
	[MaxConcurrentTasks] [int] NULL,
	[LastExecutionStartDateTime] [datetimeoffset](7) NULL,
	[LastExecutionEndDateTime] [datetimeoffset](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskRunnerId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IntegrationRuntime]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IntegrationRuntime](
	[IntegrationRuntimeId] [int] IDENTITY(1,1) NOT NULL,
	[IntegrationRuntimeName] [varchar](255) NULL,
	[EngineId] [bigint] NULL,
	[ActiveYN] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[IntegrationRuntimeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleInstance]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleInstance](
	[ScheduleInstanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[ScheduleMasterId] [bigint] NULL,
	[ScheduledDateUtc] [datetime] NULL,
	[ScheduledDateTimeOffset] [datetimeoffset](7) NULL,
	[ActiveYN] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleInstanceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ScheduleMaster]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleMaster](
	[ScheduleMasterId] [bigint] IDENTITY(1,1) NOT NULL,
	[ScheduleCronExpression] [nvarchar](200) NOT NULL,
	[ScheduleDesciption] [varchar](200) NOT NULL,
	[ActiveYN] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ScheduleMasterId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SourceAndTargetSystems]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceAndTargetSystems](
	[SystemId] [bigint] IDENTITY(1,1) NOT NULL,
	[SystemName] [nvarchar](128) NOT NULL,
	[SystemType] [nvarchar](128) NOT NULL,
	[SystemDescription] [nvarchar](128) NOT NULL,
	[SystemServer] [nvarchar](128) NOT NULL,
	[SystemAuthType] [nvarchar](20) NOT NULL,
	[SystemUserName] [nvarchar](128) NULL,
	[SystemSecretName] [nvarchar](128) NULL,
	[SystemKeyVaultBaseUrl] [nvarchar](500) NULL,
	[SystemJSON] [nvarchar](4000) NULL,
	[ActiveYN] [bit] NOT NULL,
	[IsExternal] [bit] NOT NULL,
	[DataFactoryIR] [varchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[SystemId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SourceAndTargetSystems_JsonSchema]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SourceAndTargetSystems_JsonSchema](
	[SystemType] [varchar](255) NOT NULL,
	[JsonSchema] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SystemType] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskGroup]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskGroup](
	[TaskGroupId] [bigint] IDENTITY(1,1) NOT NULL,
	[SubjectAreaId] [int] NOT NULL,
	[TaskGroupName] [nvarchar](200) NOT NULL,
	[TaskGroupPriority] [int] NOT NULL,
	[TaskGroupConcurrency] [int] NOT NULL,
	[TaskGroupJSON] [nvarchar](4000) NULL,
	[MaximumTaskRetries] [int] NOT NULL,
	[ActiveYN] [bit] NULL,
 CONSTRAINT [PK__TaskGrou__1EAD70161628472C] PRIMARY KEY CLUSTERED 
(
	[TaskGroupId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskGroupDependency]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskGroupDependency](
	[AncestorTaskGroupId] [bigint] NOT NULL,
	[DescendantTaskGroupId] [bigint] NOT NULL,
	[DependencyType] [varchar](200) NOT NULL,
 CONSTRAINT [PK_TaskGroupDependency] PRIMARY KEY CLUSTERED 
(
	[AncestorTaskGroupId] ASC,
	[DescendantTaskGroupId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskInstance]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskInstance](
	[TaskInstanceId] [bigint] IDENTITY(1,1) NOT NULL,
	[TaskMasterId] [bigint] NOT NULL,
	[ScheduleInstanceId] [bigint] NOT NULL,
	[ExecutionUid] [uniqueidentifier] NOT NULL,
	[ADFPipeline] [nvarchar](128) NOT NULL,
	[TaskInstanceJson] [nvarchar](max) NULL,
	[LastExecutionStatus] [varchar](25) NULL,
	[LastExecutionUid] [uniqueidentifier] NULL,
	[LastExecutionComment] [varchar](255) NULL,
	[NumberOfRetries] [int] NOT NULL,
	[ActiveYN] [bit] NULL,
	[CreatedOn] [datetimeoffset](7) NULL,
	[UpdatedOn] [datetimeoffset](7) NULL,
	[TaskRunnerId] [int] NULL,
 CONSTRAINT [PK__TaskInst__548FCBDED6C62FEB] PRIMARY KEY CLUSTERED 
(
	[TaskInstanceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskInstanceExecution]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskInstanceExecution](
	[ExecutionUid] [uniqueidentifier] NOT NULL,
	[TaskInstanceId] [bigint] NOT NULL,
	[EngineId] [bigint] NULL,
	[PipelineName] [varchar](200) NULL,
	[AdfRunUid] [uniqueidentifier] NULL,
	[StartDateTime] [datetimeoffset](7) NULL,
	[EndDateTime] [datetimeoffset](7) NULL,
	[Status] [varchar](25) NOT NULL,
	[Comment] [varchar](255) NULL,
 CONSTRAINT [PK_TaskInstanceExecution] PRIMARY KEY CLUSTERED 
(
	[ExecutionUid] ASC,
	[TaskInstanceId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskMaster]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskMaster](
	[TaskMasterId] [bigint] IDENTITY(1,1) NOT NULL,
	[TaskMasterName] [nvarchar](200) NOT NULL,
	[TaskTypeId] [int] NOT NULL,
	[TaskGroupId] [bigint] NOT NULL,
	[ScheduleMasterId] [bigint] NOT NULL,
	[SourceSystemId] [bigint] NOT NULL,
	[TargetSystemId] [bigint] NOT NULL,
	[DegreeOfCopyParallelism] [int] NOT NULL,
	[AllowMultipleActiveInstances] [bit] NOT NULL,
	[TaskDatafactoryIR] [nvarchar](20) NOT NULL,
	[TaskMasterJSON] [nvarchar](4000) NULL,
	[ActiveYN] [bit] NOT NULL,
	[DependencyChainTag] [varchar](50) NULL,
	[EngineId] [bigint] NOT NULL,
 CONSTRAINT [PK__TaskMast__EB7286F6C9A58EA9] PRIMARY KEY CLUSTERED 
(
	[TaskMasterId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskMasterDependency]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskMasterDependency](
	[AncestorTaskMasterId] [bigint] NOT NULL,
	[DescendantTaskMasterId] [bigint] NOT NULL,
 CONSTRAINT [PK_TaskMasterDependency] PRIMARY KEY CLUSTERED 
(
	[AncestorTaskMasterId] ASC,
	[DescendantTaskMasterId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskMasterWaterMark]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskMasterWaterMark](
	[TaskMasterId] [bigint] NOT NULL,
	[TaskMasterWaterMarkColumn] [nvarchar](200) NOT NULL,
	[TaskMasterWaterMarkColumnType] [nvarchar](50) NOT NULL,
	[TaskMasterWaterMark_DateTime] [datetime] NULL,
	[TaskMasterWaterMark_BigInt] [bigint] NULL,
	[TaskWaterMarkJSON] [nvarchar](4000) NULL,
	[ActiveYN] [bit] NOT NULL,
	[UpdatedOn] [datetimeoffset](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TaskMasterId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskType]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskType](
	[TaskTypeId] [int] IDENTITY(1,1) NOT NULL,
	[TaskTypeName] [nvarchar](128) NOT NULL,
	[TaskExecutionType] [nvarchar](5) NOT NULL,
	[TaskTypeJson] [nvarchar](max) NULL,
	[ActiveYN] [bit] NOT NULL,
 CONSTRAINT [PK__TaskType__66B23E33F65B5D8C] PRIMARY KEY CLUSTERED 
(
	[TaskTypeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaskTypeMapping]    Script Date: 3/03/2022 1:09:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaskTypeMapping](
	[TaskTypeMappingId] [int] IDENTITY(1,1) NOT NULL,
	[TaskTypeId] [int] NOT NULL,
	[MappingType] [nvarchar](128) NOT NULL,
	[MappingName] [nvarchar](128) NOT NULL,
	[SourceSystemType] [nvarchar](128) NOT NULL,
	[SourceType] [nvarchar](128) NOT NULL,
	[TargetSystemType] [nvarchar](128) NOT NULL,
	[TargetType] [nvarchar](128) NOT NULL,
	[TaskTypeJson] [nvarchar](max) NULL,
	[ActiveYN] [bit] NOT NULL,
	[TaskMasterJsonSchema] [varchar](max) NULL,
	[TaskInstanceJsonSchema] [varchar](max) NULL,
 CONSTRAINT [PK__TaskType__C274052A4E989D69] PRIMARY KEY CLUSTERED 
(
	[TaskTypeMappingId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[ExecutionEngine] ADD  CONSTRAINT [DF_ExecutionEngine_EngineJson]  DEFAULT ('{}') FOR [EngineJson]
GO
ALTER TABLE [dbo].[TaskGroup] ADD  CONSTRAINT [DF_TaskGroup_MaximumTaskRetries]  DEFAULT ((3)) FOR [MaximumTaskRetries]
GO
ALTER TABLE [dbo].[TaskInstance] ADD  CONSTRAINT [DF__TaskInsta__Numbe__32767D0B]  DEFAULT ((0)) FOR [NumberOfRetries]
GO
ALTER TABLE [dbo].[TaskInstance] ADD  CONSTRAINT [DF__TaskInsta__Creat__3FD07829]  DEFAULT (getutcdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[TaskInstance] ADD  CONSTRAINT [DF_TaskInstance_UpdatedOn]  DEFAULT (getutcdate()) FOR [UpdatedOn]
GO
ALTER TABLE [dbo].[TaskMaster] ADD  CONSTRAINT [DF__TaskMaste__Degre__43A1090D]  DEFAULT ((1)) FOR [DegreeOfCopyParallelism]
GO
ALTER TABLE [dbo].[TaskMaster] ADD  CONSTRAINT [DF__TaskMaste__Allow__42ACE4D4]  DEFAULT ((0)) FOR [AllowMultipleActiveInstances]
GO
