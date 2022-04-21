CREATE TABLE [dm].[DimTeacher] (
    [TeacherKey] BIGINT         IDENTITY (1, 1) NOT NULL,
    [TeacherID]  VARCHAR (50)   NOT NULL,
    [FullName]   VARCHAR (50)   NOT NULL,
    [Email]      VARCHAR (50)   NOT NULL,
    [ValidFrom]  DATETIME2 (7)  CONSTRAINT [DF__DimTeache__Valid__6BAEFA67] DEFAULT (getdate()) NOT NULL,
    [ValidTo]    DATETIME2 (7)  NULL,
    [IsActive]   BIT            CONSTRAINT [DF__DimTeache__IsAct__6CA31EA0] DEFAULT ((1)) NOT NULL,
    [CreatedOn]  DATETIME2 (7)  CONSTRAINT [DF__DimTeache__Creat__6D9742D9] DEFAULT (getdate()) NOT NULL,
    [CreatedBy]  VARCHAR (256)  CONSTRAINT [DF__DimTeache__Creat__6E8B6712] DEFAULT (suser_sname()) NOT NULL,
    [UpdatedOn]  DATETIME2 (7)  CONSTRAINT [DF__DimTeache__Updat__6F7F8B4B] DEFAULT (suser_sname()) NULL,
    [UpdatedBy]  VARCHAR (256)  CONSTRAINT [DF__DimTeache__Updat__7073AF84] DEFAULT (getdate()) NOT NULL,
    [HashKey]    VARBINARY (32) NOT NULL
);

