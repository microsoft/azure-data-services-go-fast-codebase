CREATE TABLE [dm].[DimStudentAttendance]
(
	[StudentDailyAttendanceKey] bigint NOT NULL,
	[StudentKey] bigint NOT NULL,
	[SchoolInfoKey] bigint NOT NULL,
	[CalendarDate] date NULL,
	[SchoolYear] varchar(4) NULL,
	[DayValue] varchar(10) NULL,
	[AttendanceCode] varchar(3) NULL,
	[AttendanceStatus] varchar(2) NULL,
	[TimeIn] datetime NULL,
	[TimeOut] datetime NULL,
	[AbsenceValue] float NULL,
	[AttendanceNote] varchar(8000) NULL,
	[Status] varchar(50) null,
	[ValidFrom] datetime2(7) constraint [DF_DimStAttd_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimStAttd__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimStAttd__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimStAttd__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimStAttd__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimStAttd__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
)
