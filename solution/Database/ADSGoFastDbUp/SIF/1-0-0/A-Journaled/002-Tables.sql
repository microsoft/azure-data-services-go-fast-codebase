PRINT N'Creating Table [dm].[DimSectionInfo]...';

CREATE TABLE [dm].[DimSectionInfo] (
	[SectionInfoKey] bigint identity(1, 1) not null,
	[SchoolCourseInfoKey] bigint null,
	[SectionInfoId] varchar(50) null,
	[Description] varchar(255) null,
	[SchoolYear] numeric(4,0) null,
	[TermInfoKey] bigint null,
	[MediumOfInstructionMain] varchar(255) null,
	[MediumOfInstructionOther] varchar(255) null,
	[LanguageOfInstructionMain] varchar(255) null,
	[LanguageOfInstructionOther] varchar(255) null,
	[LocationOfInstructionMain] varchar(255) null,
	[LocationOfInstructionOther] varchar(255) null,
	[IsSummerSchool] varchar(3) null,
	[CourseSectionCode] varchar(255) null,
	[SectionCode] varchar(255) null,
	[IsCountForAttendance] varchar(3) null,
	[Status] varchar(50) null,
	[ValidFrom] datetime2(7) constraint [DF_DimSecInfo_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimSecInfo__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimSecInfo__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimSecInfo__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimSecInfo__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimSecInfo__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
);
GO

PRINT N'Creating Table [dm].[DimStaff]...';

CREATE TABLE [dm].[DimStaff] (
    [StaffKey] bigint identity(1, 1) not null,
    [StaffId] varchar(50) null,
    [StateProvinceId] varchar(20) null,
    [FirstName] varchar(255) null,
    [LastName] varchar(255) null,
    [MiddleName] varchar(255) null,
    [OtherNames] varchar(255) null,
    [Title] varchar(50) null,
    [EmploymentStatus] varchar(1) null,
    [IndigenousStatus] smallint null,
    [Sex] varchar(10) null,
    [BirthDate] date null,
    [DateOfDeath] date null,
    [Deceased] varchar(2) null,
    [BirthDateVerification] varchar(50) null,
    [PlaceOfBirth] varchar(50) null,
    [StateOfBirth] varchar(50) null,
    [CountryOfBirth] varchar(50) null,
    [CountryOfCitizenship] varchar(50) null,
    [CountryOfCitizenship2] varchar(50) null,
    [CountryOfResidency] varchar(50) null,
    [CountryOfResidency2] varchar(50) null,
    [CountryArrivalDate] date null,
    [AustralianCitizenshipStatus] varchar(2) null,
    [EnglishProficiency] smallint null,
    [MainLanguageSpokenAtHome] varchar(50) null,
    [SecondLanguage] varchar(50) null,
    [OtherLanguage] varchar(50) null,
    [DwellingArrangement] varchar(50) null,
    [Religion] varchar(50) null,
    [ReligionEvent1] varchar(50) null,
    [ReligionEvent1Date] date null,
    [ReligionEvent2] varchar(50) null,
    [ReligionEvent2Date] date null,
    [ReligionEvent3] varchar(50) null,
    [ReligionEvent3Date] date null,
    [ReligiousRegion] varchar(50) null,
    [PermanentResident] varchar(2) null,
    [VisaSubClass] varchar(255) null,
    [VisaStatisticalCode] varchar(5) null,
    [TypeEmail1Description] varchar(2) null,
    [Email1] varchar(50) null,
    [TypeEmail2Description] varchar(2) null,
    [Email2] varchar(50) null,
    [Telephone1TypeDescription] varchar(2) null,
    [Telephone1] varchar(50) null,
    [Telephone2TypeDescription] varchar(2) null,
    [Telephone2] varchar(50) null,
    [Status] varchar(50) null,
    [ValidFrom] datetime2(7) constraint [DF_DimStaff_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimStaff__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimStaff__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimStaff__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimStaff__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimStaff__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
);
GO

PRINT N'Creating Table [dm].[DimStudentSectionEnrollment]...';

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
GO

PRINT N'Creating Table [dm].[DimTeachingGroup]...';

CREATE TABLE [dm].[DimTeachingGroup] (
	[TeachingGroupKey] bigint identity(1, 1) not null,
	[SchoolYear] numeric(4,0) null,
	[TeachingGroupId] varchar(50) null,
	[ShortName] varchar(20) null,
	[LongName] varchar(255) null,
	[GroupType] varchar(50) null,
	[SetNumber] int null,
	[BlockNumber] int null,
	[CurriculumLevel] varchar(255) null,
	[SchoolKey] bigint null,
	[SchoolId] varchar(50) null,
	[SchoolCourseKey] bigint null,
	[SchoolCourseId] varchar(50) null,
	[KeyLearningArea] varchar(20) null,
	[Semester] varchar(50) null,
	[MinClassSize] int null,
	[MaxClassSize] int null,
	[Status] varchar(50) null,
	[ValidFrom] datetime2(7) constraint [DF_DimTGroup_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimTGroup__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimTGroup__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimTGroup__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimTGroup__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimTGroup__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
);
GO

PRINT N'Creating Table [dm].[DimTermInfo]...';

CREATE TABLE [dm].[DimTermInfo] (
	[TermInfoKey] bigint identity(1, 1) not null,
	[SchoolInfoKey] bigint null, 
	[SchoolYearType] numeric(4,0) null, 
	[StartDate] date null, 
	[EndDate] date null, 
	[Description] varchar(255) null, 
	[RelativeDuration] numeric(10,4) null, 
	[TermCode] varchar(50) null, 
	[Track] varchar(100) null, 
	[TermSpan] varchar(20) null, 
	[MarketingTerm] varchar(2) null, 
	[SchedulingTerm] varchar(2) null, 
	[AttendanceTerm] varchar(2) null, 
	[Status] varchar(50) null,
	[ValidFrom] datetime2(7) constraint [DF_DimTermInfo_Valid_A85628A1] default (getdate()) not null,
    [ValidTo] datetime2(7) null,
    [IsActive] bit constraint [DF__DimTermInfo__IsAct__37FA4C37] default ((1)) not null,
    [CreatedOn] datetime2(7) constraint [DF__DimTermInfo__Creat__38EE7070] default (getdate()) not null,
    [CreatedBy] varchar(256) constraint [DF__DimTermInfo__Creat__39E294A9] default (suser_sname()) not null,
    [UpdatedOn] datetime2(7) constraint [DF__DimTermInfo__Updat__3AD6B8E2] default (suser_sname()) null,
    [UpdatedBy] varchar(256) constraint [DF__DimTermInfo__Updat__3BCADD1B] default (getdate()) not null,
    [HashKey] varbinary(32) null
);

PRINT N'Creating Table [dm].[DimDate]...';

CREATE TABLE [dm].[DimDate] (
    [DATEKEY]                   INT          NOT NULL,
    [CALENDAR_DATE]             DATE         NOT NULL,
    [CALENDAR_DAY_OF_MONTH]     TINYINT      NOT NULL,
    [CALENDAR_DAY_SUFFIX]       CHAR (2)     NOT NULL,
    [CALENDAR_DAY_OF_WEEK]      TINYINT      NOT NULL,
    [CALENDAR_DAY_OF_WEEK_NAME] VARCHAR (10) NOT NULL,
    [WEEKEND_IND]               BIT          NOT NULL,
    [HOLIDAY_IND]               BIT          NOT NULL,
    [DOW_IN_MONTH]              TINYINT      NOT NULL,
    [CALENDAR_DAY_OF_YEAR]      SMALLINT     NOT NULL,
    [CALENDAR_WEEK_OF_MONTH]    TINYINT      NOT NULL,
    [CALENDAR_WEEK_OF_YEAR]     TINYINT      NOT NULL,
    [CALENDAR_MONTH_NUMBER]     TINYINT      NOT NULL,
    [CALENDAR_MONTH_NAME]       VARCHAR (10) NOT NULL,
    [CALENDAR_QUARTER]          VARCHAR (2)  NOT NULL,
    [CALENDAR_QUARTER_NAME]     VARCHAR (6)  NOT NULL,
    [CALENDAR_YEAR]             INT          NOT NULL,
    [CALENDAR_YYYYMM]           CHAR (6)     NOT NULL,
    [CALENDAR_MONYYYY]          CHAR (7)     NOT NULL,
    [CALENDAR_YEAR_START_DATE]  DATE         NOT NULL,
    [CALENDAR_YEAR_END_DATE]    DATE         NOT NULL,
    [MONTH_START_DATE]          DATE         NOT NULL,
    [MONTH_END_DATE]            DATE         NOT NULL,
    [NEXT_MONTH_START_DATE]     DATE         NOT NULL,
    [CALENDAR_DAYS_IN_MONTH]    TINYINT      NOT NULL,
    [BUSINESS_DAYS_IN_MONTH]    TINYINT      NOT NULL,
    [FINANCIAL_DAY_OF_YEAR]     SMALLINT     NOT NULL,
    [FINANCIAL_WEEK_OF_YEAR]    TINYINT      NOT NULL,
    [FINANCIAL_MONTH_NUMBER]    TINYINT      NOT NULL,
    [FINANCIAL_YYYYMM]          CHAR (6)     NOT NULL,
    [FINANCIAL_QUARTER]         VARCHAR (2)  NOT NULL,
    [FINANCIAL_QUARTER_NAME]    VARCHAR (6)  NOT NULL,
    [FINANCIAL_YEAR]            INT          NOT NULL,
    [FINANCIAL_YEAR_YYYY_YY]    VARCHAR (7)  NOT NULL,
    [FINANCIAL_YEAR_START_DATE] DATE         NOT NULL,
    [FINANCIAL_YEAR_END_DATE]   DATE         NOT NULL
);


GO
PRINT N'Creating Table [dm].[DimAbsent]...';


GO
CREATE TABLE [dm].[DimAbsent] (
    [AbsentKey]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]             VARCHAR (50)   NOT NULL,
    [AbsentDate]            DATE           NOT NULL,
    [AbsentTypeCode]        VARCHAR (50)   NOT NULL,
    [AbsentTypeDescription] VARCHAR (50)   NOT NULL,
    [AcceptIndicator]       VARCHAR (50)   NULL,
    [ValidFrom]             DATETIME2 (7)  NOT NULL,
    [ValidTo]               DATETIME2 (7)  NULL,
    [IsActive]              BIT            NOT NULL,
    [CreatedOn]             DATETIME2 (7)  NOT NULL,
    [CreatedBy]             VARCHAR (256)  NOT NULL,
    [UpdatedOn]             DATETIME2 (7)  NULL,
    [UpdatedBy]             VARCHAR (256)  NOT NULL,
    [HashKey]               VARBINARY (32) NULL
);


GO
PRINT N'Creating Table [dm].[NONKimballAddress]...';


GO
CREATE TABLE [dm].[NONKimballAddress] (
    [AddressKey]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]   VARCHAR (50)   NOT NULL,
    [City]        VARCHAR (50)   NOT NULL,
    [PostCode]    VARCHAR (50)   NULL,
    [State]       VARCHAR (50)   NULL,
    [AddressType] VARCHAR (50)   NULL,
    [ValidFrom]   DATETIME2 (7)  NOT NULL,
    [ValidTo]     DATETIME2 (7)  NULL,
    [IsActive]    BIT            NOT NULL,
    [CreatedOn]   DATETIME2 (7)  NOT NULL,
    [CreatedBy]   VARCHAR (256)  NOT NULL,
    [UpdatedOn]   DATETIME2 (7)  NULL,
    [UpdatedBy]   VARCHAR (256)  NOT NULL,
    [HashKey]     VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[DimConduct]...';


GO
CREATE TABLE [dm].[DimConduct] (
    [ConductKey]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]          VARCHAR (50)   NOT NULL,
    [ConductDate]        DATE           NOT NULL,
    [ConductCode]        VARCHAR (50)   NOT NULL,
    [ConductDescription] VARCHAR (MAX)  NULL,
    [ValidFrom]          DATETIME2 (7)  NOT NULL,
    [ValidTo]            DATETIME2 (7)  NULL,
    [IsActive]           BIT            NOT NULL,
    [CreatedOn]          DATETIME2 (7)  NOT NULL,
    [CreatedBy]          VARCHAR (256)  NOT NULL,
    [UpdatedOn]          DATETIME2 (7)  NULL,
    [UpdatedBy]          VARCHAR (256)  NOT NULL,
    [HashKey]            VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[FactEnrollment]...';


GO
CREATE TABLE [dm].[FactEnrollment] (
    [EnrolmentKey] BIGINT         IDENTITY (1, 1) NOT NULL,
    [EnrolmentID]  VARCHAR (50)   NOT NULL,
    [StudentID]    VARCHAR (50)   NULL,
    [EntryYear]    INT            NOT NULL,
    [YearLevel]    CHAR (2)       NOT NULL,
    [StageOrder]   INT            NOT NULL,
    [StageName]    VARCHAR (255)  NOT NULL,
    [CampusName]   VARCHAR (255)  NULL,
    [City]         VARCHAR (50)   NULL,
    [PostCode]     VARCHAR (50)   NULL,
    [State]        VARCHAR (50)   NULL,
    [Country]      VARCHAR (255)  NULL,
    [ValidFrom]    DATETIME2 (7)  NOT NULL,
    [ValidTo]      DATETIME2 (7)  NULL,
    [IsActive]     BIT            NOT NULL,
    [CreatedOn]    DATETIME2 (7)  NOT NULL,
    [CreatedBy]    VARCHAR (256)  NOT NULL,
    [UpdatedOn]    DATETIME2 (7)  NULL,
    [UpdatedBy]    VARCHAR (256)  NOT NULL,
    [HashKey]      VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[FactNaplan]...';


GO
CREATE TABLE [dm].[FactNaplan] (
    [NaplanKey]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]     VARCHAR (50)   NOT NULL,
    [NPCalYear]     INT            NOT NULL,
    [NPYearLevel]   INT            NOT NULL,
    [NPDomain]      VARCHAR (50)   NOT NULL,
    [NPCategory]    VARCHAR (50)   NOT NULL,
    [NPBandScore]   INT            NOT NULL,
    [NPScaledScore] INT            NULL,
    [ValidFrom]     DATETIME2 (7)  NOT NULL,
    [ValidTo]       DATETIME2 (7)  NULL,
    [IsActive]      BIT            NOT NULL,
    [CreatedOn]     DATETIME2 (7)  NOT NULL,
    [CreatedBy]     VARCHAR (256)  NOT NULL,
    [UpdatedOn]     DATETIME2 (7)  NULL,
    [UpdatedBy]     VARCHAR (256)  NOT NULL,
    [HashKey]       VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[DimNaplanNationalAverage]...';


GO
CREATE TABLE [dm].[DimNaplanNationalAverage] (
    [Year]                         INT             NULL,
    [YearLevel]                    INT             NULL,
    [Domain]                       VARCHAR (255)   NULL,
    [ScaledScore]                  DECIMAL (18, 1) NULL,
    [ScaledScoreStandardDeviation] DECIMAL (18, 1) NULL,
    [NAPLANCategory]               VARCHAR (255)   NULL
);


GO
PRINT N'Creating Table [dm].[DimStudent]...';


GO
CREATE TABLE [dm].[DimStudent] (
    [StudentKey]                      BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]                       VARCHAR (20)   NULL,
    [StateProvinceId]                 VARCHAR (20)   NULL,
    [NationalUniqueStudentIdentifier] VARCHAR (20)   NULL,
    [FirstName]                       VARCHAR (255)  NULL,
    [LastName]                        VARCHAR (255)  NULL,
    [MiddleName]                      VARCHAR (255)  NULL,
    [OtherNames]                      VARCHAR (255)  NULL,
    [ProjectedGraduationYear]         NUMERIC (4)    NULL,
    [OnTimeGraduationYear]            NUMERIC (4)    NULL,
    [GraduationDate]                  DATE           NULL,
    [AcceptableUsePolicy]             VARCHAR (2)    NULL,
    [GiftedTalented]                  VARCHAR (2)    NULL,
    [EconomicDisadvantage]            VARCHAR (2)    NULL,
    [ESL]                             VARCHAR (2)    NULL,
    [ESLDateAssessed]                 DATE           NULL,
    [YoungCarersRole]                 VARCHAR (2)    NULL,
    [Disability]                      VARCHAR (2)    NULL,
    [IntegrationAide]                 VARCHAR (2)    NULL,
    [EducationSupport]                VARCHAR (2)    NULL,
    [HomeSchooledStudent]             VARCHAR (2)    NULL,
    [IndependentStudent]              VARCHAR (2)    NULL,
    [Sensitive]                       VARCHAR (2)    NULL,
    [OfflineDelivery]                 VARCHAR (2)    NULL,
    [ESLSupport]                      VARCHAR (2)    NULL,
    [PrePrimaryEducation]             VARCHAR (50)   NULL,
    [PrePrimaryEducationHours]        VARCHAR (2)    NULL,
    [FirstAUSchoolEnrollment]         DATE           NULL,
    [Typeemail1description]           VARCHAR (20)   NULL,
    [Email1]                          VARCHAR (50)   NULL,
    [typeemail2description]           VARCHAR (20)   NULL,
    [Email2]                          VARCHAR (50)   NULL,
    [Telephone1]                      VARCHAR (50)   NULL,
    [Telephone1TypeDescription]       VARCHAR (20)   NULL,
    [Mobilephone]                     VARCHAR (50)   NULL,
    [OtherPhone]                      VARCHAR (50)   NULL,
    [IndigenousStatus]                SMALLINT       NULL,
    [Sex]                             VARCHAR (10)   NULL,
    [BirthDate]                       DATE           NULL,
    [DateOfDeath]                     DATE           NULL,
    [Deceased]                        VARCHAR (2)    NULL,
    [BirthDateVerification]           VARCHAR (50)   NULL,
    [PlaceOfBirth]                    VARCHAR (50)   NULL,
    [StateOfBirth]                    VARCHAR (50)   NULL,
    [CountryOfBirth]                  VARCHAR (50)   NULL,
    [CountriesOfCitizenship]          VARCHAR (50)   NULL,
    [CountriesOfResidency]            VARCHAR (50)   NULL,
    [CountryArrivalDate]              DATE           NULL,
    [AustralianCitizenshipStatus]     VARCHAR (2)    NULL,
    [EnglishProficiency]              SMALLINT       NULL,
    [MainLanguageSpokenAtHome]        VARCHAR (50)   NULL,
    [SecondLanguage]                  VARCHAR (50)   NULL,
    [OtherLanguage]                   VARCHAR (50)   NULL,
    [DwellingArrangement]             VARCHAR (50)   NULL,
    [Religion]                        VARCHAR (50)   NULL,
    [ReligionEvent1]                  VARCHAR (50)   NULL,
    [ReligionEvent1Date]              DATE           NULL,
    [ReligionEvent2]                  VARCHAR (50)   NULL,
    [ReligionEvent2Date]              DATE           NULL,
    [ReligionEvent3]                  VARCHAR (50)   NULL,
    [ReligionEvent3Date]              DATE           NULL,
    [ReligiousRegion]                 VARCHAR (50)   NULL,
    [PermanentResident]               VARCHAR (2)    NULL,
    [VisaSubClass]                    VARCHAR (255)  NULL,
    [VisaStatisticalCode]             VARCHAR (5)    NULL,
    [VisaNumber]                      VARCHAR (50)   NULL,
    [VisaGrantDate]                   DATE           NULL,
    [VisaExpiryDate]                  DATE           NULL,
    [VisaConditions]                  VARCHAR (255)  NULL,
    [VisaStudyEntitlement]            VARCHAR (255)  NULL,
    [ATEExpiryDate]                   DATE           NULL,
    [ATEStartDate]                    DATE           NULL,
    [PassportNumber]                  VARCHAR (20)   NULL,
    [PassportExpiryDate]              DATE           NULL,
    [PassportCountry]                 VARCHAR (20)   NULL,
    [LBOTE]                           VARCHAR (2)    NULL,
    [InterpreterRequired]             VARCHAR (2)    NULL,
    [ImmunisationCertificateStatus]   VARCHAR (50)   NULL,
    [CulturalBackground]              VARCHAR (50)   NULL,
    [MaritalStatus]                   VARCHAR (50)   NULL,
    [MedicareNumber]                  NUMERIC (12)   NULL,
    [MedicarePositionNumber]          NUMERIC (1)    NULL,
    [MedicareCardHolderName]          VARCHAR (50)   NULL,
    [PrivateHealthInsurance]          VARCHAR (50)   NULL,
    [Status]                          VARCHAR (50)   NOT NULL,
    [ValidFrom]                       DATETIME2 (7)  NOT NULL,
    [ValidTo]                         DATETIME2 (7)  NULL,
    [IsActive]                        BIT            NOT NULL,
    [CreatedOn]                       DATETIME2 (7)  NOT NULL,
    [CreatedBy]                       VARCHAR (256)  NOT NULL,
    [UpdatedOn]                       DATETIME2 (7)  NULL,
    [UpdatedBy]                       VARCHAR (256)  NOT NULL,
    [HashKey]                         VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[DimSubject]...';


GO
CREATE TABLE [dm].[DimSubject] (
    [SubjectKey]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [SubjectID]             VARCHAR (50)   NOT NULL,
    [SubjectName]           VARCHAR (255)  NOT NULL,
    [SubjectReportFlag]     VARCHAR (50)   NOT NULL,
    [SubjectDepartment]     VARCHAR (50)   NOT NULL,
    [SubjectYearLevel]      VARCHAR (50)   NULL,
    [SubjectGPAIncludeFlag] VARCHAR (50)   NOT NULL,
    [ValidFrom]             DATETIME2 (7)  NOT NULL,
    [ValidTo]               DATETIME2 (7)  NULL,
    [IsActive]              BIT            NOT NULL,
    [CreatedOn]             DATETIME2 (7)  NOT NULL,
    [CreatedBy]             VARCHAR (256)  NOT NULL,
    [UpdatedOn]             DATETIME2 (7)  NULL,
    [UpdatedBy]             VARCHAR (256)  NOT NULL,
    [HashKey]               VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[DimTeacher]...';


GO
CREATE TABLE [dm].[DimTeacher] (
    [TeacherKey] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TeacherID]  VARCHAR (50)   NOT NULL,
    [FullName]   VARCHAR (50)   NOT NULL,
    [Email]      VARCHAR (50)   NOT NULL,
    [ValidFrom]  DATETIME2 (7)  NOT NULL,
    [ValidTo]    DATETIME2 (7)  NULL,
    [IsActive]   BIT            NOT NULL,
    [CreatedOn]  DATETIME2 (7)  NOT NULL,
    [CreatedBy]  VARCHAR (256)  NOT NULL,
    [UpdatedOn]  DATETIME2 (7)  NULL,
    [UpdatedBy]  VARCHAR (256)  NOT NULL,
    [HashKey]    VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[FactTeacherClasses]...';


GO
CREATE TABLE [dm].[FactTeacherClasses] (
    [TeacherClassesKey] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TeacherID]         VARCHAR (50)   NOT NULL,
    [SubjectID]         VARCHAR (50)   NOT NULL,
    [SubjectYearLevel]  VARCHAR (50)   NULL,
    [ReportingPeriod]   INT            NOT NULL,
    [CalendarYear]      INT            NOT NULL,
    [Class]             VARCHAR (50)   NULL,
    [ValidFrom]         DATETIME2 (7)  NOT NULL,
    [ValidTo]           DATETIME2 (7)  NULL,
    [IsActive]          BIT            NOT NULL,
    [CreatedOn]         DATETIME2 (7)  NOT NULL,
    [CreatedBy]         VARCHAR (256)  NOT NULL,
    [UpdatedOn]         DATETIME2 (7)  NULL,
    [UpdatedBy]         VARCHAR (256)  NOT NULL,
    [HashKey]           VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Table [dm].[FactTermResults]...';


GO
CREATE TABLE [dm].[FactTermResults] (
    [TermResultsKey] BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]      VARCHAR (50)   NOT NULL,
    [YearLevel]      VARCHAR (50)   NOT NULL,
    [Class]          VARCHAR (50)   NOT NULL,
    [ResultPeriod]   VARCHAR (50)   NOT NULL,
    [ResultTypeID]   VARCHAR (50)   NULL,
    [TeacherID]      VARCHAR (50)   NOT NULL,
    [SubjectID]      VARCHAR (50)   NOT NULL,
    [Score]          VARCHAR (50)   NOT NULL,
    [ScoreNumeric]   DECIMAL (18)   NULL,
    [ResultYear]     VARCHAR (50)   NOT NULL,
    [ValidFrom]      DATETIME2 (7)  NOT NULL,
    [ValidTo]        DATETIME2 (7)  NULL,
    [IsActive]       BIT            NOT NULL,
    [CreatedOn]      DATETIME2 (7)  NOT NULL,
    [CreatedBy]      VARCHAR (256)  NOT NULL,
    [UpdatedOn]      DATETIME2 (7)  NULL,
    [UpdatedBy]      VARCHAR (256)  NOT NULL,
    [HashKey]        VARBINARY (32) NOT NULL
);


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimAbsent]...';


GO
ALTER TABLE [dm].[DimAbsent]
    ADD DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimAbsent]...';


GO
ALTER TABLE [dm].[DimAbsent]
    ADD DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimAbsent]...';


