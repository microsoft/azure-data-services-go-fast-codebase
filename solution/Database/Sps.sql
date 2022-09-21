/****** Object:  StoredProcedure [dm].[usp_Merge_DimTermResults]    Script Date: 9/09/2021 11:10:43 AM ******/
SET ANSI_NULLS ON
GO
/****** Object:  StoredProcedure [dm].[usp_Merge_DimTeacherClasses]    Script Date: 9/09/2021 11:10:28 AM ******/
SET ANSI_NULLS ON
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET QUOTED_IDENTIFIER ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dm].[usp_Merge_DimAbsent]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimAbsent] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimAbsent]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Absent;
SELECT * INTO #Absent FROM dm.StgAbsent;
ALTER TABLE #Absent ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM(CAST([AbsentDate] AS VARCHAR)), '')
				+ ISNULL(TRIM([AbsentTypeCode]), '')
				+ ISNULL(TRIM([AbsentTypeDescription]), '')
				+ ISNULL(TRIM([AcceptIndicator]), '')
			 ) 
	as binary(32)
	)
FROM #Absent t;

INSERT INTO dm.DimAbsent
(
	     [StudentID]
        ,[AbsentDate]
        ,[AbsentTypeCode]
        ,[AbsentTypeDescription]
        ,[AcceptIndicator]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[StudentID]
      ,s.[AbsentDate]
      ,s.[AbsentTypeCode]
      ,s.[AbsentTypeDescription]
      ,s.[AcceptIndicator]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Absent s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimAbsent t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimAbsent t
WHERE NOT EXISTS (SELECT 1 FROM #Absent s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO


CREATE PROC [dm].[usp_Merge_DimAddress]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimAddress] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimAddress]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Address;
SELECT * INTO #Address FROM dm.StgAddress;
ALTER TABLE #Address ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM([City]), '')
				+ ISNULL(TRIM([PostCode]), '')
				+ ISNULL(TRIM([State]), '')
				+ ISNULL(TRIM([AddressType]), '')
			 ) 
	as binary(32)
	)
FROM #Address t;

INSERT INTO dm.DimAddress
(
	     [StudentID]
        ,[City]
        ,[PostCode]
        ,[State]
        ,[AddressType]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[StudentID]
      ,s.[City]
      ,s.[PostCode]
      ,s.[State]
      ,s.[AddressType]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Address s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimAddress t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimAddress t
WHERE NOT EXISTS (SELECT 1 FROM #Address s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO

CREATE PROC [dm].[usp_Merge_DimConduct]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimConduct] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimConduct]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Conduct;
SELECT * INTO #Conduct FROM dm.StgConduct;
ALTER TABLE #Conduct ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM(CAST([ConductDate] AS VARCHAR)), '')
				+ ISNULL(TRIM([ConductCode]), '')
				+ ISNULL(TRIM([ConductDescription]), '')
			 ) 
	as binary(32)
	)
FROM #Conduct t;

INSERT INTO dm.DimConduct
(
	     [StudentID]
		,[ConductDate]
		,[ConductCode]
		,[ConductDescription]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[StudentID]
      ,s.[ConductDate]
      ,s.[ConductCode]
      ,s.[ConductDescription]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Conduct s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimConduct t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimConduct t
WHERE NOT EXISTS (SELECT 1 FROM #Conduct s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO




CREATE PROC [dm].[usp_Merge_DimEnrolment]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimEnrolment] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimEnrolment]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Enrolment;
SELECT * INTO #Enrolment FROM dm.StgEnrolment;
ALTER TABLE #Enrolment ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([EnrolmentID]), '')
				+ ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM(CAST([EntryYear] AS VARCHAR)), '')
				+ ISNULL(TRIM([YearLevel]), '')
				+ ISNULL(TRIM(CAST([StageOrder] AS VARCHAR)), '')
				+ ISNULL(TRIM([StageName]), '')
				+ ISNULL(TRIM([CampusName]), '')
				+ ISNULL(TRIM([City]), '')
				+ ISNULL(TRIM([PostCode]), '')
				+ ISNULL(TRIM([State]), '')
				+ ISNULL(TRIM([Country]), '')
			 ) 
	as binary(32)
	)
