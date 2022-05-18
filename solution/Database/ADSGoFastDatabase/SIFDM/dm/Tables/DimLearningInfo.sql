CREATE TABLE [dm].DimLearningInfo
(
	[LearningStandardKey] bigint NOT NULL,
	[StandardSettingBodyCountryCode] varchar(10) NULL,
	[StandardSettingBodyStateProvince] varchar(3) NULL,
	[StandardSettingBodyBodyName] varchar(255) NULL,
	[StandardHierarchyLevelNumber] int NOT NULL,
	[StandardHierarchyLevelDescription] varchar(255) NOT NULL,
	[PredecessorItemKey] bigint NULL,
	[StatementCode] varchar(255) NULL,
	[Statement] varchar(1000) NULL,
	[LearningStandardDocumentKey] bigint NULL,
	[Level4] varchar(255) NULL,
	[Level5] varchar(255) NULL
)
