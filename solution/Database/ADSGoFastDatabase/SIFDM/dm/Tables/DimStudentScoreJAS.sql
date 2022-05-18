CREATE TABLE [dm].[DimStudentScoreJAS]
(
	[StudentScoreJASKey] bigint NOT NULL,
	[SchoolYear] numeric(4,0) NOT NULL,
	[TermInfoKey] bigint NOT NULL,
	[LocalTermCode] varchar(255) NULL,
	[StudentKey] bigint NOT NULL,
	[StudentStateProvinceId] varchar(255) NULL,
	[StudentLocalId] varchar(255) NULL,
	[YearLevel] varchar(10) NULL,
	[TeachingGroupKey] bigint NOT NULL,
	[ClassLocalId] varchar(255) NULL,
	[StaffKey] bigint NULL,
	[StaffLocalId] varchar(255) NULL,
	[LearningStandardList] varchar(1000) NULL,
	[CurriculumCode] varchar(255) NULL,
	[CurriculumNodeCode] varchar(255) NULL,
	[Score] varchar(255) NULL,
	[SpecialCircumstanceLocalCode] varchar(255) NULL,
	[ManagedPathwayLocalCode] varchar(255) NULL,
	[SchoolInfoRefId] varchar(255) NULL,
	[SchoolLocalId] varchar(255) NULL,
	[SchoolCommonwealthId] varchar(255) NULL

)
