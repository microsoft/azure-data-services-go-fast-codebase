        SET IDENTITY_INSERT [dbo].[SubjectArea] ON
        GO                MERGE 
                    [dbo].[SubjectArea] AS [Target]
                USING 
                    (SELECT  
                        SubjectAreaId = 1, 
                        SubjectAreaName = 'Sample Subject Area', 
                        ActiveYN = 1,
                        SubjectAreaFormId = NULL,
                        DefaultTargetSchema = 'N/A',
                        UpdatedBy = 'system@microsoft.com',
                        ShortCode = 1) AS [Source] 
                ON 
                    [Target].SubjectAreaId = [Source].SubjectAreaId 
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].SubjectAreaName = [Source].SubjectAreaName,
                        [Target].ActiveYN = [Source].ActiveYN,
                        [Target].SubjectAreaFormId = [Source].SubjectAreaFormId,
                        [Target].DefaultTargetSchema = [Source].DefaultTargetSchema,
                        [Target].UpdatedBy = [Source].UpdatedBy,
                        [Target].ShortCode = [Source].ShortCode
                WHEN NOT MATCHED THEN
                    INSERT 
                        (SubjectAreaId, 
                        SubjectAreaName,
                        ActiveYN,
                        SubjectAreaFormId,
                        DefaultTargetSchema,
                        UpdatedBy,
                        ShortCode)
                    VALUES 
                        ([Source].SubjectAreaId,
                        [Source].SubjectAreaName,
                        [Source].ActiveYN,
                        [Source].SubjectAreaFormId,
                        [Source].DefaultTargetSchema,
                        [Source].UpdatedBy,
                        [Source].ShortCode);
                GO        SET IDENTITY_INSERT [dbo].[SubjectArea] OFF
        GO