FROM #Enrolment t;

INSERT INTO dm.DimEnrolment
(
	     [EnrolmentID]
        ,[StudentID]
        ,[EntryYear]
        ,[YearLevel]
        ,[StageOrder]
        ,[StageName]
        ,[CampusName]
        ,[City]
        ,[PostCode]
        ,[State]
		,[Country]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[EnrolmentID]
      ,s.[StudentID]
      ,s.[EntryYear]
      ,s.[YearLevel]
      ,s.[StageOrder]
      ,s.[StageName]
      ,s.[CampusName]
      ,s.[City]
      ,s.[PostCode]
      ,s.[State]
	  ,s.[Country]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Enrolment s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimEnrolment t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimEnrolment t
WHERE NOT EXISTS (SELECT 1 FROM #Enrolment s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO


CREATE PROC [dm].[usp_Merge_DimNaplan]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimNaplan] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimNaplan]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Naplan;
SELECT * INTO #Naplan FROM dm.StgNaplan;
ALTER TABLE #Naplan ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM(CAST([NPCalYear] AS VARCHAR)), '')
				+ ISNULL(TRIM(CAST([NPYearLevel] AS VARCHAR)), '')				
				+ ISNULL(TRIM([NPDomain]), '')
				+ ISNULL(TRIM([NPCategory]), '')
				+ ISNULL(TRIM(CAST([NPBandScore] AS VARCHAR)), '')
				+ ISNULL(TRIM(CAST([NPScaledScore] AS VARCHAR)), '')
			 ) 
	as binary(32)
	)
FROM #Naplan t;

INSERT INTO dm.DimNaplan
(
	     [StudentID]
		,[NPCalYear]
		,[NPYearLevel]
		,[NPDomain]
		,[NPCategory]
		,[NPBandScore]
		,[NPScaledScore]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[StudentID]
      ,s.[NPCalYear]
      ,s.[NPYearLevel]
      ,s.[NPDomain]
	  ,s.[NPCategory]
      ,s.[NPBandScore]
      ,s.[NPScaledScore]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Naplan s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimNaplan t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimNaplan t
WHERE NOT EXISTS (SELECT 1 FROM #Naplan s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO


SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dm].[usp_Merge_DimStudent]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimStudent] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimStudent]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Student;
SELECT * INTO #Student FROM dm.StgStudent;
ALTER TABLE #Student ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM([FirstName]), '')
				+ ISNULL(TRIM([LastName]), '')
				+ ISNULL(TRIM([FullName]), '')
				+ ISNULL(TRIM([Gender]), '')
				+ ISNULL(TRIM(CAST([DOB] AS VARCHAR)), '')
				+ ISNULL(TRIM([YearLevel]), '')
				+ ISNULL(TRIM([Class]), '')
				+ ISNULL(TRIM([YearOfEnrolment]), '')
				+ ISNULL(TRIM([Boarder]), '')
				+ ISNULL(TRIM(CAST([HomePostCode] AS VARCHAR)), '')
				+ ISNULL(TRIM(CAST([Disability] AS VARCHAR)), '')
				+ ISNULL(TRIM(CAST([Status] AS VARCHAR)), '')
			 ) 
	as binary(32)
	)
FROM #Student t;

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimStudent t
JOIN #Student s
ON  t.StudentID      =  s.StudentID
AND t.HashKey <> s.HashKey
AND t.IsActive=1;

