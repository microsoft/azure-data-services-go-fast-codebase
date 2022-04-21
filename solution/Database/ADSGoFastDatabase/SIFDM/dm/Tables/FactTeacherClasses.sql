CREATE TABLE [dm].[FactTeacherClasses] (
    [TeacherClassesKey] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TeacherID]         VARCHAR (50)   NOT NULL,
    [SubjectID]         VARCHAR (50)   NOT NULL,
    [SubjectYearLevel]  VARCHAR (50)   NULL,
    [ReportingPeriod]   INT            NOT NULL,
    [CalendarYear]      INT            NOT NULL,
    [Class]             VARCHAR (50)   NULL,
    [ValidFrom]         DATETIME2 (7)  CONSTRAINT [DF__DimTeache__Valid__7167D3BD] DEFAULT (getdate()) NOT NULL,
    [ValidTo]           DATETIME2 (7)  NULL,
    [IsActive]          BIT            CONSTRAINT [DF__DimTeache__IsAct__725BF7F6] DEFAULT ((1)) NOT NULL,
    [CreatedOn]         DATETIME2 (7)  CONSTRAINT [DF__DimTeache__Creat__73501C2F] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]         VARCHAR (256)  CONSTRAINT [DF__DimTeache__Creat__74444068] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]         DATETIME2 (7)  CONSTRAINT [DF__DimTeache__Updat__753864A1] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]         VARCHAR (256)  CONSTRAINT [DF__DimTeache__Updat__762C88DA] DEFAULT (getdate()) NOT NULL,
    [HashKey]           VARBINARY (32) NOT NULL
);