GO
ALTER TABLE [dm].[DimAbsent]
    ADD DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimAbsent]...';


GO
ALTER TABLE [dm].[DimAbsent]
    ADD DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimAbsent]...';


GO
ALTER TABLE [dm].[DimAbsent]
    ADD DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimAbsent]...';


GO
ALTER TABLE [dm].[DimAbsent]
    ADD DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimAddres__Valid__4959E263]...';


GO
ALTER TABLE [dm].[NONKimballAddress]
    ADD CONSTRAINT [DF__DimAddres__Valid__4959E263] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimAddres__IsAct__4A4E069C]...';


GO
ALTER TABLE [dm].[NONKimballAddress]
    ADD CONSTRAINT [DF__DimAddres__IsAct__4A4E069C] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimAddres__Creat__4B422AD5]...';


GO
ALTER TABLE [dm].[NONKimballAddress]
    ADD CONSTRAINT [DF__DimAddres__Creat__4B422AD5] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimAddres__Creat__4C364F0E]...';


GO
ALTER TABLE [dm].[NONKimballAddress]
    ADD CONSTRAINT [DF__DimAddres__Creat__4C364F0E] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimAddres__Updat__4D2A7347]...';


GO
ALTER TABLE [dm].[NONKimballAddress]
    ADD CONSTRAINT [DF__DimAddres__Updat__4D2A7347] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimAddres__Updat__4E1E9780]...';


