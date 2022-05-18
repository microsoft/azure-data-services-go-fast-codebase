CREATE TABLE [dm].[DimCalendarDate]
(
	[CalendarDateKey] bigint NOT NULL,
	[CalendarDate] date NULL,
	[CalendarSummaryKey] bigint NOT NULL,
	[SchoolInfoKey] bigint NOT NULL,
	[SchoolYear] varchar(4) NULL,
	[CalendarDateType] varchar(4) NULL,
	[CalendarDateNumber] int NULL,
	[StudentCountsTowardAttendance] varchar(3) NULL,
	[StudentAttendanceValue] numeric(4,1) NULL,
	[TeacherCountsTowardAttendance] numeric(4,1) NULL,
	[TeacherAttendanceValue] numeric(4,1) NULL,
	[AdministratorCountsTowardAttendance] numeric(4,1) NULL,
	[AdministratorAttendanceValue] numeric(4,1) NULL,
	[ValidFrom] datetime2(7) constraint [DF_DimCalDate_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimCalDate__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimCalDate__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimCalDate__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimCalDate__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimCalDate__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
)
