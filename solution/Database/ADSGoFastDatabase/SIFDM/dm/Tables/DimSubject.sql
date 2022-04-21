CREATE TABLE [dm].[DimSubject] (
    [SubjectKey]            BIGINT         IDENTITY (1, 1) NOT NULL,
    [SubjectID]             VARCHAR (50)   NOT NULL,
    [SubjectName]           VARCHAR (255)  NOT NULL,
    [SubjectReportFlag]     VARCHAR (50)   NOT NULL,
    [SubjectDepartment]     VARCHAR (50)   NOT NULL,
    [SubjectYearLevel]      VARCHAR (50)   NULL,
    [SubjectGPAIncludeFlag] VARCHAR (50)   NOT NULL,
    [ValidFrom]             DATETIME2 (7)  CONSTRAINT [DF__DimSubjec__Valid__65F62111] DEFAULT (getdate()) NOT NULL,
    [ValidTo]               DATETIME2 (7)  NULL,
    [IsActive]              BIT            CONSTRAINT [DF__DimSubjec__IsAct__66EA454A] DEFAULT ((1)) NOT NULL,
    [CreatedOn]             DATETIME2 (7)  CONSTRAINT [DF__DimSubjec__Creat__67DE6983] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (256)  CONSTRAINT [DF__DimSubjec__Creat__68D28DBC] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]             DATETIME2 (7)  CONSTRAINT [DF__DimSubjec__Updat__69C6B1F5] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]             VARCHAR (256)  CONSTRAINT [DF__DimSubjec__Updat__6ABAD62E] DEFAULT (getdate()) NOT NULL,
    [HashKey]               VARBINARY (32) NOT NULL
);

