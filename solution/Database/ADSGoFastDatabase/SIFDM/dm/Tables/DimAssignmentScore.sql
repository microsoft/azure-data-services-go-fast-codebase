CREATE TABLE [dm].[DimAssignmentScore]
(
	[GradingAssignmentScoreKey] bigint NOT NULL,
	[StudentKey] bigint NOT NULL,
	[StudentId] varchar(50) NULL,
	[TeachingGroupKey] bigint NULL,
	[SchoolInfoKey] bigint NULL,
	[GradingAssignmentKey] bigint NOT NULL,
	[StaffKey] bigint NOT NULL,
	[DateGraded] datetime NULL,
	[ExpectedScore] bit NULL,
	[ScorePoints] int NULL,
	[ScorePercent] numeric(5,2) NULL,
	[ScoreLetter] varchar(5) NULL,
	[ScoreDescription] varchar(255) NULL,
	[TeacherJudgement] varchar(255) NULL,
	[MarkInfoKey] bigint NULL,
	[AssignmentScoreIteration] varchar(255) NULL
)
