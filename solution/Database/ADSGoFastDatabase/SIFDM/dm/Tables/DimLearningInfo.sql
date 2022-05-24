CREATE TABLE [dm].[DimLearningInfo]
(
	[LearningStandardKey] bigint identity(1, 1) not null,
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
	[Level5] varchar(255) NULL,
	[Status] varchar(50) null,
	[ValidFrom]       DATETIME2 (7)  NOT NULL,
    [ValidTo]         DATETIME2 (7)  NULL,
    [IsActive]        BIT NOT NULL,
    [CreatedOn]       DATETIME2 (7)  NOT NULL,
    [CreatedBy]       VARCHAR (256)  NOT NULL,
    [UpdatedOn]       DATETIME2 (7)  NULL,
    [UpdatedBy]       VARCHAR (256)   NOT NULL,
    [HashKey] varbinary(32) null
)
