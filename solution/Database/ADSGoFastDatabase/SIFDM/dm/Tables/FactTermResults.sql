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
    [ValidFrom]      DATETIME2 (7)  CONSTRAINT [DF__DimTermRe__Valid__7720AD13] DEFAULT (getdate()) NOT NULL,
    [ValidTo]        DATETIME2 (7)  NULL,
    [IsActive]       BIT            CONSTRAINT [DF__DimTermRe__IsAct__7814D14C] DEFAULT ((1)) NOT NULL,
    [CreatedOn]      DATETIME2 (7)  CONSTRAINT [DF__DimTermRe__Creat__7908F585] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]      VARCHAR (256)  CONSTRAINT [DF__DimTermRe__Creat__79FD19BE] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]      DATETIME2 (7)  CONSTRAINT [DF__DimTermRe__Updat__7AF13DF7] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]      VARCHAR (256)  CONSTRAINT [DF__DimTermRe__Updat__7BE56230] DEFAULT (getdate()) NOT NULL,
    [HashKey]        VARBINARY (32) NOT NULL
);

