CREATE TABLE [dm].[DimStudentSectionEnrollment] (
	[StudentSectionEnrollmentKey] bigint identity(1, 1) not null,
	[StudentKey] bigint null,
	[SectionInfoKey] bigint null,
	[SchoolYear] numeric(4,0) null,
	[EntryDate] datetime null,
	[ExitDate] datetime null,
	[Status] varchar(50) null,
	[ValidFrom] datetime2(7) constraint [DF_DimStuEnr_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimStuEnr__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimStuEnr__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimStuEnr__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimStuEnr__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimStuEnr__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
);