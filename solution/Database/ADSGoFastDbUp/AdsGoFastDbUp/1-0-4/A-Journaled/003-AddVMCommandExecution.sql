/* TASK TYPE FOR Execute Databricks Notebook */
SET IDENTITY_INSERT [dbo].[TaskType] ON 
GO
INSERT [dbo].[TaskType] ([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN]) VALUES (-13, N'Execute VM Command', N'DLL', NULL, 1)
GO
SET IDENTITY_INSERT [dbo].[TaskType] OFF
GO

SET IDENTITY_INSERT [dbo].[ExecutionEngine] ON 
GO
INSERT [dbo].[ExecutionEngine] ([EngineId], [EngineName], [SystemType], [ResourceGroup], [SubscriptionUid], [DefaultKeyVaultURL], [EngineJson], [LogAnalyticsWorkspaceId]) VALUES (-3, N'$CmdExecutorVMName$', 'Virtual Machine', N'$ResourceGroupName$', N'$SubscriptionId$', N'https://$KeyVaultName$.vault.azure.net/', N'
{
    "StorageAccountName": "$CmdExecutorVMAdlsName$",
    "KeyVaultURL": "https://$KeyVaultName$.vault.azure.net/"
}
', N'$LogAnalyticsWorkspaceId$')
GO
SET IDENTITY_INSERT [dbo].[ExecutionEngine] OFF
GO

INSERT [dbo].[ExecutionEngine_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Virtual Machine', N'
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {"StorageAccountName": { "type": "string" } }, {"KeyVaultURL": { "type": "string" } },
    "required": ["StorageAccountName", "KeyVaultURL"]
}')
GO

SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON 
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal], [DataFactoryIR]) VALUES (-22, 'N/A', 'N/A', 'VM-N/A', 'N/A', N'MSI', NULL, NULL, 'N/A', N'{}', 1, 0, NULL)
GO
SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF 
GO

INSERT [dbo].[SourceAndTargetSystems_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'VM-N/A', N'{  "$schema": "http://json-schema.org/draft-04/schema#",  "type": "object",  "properties": {},  "required": []}')
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MetadataExtractionVersion](
	[ExtractionVersionId] [bigint] IDENTITY(1,1) NOT NULL,
	[ExtractedDateTime] [datetime] NULL,
 CONSTRAINT [PK_MetadataExtractionVersion] PRIMARY KEY CLUSTERED 
(
	[ExtractionVersionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TaskMaster]
ADD [ExtractionVersionId] bigint NULL; 

ALTER TABLE [dbo].[TaskGroup]
ADD [ExtractionVersionId] bigint NULL; 

ALTER TABLE [dbo].[TaskGroupDependency]
ADD [ExtractionVersionId] bigint NULL; 

ALTER TABLE [dbo].[SubjectArea]
ADD [ExtractionVersionId] bigint NULL; 

ALTER TABLE [dbo].[ScheduleMaster]
ADD [ExtractionVersionId] bigint NULL; 

ALTER TABLE [dbo].[SourceAndTargetSystems]
ADD [ExtractionVersionId] bigint NULL; 

SET IDENTITY_INSERT [dbo].[MetadataExtractionVersion] ON 
GO
INSERT [dbo].[MetadataExtractionVersion] ([ExtractionVersionId], [ExtractedDateTime]) VALUES (0, GETDATE())
GO
SET IDENTITY_INSERT [dbo].[MetadataExtractionVersion] OFF
GO
