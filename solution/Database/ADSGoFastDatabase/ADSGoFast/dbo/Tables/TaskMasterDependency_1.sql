/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskMasterDependency] (
    [AncestorTaskMasterId]   BIGINT NOT NULL,
    [DescendantTaskMasterId] BIGINT NOT NULL,
    CONSTRAINT [PK_TaskMasterDependency] PRIMARY KEY CLUSTERED ([AncestorTaskMasterId] ASC, [DescendantTaskMasterId] ASC)
);