INSERT INTO dm.DimStudent
(
	     [StudentID]
        ,[FirstName]
        ,[LastName]
		,[FullName]
        ,[Gender]
        ,[DOB]
        ,[YearLevel]
        ,[Class]
        ,[YearOfEnrolment]
        ,[Boarder]
        ,[HomePostCode]
        ,[Disability]
        ,[Status]
        ,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[StudentID]
      ,s.[FirstName]
      ,s.[LastName]
	  ,s.[FullName]
      ,s.[Gender]
      ,s.[DOB]
      ,s.[YearLevel]
      ,s.[Class]
      ,s.[YearOfEnrolment]
      ,s.[Boarder]
      ,s.[HomePostCode]
      ,s.[Disability]
      ,s.[Status]
      ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Student s
WHERE NOT EXISTS (SELECT 1 FROM dm.DimStudent t WHERE s.StudentID=t.StudentID AND t.IsActive=1);

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimStudent t
WHERE NOT EXISTS (SELECT 1 FROM #Student s WHERE t.StudentID = s.StudentID)
AND t.IsActive=1;

END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO


CREATE PROC [dm].[usp_Merge_DimSubject]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimSubject] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimSubject]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Subject;
SELECT * INTO #Subject FROM dm.StgSubject;
ALTER TABLE #Subject ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([SubjectID]), '')
				+ ISNULL(TRIM([SubjectName]), '')
				+ ISNULL(TRIM([SubjectReportFlag]), '')
				+ ISNULL(TRIM([SubjectDepartment]), '')
				+ ISNULL(TRIM([SubjectYearLevel]), '')
				+ ISNULL(TRIM([SubjectGPAIncludeFlag]), '')
			 ) 
	as binary(32)
	)
FROM #Subject t;

