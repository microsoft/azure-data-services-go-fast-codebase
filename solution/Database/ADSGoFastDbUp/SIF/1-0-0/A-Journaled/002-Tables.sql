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
PRINT N'Creating Table [dm].[DimAddress]...';


GO
CREATE TABLE [dm].[Address-NonKimball] (
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
PRINT N'Creating Table [dm].[DimStudent]...';


GO
CREATE TABLE [dm].[DimStudent] (
    [StudentKey]                      BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]                       VARCHAR (50)   NULL,
    [StateProvinceId]                 VARCHAR (20)   NULL,
    [NationalUniqueStudentIdentifier] VARCHAR (50)   NULL,
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
PRINT N'Creating Procedure [dm].[usp_Generate_DimDate]...';


GO


