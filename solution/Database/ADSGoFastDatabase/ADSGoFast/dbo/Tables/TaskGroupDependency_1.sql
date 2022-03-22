/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskGroupDependency] (
    [AncestorTaskGroupId]   BIGINT        NOT NULL,
    [DescendantTaskGroupId] BIGINT        NOT NULL,
    [DependencyType]        VARCHAR (200) NOT NULL,
    CONSTRAINT [PK_TaskGroupDependency] PRIMARY KEY CLUSTERED ([AncestorTaskGroupId] ASC, [DescendantTaskGroupId] ASC)
);

