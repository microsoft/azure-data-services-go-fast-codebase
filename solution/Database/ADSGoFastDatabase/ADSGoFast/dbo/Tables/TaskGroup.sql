/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskGroup] (
    [TaskGroupId]          BIGINT          IDENTITY (1, 1) NOT NULL,
    [SubjectAreaId]        INT             NOT NULL,
    [TaskGroupName]        NVARCHAR (200)  NOT NULL,
    [TaskGroupPriority]    INT             NOT NULL,
    [TaskGroupConcurrency] INT             NOT NULL,
    [TaskGroupJSON]        NVARCHAR (4000) NULL,
    [MaximumTaskRetries]   INT             CONSTRAINT [DF_TaskGroup_MaximumTaskRetries] DEFAULT ((3)) NOT NULL,
    [ActiveYN]             BIT             NULL,
    CONSTRAINT [PK__TaskGrou__1EAD70161628472C] PRIMARY KEY CLUSTERED ([TaskGroupId] ASC)
);





