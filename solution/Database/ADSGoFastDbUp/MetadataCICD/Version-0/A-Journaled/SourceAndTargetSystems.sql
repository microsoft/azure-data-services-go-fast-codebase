        SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON
        GO                MERGE 
                    [dbo].[SourceAndTargetSystems] AS [Target]
                USING 
                    (SELECT  
                        SystemId = 1, 
                        SystemName = 'testsource',
                        SystemType = 'N/A',
                        SystemDescription = 'testing purposes',
                        SystemServer = 'N/A',
                        SystemAuthType = 'MSI',
                        SystemUserName = 'testuser',
                        SystemSecretName = NULL,
                        SystemKeyVaultBaseUrl = 'https://$KeyVaultName$.vault.azure.net/', 
                        SystemJSON = '{}',  
                        ActiveYN = 0,
                        IsExternal = 0) AS [Source] 
                ON 
                    [Target].SystemId = [Source].SystemId 
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].SystemName = [Source].SystemName,
                        [Target].SystemType = [Source].SystemType,
                        [Target].SystemDescription = [Source].SystemDescription,
                        [Target].SystemServer = [Source].SystemServer,
                        [Target].SystemAuthType = [Source].SystemAuthType,
                        [Target].SystemUserName = [Source].SystemUserName,
                        [Target].SystemSecretName = [Source].SystemSecretName,
                        [Target].SystemKeyVaultBaseUrl = [Source].SystemKeyVaultBaseUrl,
                        [Target].SystemJSON = [Source].SystemJSON,
                        [Target].ActiveYN = [Source].ActiveYN,
                        [Target].IsExternal = [Source].IsExternal
                WHEN NOT MATCHED THEN
                    INSERT 
                        (SystemId,
                        SystemName, 
                        SystemType,
                        SystemDescription,
                        SystemServer,
                        SystemAuthType,
                        SystemUserName,
                        SystemSecretName,
                        SystemKeyVaultBaseUrl,
                        SystemJSON,
                        ActiveYN,
                        IsExternal)
                    VALUES 
                        ([Source].SystemId,
                        [Source].SystemName,
                        [Source].SystemType,
                        [Source].SystemDescription,
                        [Source].SystemServer,
                        [Source].SystemAuthType,
                        [Source].SystemUserName,
                        [Source].SystemSecretName,
                        [Source].SystemKeyVaultBaseUrl,
                        [Source].SystemJSON,
                        [Source].ActiveYN,
                        [Source].IsExternal);
                GO        SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF
        GO
