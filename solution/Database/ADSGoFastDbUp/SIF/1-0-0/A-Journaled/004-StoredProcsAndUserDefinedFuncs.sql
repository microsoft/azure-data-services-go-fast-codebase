

CREATE PROC [dm].[usp_Generate_DimDate]
AS
BEGIN

/*
Author - MOQDigital - Suraj Sharma
Description - Generate DimDate

EXEC dbo.usp_Generate_DimDate
*/

if OBJECT_ID('tempdb..#dim') is not null
 drop table #dim;


DECLARE @StartDate DATE = '19450101', @NumberOfYears INT = 150;

-- prevent set or regional settings from interfering with 
-- interpretation of dates / literals

SET DATEFIRST 7;
SET DATEFORMAT dmy;
SET LANGUAGE ENGLISH



DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

-- this is just a holding table for intermediate calculations:

CREATE TABLE #dim
(
  [date]       DATE PRIMARY KEY, 
  [day]        AS DATEPART(DAY,      [date]),
  [month]      AS DATEPART(MONTH,    [date]),
  FirstOfMonth AS CONVERT(DATE, DATEADD(MONTH, DATEDIFF(MONTH, 0, [date]), 0)),
  LastofMonth  AS DATEADD(month, ((YEAR([date]) - 1900) * 12) + MONTH([date]), -1),
  [MonthName]  AS DATENAME(MONTH,    [date]),
  [week]       AS DATEPART(WEEK,     [date]),
  [DayOfWeek]  AS DATEPART(WEEKDAY,  [date]),
  [quarter]    AS DATEPART(QUARTER,  [date]),
  [year]       AS DATEPART(YEAR,     [date]),
  FirstOfYear  AS CONVERT(DATE, DATEADD(YEAR,  DATEDIFF(YEAR,  0, [date]), 0)),
  Style112     AS CONVERT(CHAR(8),   [date], 112),
  Style101     AS CONVERT(CHAR(10),  [date], 101),
  FinDate      AS dateadd(mm,-6,[date]),
  FinYearStr   AS convert(date, dateadd(month, datediff(month, 0, [date]) - (12 + datepart(month, [date]) - 7) % 12, 0)),
  FinYearEnd   AS convert(date, dateadd(month, datediff(month, 0, [date]) - (12 + datepart(month, [date]) - 7) % 12 + 12, -1))
);

-- use the catalog views to generate as many rows as we need

INSERT #dim([date]) 
SELECT d
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    -- on my system this would support > 5 million days
    ORDER BY s1.[object_id]
  ) AS x
) AS y;

