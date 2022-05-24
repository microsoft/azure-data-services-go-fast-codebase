CREATE TABLE [dm].[DimStudentAttendance]
(
	[StudentDailyAttendanceKey] bigint identity(1, 1) not null,
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
	[ValidFrom]       DATETIME2 (7)  NOT NULL,
    [ValidTo]         DATETIME2 (7)  NULL,
    [IsActive]        BIT NOT NULL,
    [CreatedOn]       DATETIME2 (7)  NOT NULL,
    [CreatedBy]       VARCHAR (256)  NOT NULL,
    [UpdatedOn]       DATETIME2 (7)  NULL,
    [UpdatedBy]       VARCHAR (256)   NOT NULL,
    [HashKey] varbinary(32) null
)
