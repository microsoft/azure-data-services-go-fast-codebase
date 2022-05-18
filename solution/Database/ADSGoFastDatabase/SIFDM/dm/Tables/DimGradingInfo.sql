CREATE TABLE [dm].[DimGradingInfo]
(
	[GradingAssignmentKey] bigint NOT NULL,
	[TeachingGroupKey] bigint NULL,
	[StudentKey] bigint NULL,
	[SchoolInfoKey] bigint NULL,
	[GradingCategory] varchar(255) NULL,
	[Description] varchar(1000) NOT NULL,
	[PointsPossible] int NULL,
	[CreateDate] datetime NULL,
	[DueDate] datetime NULL,
	[Weight] numeric(5,2) NULL,
	[MaxAttemptsAllowed] int NULL,
	[DetailedDescriptionURL] varchar(1000) NULL,
	[DetailedDescriptionBinary] varchar(max) NULL,
	[AssessmentType] varchar(255) NULL,
	[LevelAssessed] varchar(255) NULL,
	[AssignmentPurpose] varchar(255) NULL
)
