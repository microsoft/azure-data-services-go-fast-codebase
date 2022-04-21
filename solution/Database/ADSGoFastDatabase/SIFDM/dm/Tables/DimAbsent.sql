CREATE TABLE [dm].[DimAbsent] (
    [AbsentKey]             BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]             VARCHAR (50)   NOT NULL,
    [AbsentDate]            DATE           NOT NULL,
    [AbsentTypeCode]        VARCHAR (50)   NOT NULL,
    [AbsentTypeDescription] VARCHAR (50)   NOT NULL,
    [AcceptIndicator]       VARCHAR (50)   NULL,
    [ValidFrom]             DATETIME2 (7)  DEFAULT (getdate()) NOT NULL,
    [ValidTo]               DATETIME2 (7)  NULL,
    [IsActive]              BIT            DEFAULT ((1)) NOT NULL,
    [CreatedOn]             DATETIME2 (7)  DEFAULT (getdate()) NOT NULL,
    [CreatedBy]             VARCHAR (256)  DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]             DATETIME2 (7)  DEFAULT (suser_sname()) NULL,
    [UpdatedBy]             VARCHAR (256)  DEFAULT (getdate()) NOT NULL,
    [HashKey]               VARBINARY (32) NULL
);

