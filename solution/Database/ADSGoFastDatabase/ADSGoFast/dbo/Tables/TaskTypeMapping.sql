/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskTypeMapping] (
    [TaskTypeMappingId]      INT            IDENTITY (1, 1) NOT NULL,
    [TaskTypeId]             INT            NOT NULL,
    [MappingType]            NVARCHAR (128) NOT NULL,
    [MappingName]            NVARCHAR (128) NOT NULL,
    [SourceSystemType]       NVARCHAR (128) NOT NULL,
    [SourceType]             NVARCHAR (128) NOT NULL,
    [TargetSystemType]       NVARCHAR (128) NOT NULL,
    [TargetType]             NVARCHAR (128) NOT NULL,
    [TaskTypeJson]           NVARCHAR (MAX) NULL,
    [ActiveYN]               BIT            NOT NULL,
    [TaskMasterJsonSchema]   VARCHAR (MAX)  NULL,
    [TaskInstanceJsonSchema] VARCHAR (MAX)  NULL,
    CONSTRAINT [PK__TaskType__C274052A4E989D69] PRIMARY KEY CLUSTERED ([TaskTypeMappingId] ASC)
);



