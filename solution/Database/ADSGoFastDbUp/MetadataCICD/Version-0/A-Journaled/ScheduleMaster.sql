        SET IDENTITY_INSERT [dbo].[ScheduleMaster] ON
        GO
                MERGE 
                    [dbo].[ScheduleMaster] AS [Target]
                USING 
                    (SELECT  
                        ScheduleMasterId = 2, 
                        ScheduleCronExpression = 'N/A', 
                        ScheduleDesciption = 'TEST', 
                        ActiveYN = 0) AS [Source] 
                ON 
                    [Target].ScheduleMasterId = [Source].ScheduleMasterId 
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].ScheduleCronExpression = [Source].ScheduleCronExpression,
                        [Target].ScheduleDesciption = [Source].ScheduleDesciption,
                        [Target].ActiveYN = [Source].ActiveYN
                WHEN NOT MATCHED THEN
                    INSERT 
                        (ScheduleMasterId, 
                        ScheduleCronExpression,
                        ScheduleDesciption,
                        ActiveYN)
                    VALUES 
                        ([Source].ScheduleMasterId,
                        [Source].ScheduleCronExpression,
                        [Source].ScheduleDesciption,
                        [Source].ActiveYN);
                GO
        SET IDENTITY_INSERT [dbo].[ScheduleMaster] OFF
        GO