GO
ALTER TABLE [dm].[NONKimballAddress]
    ADD CONSTRAINT [DF__DimAddres__Updat__4E1E9780] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimConduc__Valid__4F12BBB9]...';


GO
ALTER TABLE [dm].[DimConduct]
    ADD CONSTRAINT [DF__DimConduc__Valid__4F12BBB9] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimConduc__IsAct__5006DFF2]...';


GO
ALTER TABLE [dm].[DimConduct]
    ADD CONSTRAINT [DF__DimConduc__IsAct__5006DFF2] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimConduc__Creat__50FB042B]...';


GO
ALTER TABLE [dm].[DimConduct]
    ADD CONSTRAINT [DF__DimConduc__Creat__50FB042B] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimConduc__Creat__51EF2864]...';


GO
ALTER TABLE [dm].[DimConduct]
    ADD CONSTRAINT [DF__DimConduc__Creat__51EF2864] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimConduc__Updat__52E34C9D]...';


GO
ALTER TABLE [dm].[DimConduct]
    ADD CONSTRAINT [DF__DimConduc__Updat__52E34C9D] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimConduc__Updat__53D770D6]...';


GO
ALTER TABLE [dm].[DimConduct]
    ADD CONSTRAINT [DF__DimConduc__Updat__53D770D6] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimEnrolm__Valid__54CB950F]...';


