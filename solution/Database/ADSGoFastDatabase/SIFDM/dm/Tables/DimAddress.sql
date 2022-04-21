CREATE TABLE [dm].[DimAddress] (
    [AddressKey]  BIGINT         IDENTITY (1, 1) NOT NULL,
    [StudentID]   VARCHAR (50)   NOT NULL,
    [City]        VARCHAR (50)   NOT NULL,
    [PostCode]    VARCHAR (50)   NULL,
    [State]       VARCHAR (50)   NULL,
    [AddressType] VARCHAR (50)   NULL,
    [ValidFrom]   DATETIME2 (7)  CONSTRAINT [DF__DimAddres__Valid__4959E263] DEFAULT (getdate()) NOT NULL,
    [ValidTo]     DATETIME2 (7)  NULL,
    [IsActive]    BIT            CONSTRAINT [DF__DimAddres__IsAct__4A4E069C] DEFAULT ((1)) NOT NULL,
    [CreatedOn]   DATETIME2 (7)  CONSTRAINT [DF__DimAddres__Creat__4B422AD5] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]   VARCHAR (256)  CONSTRAINT [DF__DimAddres__Creat__4C364F0E] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]   DATETIME2 (7)  CONSTRAINT [DF__DimAddres__Updat__4D2A7347] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]   VARCHAR (256)  CONSTRAINT [DF__DimAddres__Updat__4E1E9780] DEFAULT (getdate()) NOT NULL,
    [HashKey]     VARBINARY (32) NOT NULL
);

