CREATE TABLE [dm].[DimStudentGrade]
(
	[StudentGradePK] bigint NOT NULL,
	[StudentKey] bigint NOT NULL,
	[HomeGroup] varchar(255) NULL,
	[YearLevel] varchar(10) NULL,
	[TeachingGroupShortName] varchar(255) NULL,
	[TeachingGroupKey] bigint NULL,
	[StaffKey] bigint NOT NULL,
	[SchoolInfoKey] bigint NOT NULL,
	[TermInfoKey] bigint NOT NULL,
	[Description] varchar(255) NULL,
	[GradePercentage] numeric(5,2) NULL,
	[GradeNumeric] numeric(5,2) NULL,
	[GradeLetter] varchar(10) NULL,
	[GradeNarrative] varchar(255) NULL,
	[MarkInfoKey] bigint NOT NULL,
	[TeacherJudgement] varchar(255) NULL,
	[TermSpan] varchar(4) NULL,
	[SchoolYear] varchar(4) NULL
)