GO
ALTER TABLE [dm].[FactEnrollment]
    ADD CONSTRAINT [DF__DimEnrolm__Valid__54CB950F] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimEnrolm__IsAct__55BFB948]...';


GO
ALTER TABLE [dm].[FactEnrollment]
    ADD CONSTRAINT [DF__DimEnrolm__IsAct__55BFB948] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimEnrolm__Creat__56B3DD81]...';


GO
ALTER TABLE [dm].[FactEnrollment]
    ADD CONSTRAINT [DF__DimEnrolm__Creat__56B3DD81] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimEnrolm__Creat__57A801BA]...';


GO
ALTER TABLE [dm].[FactEnrollment]
    ADD CONSTRAINT [DF__DimEnrolm__Creat__57A801BA] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimEnrolm__Updat__589C25F3]...';


GO
ALTER TABLE [dm].[FactEnrollment]
    ADD CONSTRAINT [DF__DimEnrolm__Updat__589C25F3] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimEnrolm__Updat__59904A2C]...';


GO
ALTER TABLE [dm].[FactEnrollment]
    ADD CONSTRAINT [DF__DimEnrolm__Updat__59904A2C] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimNaplan__Valid__5A846E65]...';


GO
ALTER TABLE [dm].[FactNaplan]
    ADD CONSTRAINT [DF__DimNaplan__Valid__5A846E65] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimNaplan__IsAct__5B78929E]...';


