CREATE TABLE [dm].[DimStudentSectionEnrollment] (
	[StudentSectionEnrollmentKey] bigint identity(1, 1) not null,
	[StudentKey] bigint null,
	[SectionInfoKey] bigint null,
	[SchoolYear] numeric(4,0) null,
	[EntryDate] datetime null,
	[ExitDate] datetime null,
	[Status] varchar(50) null,
	[ValidFrom]       DATETIME2 (7)  NOT NULL,
    [ValidTo]         DATETIME2 (7)  NULL,
    [IsActive]        BIT NOT NULL,
    [CreatedOn]       DATETIME2 (7)  NOT NULL,
    [CreatedBy]       VARCHAR (256)  NOT NULL,
    [UpdatedOn]       DATETIME2 (7)  NULL,
    [UpdatedBy]       VARCHAR (256)   NOT NULL,
    [HashKey] varbinary(32) null
);