/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/


SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON 
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (1, N'Sample - Azure SQL Server ', N'Azure SQL', N'Sample Azure SQL Server Source', N'adsgofastdatakakeaccelsqlsvr.database.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Database" : "AWSample"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (2, N'Sample - Exploration SQL', N'Azure SQL', N'Sample - Exploration SQL', N'adsgofastdatakakeaccelsqlsvr.database.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'    {        "Database" : "Staging"    }', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (3, N'Sample - DataLake Raw (Blob)', N'Azure Blob', N'Sample - DataLake Raw', N'https://adsgofastdatalakeaccelst.blob.core.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Container" : "datalakeraw"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (4, N'Sample - DataLake Raw (ADLS)', N'ADLS', N'Sample - DataLake Raw (ADLS)', N'https://adsgofastdatalakeadls.dfs.core.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Container" : "datalakeraw"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (5, N'Sample - On Premise Fileshare Source', N'File', N'Sample - On Premise Fileshare Source', N'\\\\adsgofastonpremadfir\\D$\\dataingestion\\', N'WindowsAuth', N'AzureUser', N'adsgofast-onpre-file-password', N'https://adsgofastkeyvault.vault.azure.net/', NULL, 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (6, N'Sample - VM Hosted SQL Server', N'SQL Server', N'Sample - VM Hosted SQL Server', N'adsgofast-onpre', N'SQLAuth', N'sqladfir', N'adsgofast-onpre-sqladfir-password', N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Database" : "AdventureWorks2017"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (7, N'Sample - DataLake Landing (Blob)', N'Azure Blob', N'Sample - DataLake Landing (Blob)', N'https://adsgofastdatalakeaccelst.blob.core.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Container" : "datalakelanding"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (8, N'Sample - DataLake Landing (ADLS)', N'ADLS', N'Sample - DataLake Landing (ADLS)', N'https://adsgofastdatalakeadls.dfs.core.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Container" : "datalakelanding"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (9, N'Sample - Transient-In (Blob)', N'Azure Blob', N'Sample - Transient-In (Blob)', N'https://adsgofasttransientstg.blob.core.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Container" : "transientin"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (10, N'Sample - Sendgrid Email Account', N'SendGrid', N'Sample - Sendgrid Email Account', N'ADSGoFastSendGrid', N'Key', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'    {
        "SenderEmail" : "noreply@cleverchiro.com",
        "SenderDescription" : "ADS Go Fast (No Reply)",
        "Subject" : "ADS GO Fast SAS Uri for File Upload",
        "PlainTextContent" : "Hello, Email!",
        "HtmlContent" : "<strong>Hi <NAME>, </strong> </br></br> Use the link below to upload files: </br> <SASTOKEN> </br></br>"
    }', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (11, N'Sample - AdsGoFast Database', N'Azure SQL', N'Sample - AdsGoFast Database', N'adsgofastdatakakeaccelsqlsvr.database.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Database" : "AdsGoFast"
    }
', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (12, N'Sample - Sendgrid Email Account2', N'SendGrid', N'Sample - Sendgrid Email Account2', N'ADSGoFastSendGrid', N'Key', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'    {
        "SenderEmail" : "noreply@cleverchiro.com",
        "SenderDescription" : "ADS Go Fast (No Reply)",
        "Subject" : "ADS GO Fast SAS Uri for File Upload",
        "PlainTextContent" : "Hello, Email!",
        "HtmlContent" : "<strong>Hi <NAME>, </strong> </br></br> Use the link below to upload files: </br> <SASTOKEN> </br></br>"
    }', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (13, N'Sample - VM Target', N'AzureVM', N'Sample - VM Target', N'adsgofastadfir', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'    {        "SubscriptionUid" : "035a1364-f00d-48e2-b582-4fe125905ee3", "VMname" : "adsgofastadfir", "ResourceGroup":"ADSGOFASTDATALAKEACCEL" }', 1, 0)
GO
INSERT [dbo].[SourceAndTargetSystems] ([SystemId], [SystemName], [SystemType], [SystemDescription], [SystemServer], [SystemAuthType], [SystemUserName], [SystemSecretName], [SystemKeyVaultBaseUrl], [SystemJSON], [ActiveYN], [IsExternal]) VALUES (14, N'Sample - External SQL Server ', N'Azure SQL', N'Sample Azure SQL Server Source', N'adsgofastdatakakeaccelsqlsvr.database.windows.net', N'MSI', NULL, NULL, N'https://adsgofastkeyvault.vault.azure.net/', N'
    {
        "Database" : "AWSample"
    }
', 1, 1)
GO
SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF
GO