GO
ALTER TABLE [dm].[FactNaplan]
    ADD CONSTRAINT [DF__DimNaplan__IsAct__5B78929E] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimNaplan__Creat__5C6CB6D7]...';


GO
ALTER TABLE [dm].[FactNaplan]
    ADD CONSTRAINT [DF__DimNaplan__Creat__5C6CB6D7] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimNaplan__Creat__5D60DB10]...';


GO
ALTER TABLE [dm].[FactNaplan]
    ADD CONSTRAINT [DF__DimNaplan__Creat__5D60DB10] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimNaplan__Updat__5E54FF49]...';


GO
ALTER TABLE [dm].[FactNaplan]
    ADD CONSTRAINT [DF__DimNaplan__Updat__5E54FF49] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimNaplan__Updat__5F492382]...';


GO
ALTER TABLE [dm].[FactNaplan]
    ADD CONSTRAINT [DF__DimNaplan__Updat__5F492382] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint unnamed constraint on [dm].[DimNaplanNationalAverage]...';


GO
ALTER TABLE [dm].[DimNaplanNationalAverage]
    ADD DEFAULT ('National Average') FOR [NAPLANCategory];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimStuden__Valid__370627FE]...';


GO
ALTER TABLE [dm].[DimStudent]
    ADD CONSTRAINT [DF__DimStuden__Valid__370627FE] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimStuden__IsAct__37FA4C37]...';