INSERT INTO dm.DimSubject
(
	     [SubjectID]
		,[SubjectName]
		,[SubjectReportFlag]
		,[SubjectDepartment]
		,[SubjectYearLevel]
		,[SubjectGPAIncludeFlag]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[SubjectID]
      ,s.[SubjectName]
      ,s.[SubjectReportFlag]
	  ,s.[SubjectDepartment]
	  ,s.[SubjectYearLevel]
	  ,s.[SubjectGPAIncludeFlag]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Subject s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimSubject t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimSubject t
WHERE NOT EXISTS (SELECT 1 FROM #Subject s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO


/****** Object:  StoredProcedure [dm].[usp_Merge_DimTeacher]    Script Date: 9/09/2021 11:10:13 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dm].[usp_Merge_DimTeacher]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimTeacher] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimTeacher]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #Teacher;
SELECT * INTO #Teacher FROM dm.StgTeacher;
ALTER TABLE #Teacher ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([TeacherID]), '')
				+ ISNULL(TRIM([FullName]), '')
				+ ISNULL(TRIM([Email]), '')
			 ) 
	as binary(32)
	)
FROM #Teacher t;

INSERT INTO dm.DimTeacher
(
	     [TeacherID]
		,[FullName]
		,[Email]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[TeacherID]
      ,s.[FullName]
      ,s.[Email]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #Teacher s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimTeacher t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimTeacher t
WHERE NOT EXISTS (SELECT 1 FROM #Teacher s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO


SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dm].[usp_Merge_DimTeacherClasses]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimTeacherClasses] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimTeacherClasses]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #TeacherClasses;
SELECT * INTO #TeacherClasses FROM dm.StgTeacherClasses;
ALTER TABLE #TeacherClasses ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([TeacherID]), '')
				+ ISNULL(TRIM([SubjectID]), '')
				+ ISNULL(TRIM([SubjectYearLevel]), '')
				+ ISNULL(TRIM(CAST([ReportingPeriod] AS VARCHAR)), '')
				+ ISNULL(TRIM(CAST([CalendarYear] AS VARCHAR)), '')
				+ ISNULL(TRIM(CAST([Class] AS VARCHAR)), '')
			 ) 
	as binary(32)
	)
FROM #TeacherClasses t;

INSERT INTO dm.DimTeacherClasses
(
	     [TeacherID]
		,[SubjectID]
		,[SubjectYearLevel]
		,[ReportingPeriod]
		,[CalendarYear]
		,[Class]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[TeacherID]
      ,s.[SubjectID]
      ,s.[SubjectYearLevel]
	  ,s.[ReportingPeriod]
	  ,s.[CalendarYear]
	  ,s.[Class]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #TeacherClasses s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimTeacherClasses t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimTeacherClasses t
WHERE NOT EXISTS (SELECT 1 FROM #TeacherClasses s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE PROC [dm].[usp_Merge_DimTermResults]
AS
BEGIN

SET NOCOUNT ON;

--==========================================================================================
-- Author:      MOQdigital - Suraj Sharma
-- Create date: 2021-07-01
-- Description: Update [DimTermResults] table 
-- ErrorMessage - error message output
-- example: exec [dm].[usp_Merge_DimTermResults]      
-- ==========================================================================================

BEGIN TRY

DROP TABLE IF EXISTS #TermResults;
SELECT * INTO #TermResults FROM dm.StgTermResults;
ALTER TABLE #TermResults ADD HashKey VARBINARY (32);

UPDATE t
SET HashKey = 
CAST(
	HASHBYTES('SHA2_256', 
				  ISNULL(TRIM([StudentID]), '')
				+ ISNULL(TRIM([YearLevel]), '')
				+ ISNULL(TRIM([Class]), '')
				+ ISNULL(TRIM([ResultPeriod]), '')
				+ ISNULL(TRIM([ResultTypeID]), '')
				+ ISNULL(TRIM([TeacherID]), '')
				+ ISNULL(TRIM([SubjectID]), '')
				+ ISNULL(TRIM([Score]), '')
				+ ISNULL(TRIM(CAST([ScoreNumeric] AS VARCHAR)), '')
				+ ISNULL(TRIM([ResultYear]), '')
			 ) 
	as binary(32)
	)
FROM #TermResults t;

INSERT INTO dm.DimTermResults
(
	     [StudentID]
		,[YearLevel]
		,[Class]
		,[ResultPeriod]
		,[ResultTypeID]
		,[TeacherID]
		,[SubjectID]
		,[Score]
		,[ScoreNumeric]
		,[ResultYear]
		,[HashKey]
        ,[ValidFrom]
        ,[ValidTo]
        ,[IsActive]
        ,[CreatedOn]
        ,[CreatedBy]
        ,[UpdatedOn]
        ,[UpdatedBy]
)
SELECT
	   s.[StudentID]
      ,s.[YearLevel]
      ,s.[Class]
	  ,s.[ResultPeriod]
	  ,s.[ResultTypeID]
	  ,s.[TeacherID]
	  ,s.[SubjectID]
	  ,s.[Score]
	  ,s.[ScoreNumeric]
	  ,s.[ResultYear]
	  ,s.[HashKey]
      ,  [ValidFrom] = getdate()
      ,  [ValidTo]   = '9999-12-31 00:00:00.000'
      ,  [IsActive]  = 1
      ,  [CreatedOn] = getdate()
      ,  [CreatedBy] = suser_sname()
      ,  [UpdatedOn] = getdate()
      ,  [UpdatedBy] = suser_sname()
FROM #TermResults s
WHERE NOT EXISTS (		
					SELECT 1 FROM dm.DimTermResults t 
					WHERE   s.HashKey   = t.HashKey
						AND t.IsActive=1
				 );

UPDATE t
SET 
    [ValidTo]	= getdate(), 
    IsActive	= 0, 
    [UpdatedOn] = getdate(), 
    [UpdatedBy] = suser_sname()
FROM dm.DimTermResults t
WHERE NOT EXISTS (SELECT 1 FROM #TermResults s WHERE   s.HashKey   = t.HashKey)
AND t.IsActive=1;


END TRY

BEGIN CATCH
 
  IF @@TRANCOUNT > 0
     ROLLBACK
 
    SELECT
         ERROR_NUMBER() AS ErrorNumber
        ,ERROR_SEVERITY() AS ErrorSeverity
        ,ERROR_STATE() AS ErrorState
        ,ERROR_PROCEDURE() AS ErrorProcedure
        ,ERROR_LINE() AS ErrorLine
        ,ERROR_MESSAGE() AS ErrorMessage;
    RETURN;
END CATCH

END
GO

