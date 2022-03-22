/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaRoleMapHistory] (
    [SubjectAreaId]       INT              NOT NULL,
    [AadGroupUid]         UNIQUEIDENTIFIER NOT NULL,
    [ApplicationRoleName] VARCHAR (255)    NOT NULL,
    [ExpiryDate]          DATE             NOT NULL,
    [ActiveYN]            BIT              NOT NULL,
    [UpdatedBy]           VARCHAR (255)    NULL,
    [ValidFrom]           DATETIME2 (0)    NOT NULL,
    [ValidTo]             DATETIME2 (0)    NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_SubjectAreaRoleMapHistory]
    ON [dbo].[SubjectAreaRoleMapHistory]([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);

