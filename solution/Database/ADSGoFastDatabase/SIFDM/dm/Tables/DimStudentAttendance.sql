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
)