GO
ALTER TABLE [dm].[DimStudent]
    ADD CONSTRAINT [DF__DimStuden__IsAct__37FA4C37] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimStuden__Creat__38EE7070]...';


GO
ALTER TABLE [dm].[DimStudent]
    ADD CONSTRAINT [DF__DimStuden__Creat__38EE7070] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimStuden__Creat__39E294A9]...';


GO
ALTER TABLE [dm].[DimStudent]
    ADD CONSTRAINT [DF__DimStuden__Creat__39E294A9] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimStuden__Updat__3AD6B8E2]...';


GO
ALTER TABLE [dm].[DimStudent]
    ADD CONSTRAINT [DF__DimStuden__Updat__3AD6B8E2] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimStuden__Updat__3BCADD1B]...';


GO
ALTER TABLE [dm].[DimStudent]
    ADD CONSTRAINT [DF__DimStuden__Updat__3BCADD1B] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimSubjec__Valid__65F62111]...';


GO
ALTER TABLE [dm].[DimSubject]
    ADD CONSTRAINT [DF__DimSubjec__Valid__65F62111] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimSubjec__IsAct__66EA454A]...';


GO
ALTER TABLE [dm].[DimSubject]
    ADD CONSTRAINT [DF__DimSubjec__IsAct__66EA454A] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimSubjec__Creat__67DE6983]...';


