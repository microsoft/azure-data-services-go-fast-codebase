CREATE TABLE [dm].[DimLearningInfo]
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
	[Level5] varchar(255) NULL,
	[Status] varchar(50) null,
	[ValidFrom] datetime2(7) constraint [DF_DimLearn_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimLearn__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimLearn__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimLearn__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimLearn__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimLearn__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
)
