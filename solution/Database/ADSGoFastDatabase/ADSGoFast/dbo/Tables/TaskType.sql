/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskType] (
    [TaskTypeId]        INT            IDENTITY (1, 1) NOT NULL,
    [TaskTypeName]      NVARCHAR (128) NOT NULL,
    [TaskExecutionType] NVARCHAR (5)   NOT NULL,
    [TaskTypeJson]      NVARCHAR (MAX) NULL,
    [ActiveYN]          BIT            NOT NULL,
    CONSTRAINT [PK__TaskType__66B23E33F65B5D8C] PRIMARY KEY CLUSTERED ([TaskTypeId] ASC)
);



