CREATE TABLE [dm].[FactNaplan] (
    [NaplanKey]     BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]     VARCHAR (50)   NOT NULL,
    [NPCalYear]     INT            NOT NULL,
    [NPYearLevel]   INT            NOT NULL,
    [NPDomain]      VARCHAR (50)   NOT NULL,
    [NPCategory]    VARCHAR (50)   NOT NULL,
    [NPBandScore]   INT            NOT NULL,
    [NPScaledScore] INT            NULL,
    [ValidFrom]     DATETIME2 (7)  CONSTRAINT [DF__DimNaplan__Valid__5A846E65] DEFAULT (getdate()) NOT NULL,
    [ValidTo]       DATETIME2 (7)  NULL,
    [IsActive]      BIT            CONSTRAINT [DF__DimNaplan__IsAct__5B78929E] DEFAULT ((1)) NOT NULL,
    [CreatedOn]     DATETIME2 (7)  CONSTRAINT [DF__DimNaplan__Creat__5C6CB6D7] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]     VARCHAR (256)  CONSTRAINT [DF__DimNaplan__Creat__5D60DB10] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]     DATETIME2 (7)  CONSTRAINT [DF__DimNaplan__Updat__5E54FF49] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]     VARCHAR (256)  CONSTRAINT [DF__DimNaplan__Updat__5F492382] DEFAULT (getdate()) NOT NULL,
    [HashKey]       VARBINARY (32) NOT NULL
);

