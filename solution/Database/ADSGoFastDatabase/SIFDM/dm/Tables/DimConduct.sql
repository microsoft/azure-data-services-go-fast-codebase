CREATE TABLE [dm].[DimConduct] (
    [ConductKey]         BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]          VARCHAR (50)   NOT NULL,
    [ConductDate]        DATE           NOT NULL,
    [ConductCode]        VARCHAR (50)   NOT NULL,
    [ConductDescription] VARCHAR (MAX)  NULL,
    [ValidFrom]          DATETIME2 (7)  CONSTRAINT [DF__DimConduc__Valid__4F12BBB9] DEFAULT (getdate()) NOT NULL,
    [ValidTo]            DATETIME2 (7)  NULL,
    [IsActive]           BIT            CONSTRAINT [DF__DimConduc__IsAct__5006DFF2] DEFAULT ((1)) NOT NULL,
    [CreatedOn]          DATETIME2 (7)  CONSTRAINT [DF__DimConduc__Creat__50FB042B] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]          VARCHAR (256)  CONSTRAINT [DF__DimConduc__Creat__51EF2864] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]          DATETIME2 (7)  CONSTRAINT [DF__DimConduc__Updat__52E34C9D] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]          VARCHAR (256)  CONSTRAINT [DF__DimConduc__Updat__53D770D6] DEFAULT (getdate()) NOT NULL,
    [HashKey]            VARBINARY (32) NOT NULL
);

