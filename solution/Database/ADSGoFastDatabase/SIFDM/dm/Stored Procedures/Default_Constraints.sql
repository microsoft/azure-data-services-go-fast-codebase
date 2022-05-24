-- DimStudent
ALTER TABLE [dm].[DimStudent] ADD  CONSTRAINT [DF__DimStuden__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimStudent] ADD CONSTRAINT [DF__DimStuden__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimStudent] ADD CONSTRAINT [DF__DimStuden__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimStudent] ADD CONSTRAINT [DF__DimStuden__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimStudent] ADD CONSTRAINT [DF__DimStuden__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimStudent] ADD CONSTRAINT [DF__DimStuden__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimStaff
ALTER TABLE [dm].[DimStaff] ADD  CONSTRAINT [DF__DimStaff__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimStaff] ADD CONSTRAINT [DF__DimStaff__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimStaff] ADD CONSTRAINT [DF__DimStaff__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimStaff] ADD CONSTRAINT [DF__DimStaff__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimStaff] ADD CONSTRAINT [DF__DimStaff__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimStaff] ADD CONSTRAINT [DF__DimStaff__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimTeachingGroup
ALTER TABLE [dm].[DimTeachingGroup] ADD  CONSTRAINT [DF__DimTeachingGroup__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimTeachingGroup] ADD CONSTRAINT [DF__DimTeachingGroup__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimTeachingGroup] ADD CONSTRAINT [DF__DimTeachingGroup__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimTeachingGroup] ADD CONSTRAINT [DF__DimTeachingGroup__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimTeachingGroup] ADD CONSTRAINT [DF__DimTeachingGroup__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimTeachingGroup] ADD CONSTRAINT [DF__DimTeachingGroup__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimSectionInfo
ALTER TABLE [dm].[DimSectionInfo] ADD  CONSTRAINT [DF__DimSectionInfo__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimSectionInfo] ADD CONSTRAINT [DF__DimSectionInfo__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimSectionInfo] ADD CONSTRAINT [DF__DimSectionInfo__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimSectionInfo] ADD CONSTRAINT [DF__DimSectionInfo__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimSectionInfo] ADD CONSTRAINT [DF__DimSectionInfo__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimSectionInfo] ADD CONSTRAINT [DF__DimSectionInfo__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimStudentSectionEnrollment
ALTER TABLE [dm].[DimStudentSectionEnrollment] ADD  CONSTRAINT [DF__DimSSEnroll__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimStudentSectionEnrollment] ADD CONSTRAINT [DF__DimSSEnroll__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimStudentSectionEnrollment] ADD CONSTRAINT [DF__DimSSEnroll__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimStudentSectionEnrollment] ADD CONSTRAINT [DF__DimSSEnroll__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimStudentSectionEnrollment] ADD CONSTRAINT [DF__DimSSEnroll__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimStudentSectionEnrollment] ADD CONSTRAINT [DF__DimSSEnroll__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO


-- DimTermInfo
ALTER TABLE [dm].[DimTermInfo] ADD  CONSTRAINT [DF__DimTermInfo__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimTermInfo] ADD CONSTRAINT [DF__DimTermInfo__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimTermInfo] ADD CONSTRAINT [DF__DimTermInfo__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimTermInfo] ADD CONSTRAINT [DF__DimTermInfo__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimTermInfo] ADD CONSTRAINT [DF__DimTermInfo__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimTermInfo] ADD CONSTRAINT [DF__DimTermInfo__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO


-- DimLearningInfo
ALTER TABLE [dm].[DimLearningInfo] ADD  CONSTRAINT [DF__DimLearningInfo__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimLearningInfo] ADD CONSTRAINT [DF__DimLearningInfo__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimLearningInfo] ADD CONSTRAINT [DF__DimLearningInfo__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimLearningInfo] ADD CONSTRAINT [DF__DimLearningInfo__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimLearningInfo] ADD CONSTRAINT [DF__DimLearningInfo__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimLearningInfo] ADD CONSTRAINT [DF__DimLearningInfo__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimGradingInfo
ALTER TABLE [dm].[DimGradingInfo] ADD  CONSTRAINT [DF__DimGradingInfo__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimGradingInfo] ADD CONSTRAINT [DF__DimGradingInfo__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimGradingInfo] ADD CONSTRAINT [DF__DimGradingInfo__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimGradingInfo] ADD CONSTRAINT [DF__DimGradingInfo__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimGradingInfo] ADD CONSTRAINT [DF__DimGradingInfo__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimGradingInfo] ADD CONSTRAINT [DF__DimGradingInfo__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO


-- DimAssignmentScore
ALTER TABLE [dm].[DimAssignmentScore] ADD  CONSTRAINT [DF__DimAssignScore__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimAssignmentScore] ADD CONSTRAINT [DF__DimAssignScore__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimAssignmentScore] ADD CONSTRAINT [DF__DimAssignScore__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimAssignmentScore] ADD CONSTRAINT [DF__DimAssignScore__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimAssignmentScore] ADD CONSTRAINT [DF__DimAssignScore__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimAssignmentScore] ADD CONSTRAINT [DF__DimAssignScore__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimMarkInfo
ALTER TABLE [dm].[DimMarkInfo] ADD  CONSTRAINT [DF__DimMarkInfo__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimMarkInfo] ADD CONSTRAINT [DF__DimMarkInfo__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimMarkInfo] ADD CONSTRAINT [DF__DimMarkInfo__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimMarkInfo] ADD CONSTRAINT [DF__DimMarkInfo__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimMarkInfo] ADD CONSTRAINT [DF__DimMarkInfo__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimMarkInfo] ADD CONSTRAINT [DF__DimMarkInfo__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

--DimStudentGrade
ALTER TABLE [dm].[DimStudentGrade] ADD  CONSTRAINT [DF__DimStudentGrade__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimStudentGrade] ADD CONSTRAINT [DF__DimStudentGrade__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimStudentGrade] ADD CONSTRAINT [DF__DimStudentGrade__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimStudentGrade] ADD CONSTRAINT [DF__DimStudentGrade__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimStudentGrade] ADD CONSTRAINT [DF__DimStudentGrade__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimStudentGrade] ADD CONSTRAINT [DF__DimStudentGrade__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO



-- DimStudentScoreJAS
ALTER TABLE [dm].[DimStudentScoreJAS] ADD  CONSTRAINT [DF__DimStudentScoreJAS__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimStudentScoreJAS] ADD CONSTRAINT [DF__DimStudentScoreJAS__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimStudentScoreJAS] ADD CONSTRAINT [DF__DimStudentScoreJAS__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimStudentScoreJAS] ADD CONSTRAINT [DF__DimStudentScoreJAS__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimStudentScoreJAS] ADD CONSTRAINT [DF__DimStudentScoreJAS__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimStudentScoreJAS] ADD CONSTRAINT [DF__DimStudentScoreJAS__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimSchoolInfo
ALTER TABLE [dm].[DimSchoolInfo] ADD  CONSTRAINT [DF__DimSchoolInfo__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimSchoolInfo] ADD CONSTRAINT [DF__DimSchoolInfo__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimSchoolInfo] ADD CONSTRAINT [DF__DimSchoolInfo__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimSchoolInfo] ADD CONSTRAINT [DF__DimSchoolInfo__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimSchoolInfo] ADD CONSTRAINT [DF__DimSchoolInfo__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimSchoolInfo] ADD CONSTRAINT [DF__DimSchoolInfo__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimStudentAttendance
ALTER TABLE [dm].[DimStudentAttendance] ADD  CONSTRAINT [DF__DimStudentAttendance__IsAct__37FA4C37]  DEFAULT ((1)) FOR [IsActive]
GO

ALTER TABLE [dm].[DimStudentAttendance] ADD CONSTRAINT [DF__DimStudentAttendance__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom]
GO

ALTER TABLE [dm].[DimStudentAttendance] ADD CONSTRAINT [DF__DimStudentAttendance__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn]       
GO

ALTER TABLE [dm].[DimStudentAttendance] ADD CONSTRAINT [DF__DimStudentAttendance__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy] 
GO

ALTER TABLE [dm].[DimStudentAttendance] ADD CONSTRAINT [DF__DimStudentAttendance__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn]
GO

ALTER TABLE [dm].[DimStudentAttendance] ADD CONSTRAINT [DF__DimStudentAttendance__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy]
GO

-- DimCalendarDate