                MERGE 
                    [dbo].[TaskGroupDependency] AS [Target]
                USING 
                    (SELECT  
                        AncestorTaskGroupId = -9, 
                        DescendantTaskGroupId = -10, 
                        DependencyType = 'EntireGroup') AS [Source] 
                ON 
                    [Target].AncestorTaskGroupId = [Source].AncestorTaskGroupId AND [Target].DescendantTaskGroupId = [Source].DescendantTaskGroupId
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].AncestorTaskGroupId = [Source].AncestorTaskGroupId,
                        [Target].DescendantTaskGroupId = [Source].DescendantTaskGroupId,
                        [Target].DependencyType = [Source].DependencyType
                WHEN NOT MATCHED THEN
                    INSERT 
                        (AncestorTaskGroupId, 
                        DescendantTaskGroupId,
                        DependencyType)
                    VALUES 
                        ([Source].AncestorTaskGroupId,
                        [Source].DescendantTaskGroupId,
                        [Source].DependencyType);
                GO