GO
ALTER TABLE [dm].[DimSubject]
    ADD CONSTRAINT [DF__DimSubjec__Creat__67DE6983] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimSubjec__Creat__68D28DBC]...';


GO
ALTER TABLE [dm].[DimSubject]
    ADD CONSTRAINT [DF__DimSubjec__Creat__68D28DBC] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimSubjec__Updat__69C6B1F5]...';


GO
ALTER TABLE [dm].[DimSubject]
    ADD CONSTRAINT [DF__DimSubjec__Updat__69C6B1F5] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimSubjec__Updat__6ABAD62E]...';


GO
ALTER TABLE [dm].[DimSubject]
    ADD CONSTRAINT [DF__DimSubjec__Updat__6ABAD62E] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Valid__6BAEFA67]...';


GO
ALTER TABLE [dm].[DimTeacher]
    ADD CONSTRAINT [DF__DimTeache__Valid__6BAEFA67] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__IsAct__6CA31EA0]...';


GO
ALTER TABLE [dm].[DimTeacher]
    ADD CONSTRAINT [DF__DimTeache__IsAct__6CA31EA0] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Creat__6D9742D9]...';


GO
ALTER TABLE [dm].[DimTeacher]
    ADD CONSTRAINT [DF__DimTeache__Creat__6D9742D9] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Creat__6E8B6712]...';


