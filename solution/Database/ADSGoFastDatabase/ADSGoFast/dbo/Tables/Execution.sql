/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[Execution] (
    [ExecutionUid]  UNIQUEIDENTIFIER   NOT NULL,
    [StartDateTime] DATETIMEOFFSET (7) NULL,
    [EndDateTime]   DATETIMEOFFSET (7) NULL,
    PRIMARY KEY CLUSTERED ([ExecutionUid] ASC)
);

