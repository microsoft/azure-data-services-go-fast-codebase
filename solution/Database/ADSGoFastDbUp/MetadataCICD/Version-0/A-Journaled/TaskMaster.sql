        SET IDENTITY_INSERT [dbo].[TaskMaster] ON
        GO
                MERGE 
                    [dbo].[TaskMaster] AS [Target]
                USING 
                    (SELECT 
                        TaskMasterId = 2, 
                        TaskMasterName = 'test Copy', 
                        TaskTypeId = -13, 
                        TaskGroupId = 10, 
                        ScheduleMasterId = -4,
                        SourceSystemId = -22,
                        TargetSystemId = -22,
                        DegreeOfCopyParallelism = 1,
                        AllowMultipleActiveInstances = 0,
                        TaskDatafactoryIR = 'VM-N/A',
                        TaskMasterJSON = '{"ExecutionPath":"/home/adminuser","Source":{"Type":"Not-Applicable"},"Target":{"ExecutionCommand":"dbt build","ExecutionParameters":"TestParameter","Type":"dbt"}}',
                        ActiveYN = 0,
                        DependencyChainTag = '',
                        EngineId = -3, 
                        InsertIntoCurrentSchedule = 0) AS [Source] 
                ON 
                    [Target].TaskMasterId = [Source].TaskMasterId 
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].TaskMasterName = [Source].TaskMasterName,
                        [Target].TaskTypeId = [Source].TaskTypeId,
                        [Target].TaskGroupId = [Source].TaskGroupId,
                        [Target].ScheduleMasterId = [Source].ScheduleMasterId,
                        [Target].SourceSystemId = [Source].SourceSystemId,
                        [Target].TargetSystemId = [Source].TargetSystemId,
                        [Target].DegreeOfCopyParallelism = [Source].DegreeOfCopyParallelism,
                        [Target].AllowMultipleActiveInstances = [Source].AllowMultipleActiveInstances,
                        [Target].TaskDatafactoryIR = [Source].TaskDatafactoryIR,
                        [Target].TaskMasterJSON = [Source].TaskMasterJSON,
                        [Target].DependencyChainTag = [Source].DependencyChainTag,
                        [Target].EngineId = [Source].EngineId
                WHEN NOT MATCHED THEN
                    INSERT 
                        (TaskMasterId, 
                        TaskMasterName,
                        TaskTypeId,
                        TaskGroupId,
                        ScheduleMasterId,
                        SourceSystemId,
                        TargetSystemId,
                        DegreeOfCopyParallelism,
                        AllowMultipleActiveInstances, 
                        TaskDatafactoryIR,
                        TaskMasterJSON,
                        ActiveYN,
                        DependencyChainTag,
                        EngineId,
                        InsertIntoCurrentSchedule)
                    VALUES 
                        ([Source].TaskMasterId,
                        [Source].TaskMasterName,
                        [Source].TaskTypeId,
                        [Source].TaskGroupId,
                        [Source].ScheduleMasterId,
                        [Source].SourceSystemId,
                        [Source].TargetSystemId,
                        [Source].DegreeOfCopyParallelism,
                        [Source].AllowMultipleActiveInstances,
                        [Source].TaskDatafactoryIR,
                        [Source].TaskMasterJSON,
                        0,
                        [Source].DependencyChainTag,
                        [Source].EngineId,
                        0);
                GO
        SET IDENTITY_INSERT [dbo].[TaskMaster] OFF
        GO

