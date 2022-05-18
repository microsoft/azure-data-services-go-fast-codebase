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
	[AdministratorAttendanceValue] numeric(4,1) NULL
)