GO
ALTER TABLE [dm].[DimTeacher]
    ADD CONSTRAINT [DF__DimTeache__Creat__6E8B6712] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Updat__6F7F8B4B]...';


GO
ALTER TABLE [dm].[DimTeacher]
    ADD CONSTRAINT [DF__DimTeache__Updat__6F7F8B4B] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Updat__7073AF84]...';


GO
ALTER TABLE [dm].[DimTeacher]
    ADD CONSTRAINT [DF__DimTeache__Updat__7073AF84] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Valid__7167D3BD]...';


GO
ALTER TABLE [dm].[FactTeacherClasses]
    ADD CONSTRAINT [DF__DimTeache__Valid__7167D3BD] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__IsAct__725BF7F6]...';


GO
ALTER TABLE [dm].[FactTeacherClasses]
    ADD CONSTRAINT [DF__DimTeache__IsAct__725BF7F6] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Creat__73501C2F]...';


GO
ALTER TABLE [dm].[FactTeacherClasses]
    ADD CONSTRAINT [DF__DimTeache__Creat__73501C2F] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Creat__74444068]...';


GO
ALTER TABLE [dm].[FactTeacherClasses]
    ADD CONSTRAINT [DF__DimTeache__Creat__74444068] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Updat__753864A1]...';


GO
ALTER TABLE [dm].[FactTeacherClasses]
    ADD CONSTRAINT [DF__DimTeache__Updat__753864A1] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTeache__Updat__762C88DA]...';


GO
ALTER TABLE [dm].[FactTeacherClasses]
    ADD CONSTRAINT [DF__DimTeache__Updat__762C88DA] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTermRe__Valid__7720AD13]...';


GO
ALTER TABLE [dm].[FactTermResults]
    ADD CONSTRAINT [DF__DimTermRe__Valid__7720AD13] DEFAULT (getdate()) FOR [ValidFrom];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTermRe__IsAct__7814D14C]...';


GO
ALTER TABLE [dm].[FactTermResults]
    ADD CONSTRAINT [DF__DimTermRe__IsAct__7814D14C] DEFAULT ((1)) FOR [IsActive];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTermRe__Creat__7908F585]...';


GO
ALTER TABLE [dm].[FactTermResults]
    ADD CONSTRAINT [DF__DimTermRe__Creat__7908F585] DEFAULT (getdate()) FOR [CreatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTermRe__Creat__79FD19BE]...';


GO
ALTER TABLE [dm].[FactTermResults]
    ADD CONSTRAINT [DF__DimTermRe__Creat__79FD19BE] DEFAULT (suser_sname()) FOR [CreatedBy];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTermRe__Updat__7AF13DF7]...';


GO
ALTER TABLE [dm].[FactTermResults]
    ADD CONSTRAINT [DF__DimTermRe__Updat__7AF13DF7] DEFAULT (suser_sname()) FOR [UpdatedOn];


GO
PRINT N'Creating Default Constraint [dm].[DF__DimTermRe__Updat__7BE56230]...';


GO
ALTER TABLE [dm].[FactTermResults]
    ADD CONSTRAINT [DF__DimTermRe__Updat__7BE56230] DEFAULT (getdate()) FOR [UpdatedBy];


GO
PRINT N'Creating Procedure [dm].[usp_Generate_DimDate]...';


GO



