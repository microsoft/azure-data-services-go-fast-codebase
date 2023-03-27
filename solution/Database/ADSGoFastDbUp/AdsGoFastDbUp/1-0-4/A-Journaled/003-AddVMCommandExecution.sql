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
    "StorageAccountName": "$CmdExecutorVMAdlsName$"
}
', N'$LogAnalyticsWorkspaceId$')
GO
SET IDENTITY_INSERT [dbo].[ExecutionEngine] OFF
GO

INSERT [dbo].[ExecutionEngine_JsonSchema] ([SystemType], [JsonSchema]) VALUES (N'Virtual Machine', N'
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "properties": {"StorageAccountName": { "type": "string" } },
    "required": ["StorageAccountName"]
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