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
    [ValidFrom]    DATETIME2 (7)  CONSTRAINT [DF__DimEnrolm__Valid__54CB950F] DEFAULT (getdate()) NOT NULL,
    [ValidTo]      DATETIME2 (7)  NULL,
    [IsActive]     BIT            CONSTRAINT [DF__DimEnrolm__IsAct__55BFB948] DEFAULT ((1)) NOT NULL,
    [CreatedOn]    DATETIME2 (7)  CONSTRAINT [DF__DimEnrolm__Creat__56B3DD81] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]    VARCHAR (256)  CONSTRAINT [DF__DimEnrolm__Creat__57A801BA] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]    DATETIME2 (7)  CONSTRAINT [DF__DimEnrolm__Updat__589C25F3] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]    VARCHAR (256)  CONSTRAINT [DF__DimEnrolm__Updat__59904A2C] DEFAULT (getdate()) NOT NULL,
    [HashKey]      VARBINARY (32) NOT NULL
);

