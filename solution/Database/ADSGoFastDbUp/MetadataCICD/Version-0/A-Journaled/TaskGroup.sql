        SET IDENTITY_INSERT [dbo].[TaskGroup] ON
        GO
                MERGE 
                    [dbo].[TaskGroup] AS [Target]
                USING 
                    (SELECT  
                        TaskGroupId = 10, 
                        SubjectAreaId = 1, 
                        TaskGroupName = 'Sample Task Group', 
                        TaskGroupPriority = 0, 
                        TaskGroupConcurrency = 10,
                        TaskGroupJSON = '{}',
                        MaximumTaskRetries = 3,
                        ActiveYN = 1) AS [Source] 
                ON 
                    [Target].TaskGroupId = [Source].TaskGroupId 
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].SubjectAreaId = [Source].SubjectAreaId,
                        [Target].TaskGroupName = [Source].TaskGroupName,
                        [Target].TaskGroupPriority = [Source].TaskGroupPriority,
                        [Target].TaskGroupConcurrency = [Source].TaskGroupConcurrency,
                        [Target].TaskGroupJSON = [Source].TaskGroupJSON,
                        [Target].MaximumTaskRetries = [Source].MaximumTaskRetries,
                        [Target].ActiveYN = [Source].ActiveYN
                WHEN NOT MATCHED THEN
                    INSERT 
                        (TaskGroupId, 
                        SubjectAreaId,
                        TaskGroupName,
                        TaskGroupPriority,
                        TaskGroupConcurrency,
                        TaskGroupJSON,
                        MaximumTaskRetries,
                        ActiveYN)
                    VALUES 
                        ([Source].TaskGroupId,
                        [Source].SubjectAreaId,
                        [Source].TaskGroupName,
                        [Source].TaskGroupPriority,
                        [Source].TaskGroupConcurrency,
                        [Source].TaskGroupJSON,
                        [Source].MaximumTaskRetries,
                        [Source].ActiveYN);
                GO
        SET IDENTITY_INSERT [dbo].[TaskGroup] OFF
        GO
        
