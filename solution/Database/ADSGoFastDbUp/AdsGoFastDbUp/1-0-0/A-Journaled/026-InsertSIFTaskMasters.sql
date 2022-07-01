
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - StudentPersonal', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StudentPersonal*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"Target":{"DataFileName":"StudentPersonal","RelativePath":"/synapse/sif/StudentPersonal/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - Calendar Date', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"CalendarDate*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"Target":{"DataFileName":"CalendarDate","RelativePath":"/synapse/sif/CalendarDate/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ([TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
                   VALUES (N'SIF - StudentSchoolEnrollment', -5, -1,          -4, -4, -5,                                            1, 0,                                                N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StudentSchoolEnrollment*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"Target":{"DataFileName":"StudentSchoolEnrollment","RelativePath":"/synapse/sif/StudentSchoolEnrollmenT/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - StaffPersonal', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StaffPersonal*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"StaffPersonal","RelativePath":"/synapse/sif/StaffPersonal/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - TeachingGroup', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"TeachingGroup*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"TeachingGroup","RelativePath":"/synapse/sif/TeachingGroup/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - SectionInfo', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"SectionInfo*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"SectionInfo","RelativePath":"/synapse/sif/SectionInfo/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - TermInfo', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"TermInfo*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                          "Target":{"DataFileName":"TermInfo","RelativePath":"/synapse/sif/TermInfo/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - LearningStandardItem', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"LearningStandardItem*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},  "Target":{"DataFileName":"LearningStandardItem","RelativePath":"/synapse/sif/LearningStandardItem/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO

INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - StudentSectionEnrollment', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StudentSectionEnrollment*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},   "Target":{"DataFileName":"StudentSectionEnrollment","RelativePath":"/synapse/sif/StudentSectionEnrollment/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO


INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - GradingAssignment', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"GradingAssignment*.json","RelativePath":"/samples/sif/GradingAssignment/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"Target":{"DataFileName":"GradingAssignment","RelativePath":"/synapse/sif/GradingAssignment/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO  
  
 INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - GradingAssignmentScore', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"GradingAssignmentScore*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},        "Target":{"DataFileName":"GradingAssignmentScore","RelativePath":"/synapse/sif/GradingAssignmentScore/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO 

 INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - MarkValueInfo', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"GradingAssignmentScore*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},        "Target":{"DataFileName":"GradingAssignmentScore","RelativePath":"/synapse/sif/GradingAssignmentScore/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO  
  
  
  INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - StudentGrade', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StudentGrade*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"StudentGrade","RelativePath":"/synapse/sif/StudentGrade/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO

INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - StudentScoreJudgementAgainstStandard', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StudentScoreJudgementAgainstStandard*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"StudentScoreJudgementAgainstStandard","RelativePath":"/synapse/sif/StudentScoreJudgementAgainstStandard/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO


INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - SchoolInfo', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"SchoolInfo*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"SchoolInfo","RelativePath":"/synapse/sif/SchoolInfo/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO


INSERT [dbo].[TaskMaster] ( [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [EngineId]) 
VALUES (N'SIF - StudentDailyAttendance', -5, -1, -4, -4, -5, 1, 0, N'Azure', N'{"CustomDefinitions":"","ExecuteNotebook":"SIFParameterizedJson","Purview":"Disabled","QualifiedIDAssociation":"TaskMasterId","Source":{"DataFileName":"StudentDailyAttendance*.json","RelativePath":"/samples/sif/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},                    "Target":{"DataFileName":"StudentDailyAttendance","RelativePath":"/synapse/sif/StudentDailyAttendance/","SchemaFileName":"","Type":"Notebook-Optional","WriteSchemaToPurview":"Disabled"},"UseNotebookActivity":"Enabled"}', 1, NULL, -2)
GO
