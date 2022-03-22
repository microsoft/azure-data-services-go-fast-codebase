/* Updates for FileServer and Self Hosted SQL Server Support */

Update SourceAndTargetSystems
Set SystemJson =      ' {        "Database" : "msdb"  , "Username" : "adminuser", "PasswordKeyVaultSecretName":"selfhostedsqlpw"   }',
	SystemKeyVaultBaseUrl = 'https://$KeyVaultName$.vault.azure.net/',
	SystemServer = '(local)'
where Systemid = 14 

SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON 
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [DataFactoryIR], [IsExternal]) 
VALUES (15, N'Sample - File Server ', N'FileServer', N'Sample File Server Source', N'(local)', N'MSI', NULL, NULL, N'https://ads-dev-kv-ads-v35y.vault.azure.net/', N'', 1, '', 0)
GO
SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF
GO

insert into [dbo].[SourceAndTargetSystems_JsonSchema]
Select SystemType,JsonSchema  from 
(
Select 'FileServer' as SystemType, '{}' as JsonSchema
) a