Truncate table dm.DimDate ;
-- create other useful index(es) here
INSERT dm.DimDate WITH (TABLOCKX)
SELECT
  DATEKEY       = CONVERT(INT, Style112),
  CALENDAR_DATE        = [date],
  CALENDAR_DAY_OF_MONTH         = CONVERT(TINYINT, [day]),
  CALENDAR_DAY_SUFFIX     = CONVERT(CHAR(2), CASE WHEN [day] / 10 = 1 THEN 'th' ELSE 
                  CASE RIGHT([day], 1) WHEN '1' THEN 'st' WHEN '2' THEN 'nd' 
	              WHEN '3' THEN 'rd' ELSE 'th' END END),
  CALENDAR_DAY_OF_WEEK     = CONVERT(TINYINT, [DayOfWeek]),
  CALENDAR_DAY_OF_WEEK_NAME = CONVERT(VARCHAR(10), DATENAME(WEEKDAY, [date])),
  WEEKEND_IND   = CONVERT(BIT, CASE WHEN [DayOfWeek] IN (1,7) THEN 1 ELSE 0 END),
  HOLIDAY_IND   = CONVERT(BIT, 0),
  DOW_IN_MONTH  = CONVERT(TINYINT, ROW_NUMBER() OVER 
                  (PARTITION BY FirstOfMonth, [DayOfWeek] ORDER BY [date])),
  CALENDAR_DAY_OF_YEAR   = CONVERT(SMALLINT, DATEPART(DAYOFYEAR, [date])),
  CALENDAR_WEEK_OF_MONTH   = CONVERT(TINYINT, DENSE_RANK() OVER 
                  (PARTITION BY [year], [month] ORDER BY [week])),
  CALENDAR_WEEK_OF_YEAR    = CONVERT(TINYINT, [week]),
  CALENDAR_MONTH_NUMBER       = CONVERT(TINYINT, [month]),
  CALENDAR_MONTH_NAME   = CONVERT(VARCHAR(10), [MonthName]),
  CALENDAR_QUARTER     = CONCAT('Q',CONVERT(TINYINT, [quarter])),
  CALENDAR_QUARTER_NAME   = CONVERT(VARCHAR(6), CASE [quarter] WHEN 1 THEN 'First' 
                  WHEN 2 THEN 'Second' WHEN 3 THEN 'Third' WHEN 4 THEN 'Fourth' END), 
  CALENDAR_YEAR        = [year],
  CALENDAR_YYYYMM        = CONVERT(CHAR(6), LEFT(Style112, 4) + LEFT(Style101, 2)),
  CALENDAR_MONYYYY				= CONVERT(CHAR(7), LEFT([MonthName], 3) + LEFT(Style112, 4)),
  CALENDAR_YEAR_START_DATE      = FirstOfYear,
  CALENDAR_YEAR_END_DATE        = MAX([date]) OVER (PARTITION BY [year]),
  MONTH_START_DATE			    = FirstOfMonth,
  MONTH_END_DATE			    = MAX([date]) OVER (PARTITION BY [year], [month]),
  NEXT_MONTH_START_DATE			= DATEADD(MONTH, 1, FirstOfMonth),
  CALENDAR_DAYS_IN_MONTH		= datediff(day, [date], dateadd(month, 1, [date])),
  BUSINESS_DAYS_IN_MONTH		= (DATEDIFF(dd, FirstOfMonth, LastofMonth) + 1)  
									-(DATEDIFF(wk, FirstOfMonth, LastofMonth) * 2)
									-(CASE WHEN DATENAME(dw, FirstOfMonth) = 'Sunday' THEN 1 ELSE 0 END)
									-(CASE WHEN DATENAME(dw, LastofMonth) = 'Saturday' THEN 1 ELSE 0 END),
  FINANCIAL_DAY_OF_YEAR			= DATEDIFF( DAY,  FinYearStr,  [Date]) + 1,
  FINANCIAL_WEEK_OF_YEAR		= DATEDIFF( WEEK,  FinYearStr,  [Date]) + 1,
  FINANCIAL_MONTH_NUMBER		= DATEDIFF( MONTH,  FinYearStr,  [Date]) + 1,
  FINANCIAL_YYYYMM				= concat(year(FinYearStr),RIGHT('00' + CONVERT(NVARCHAR(2), DATEDIFF( month,  FinYearStr,  [Date]) + 1),2)),
  FINANCIAL_QUARTER				= CONCAT('Q',DATEDIFF( quarter,  FinYearStr,  [Date]) + 1),
  FINANCIAL_QUARTER_NAME		= CONVERT(VARCHAR(6), CASE DATEDIFF( quarter,  FinYearStr,  [Date]) + 1 WHEN 1 THEN 'First'  WHEN 2 THEN 'Second' WHEN 3 THEN 'Third' WHEN 4 THEN 'Fourth' END),
  FINANCIAL_YEAR				= year(FinYearStr) + 1,
  FINANCIAL_YEAR_YYYY_YY		= concat(concat(year(FinYearStr),'-'),(year(FinYearEnd)% 100)),
  FINANCIAL_YEAR_START_DATE		= FinYearStr,
  FINANCIAL_YEAR_END_DATE		= FinYearEnd
FROM #dim
OPTION (MAXDOP 1);

if OBJECT_ID('tempdb..#dim') is not null
 drop table #dim;

END
GO
PRINT N'Update complete.';


GO
