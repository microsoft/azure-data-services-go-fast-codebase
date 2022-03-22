/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaRoleMap] (
    [SubjectAreaId]       INT                                         NOT NULL,
    [AadGroupUid]         UNIQUEIDENTIFIER                            NOT NULL,
    [ApplicationRoleName] VARCHAR (255)                               NOT NULL,
    [ExpiryDate]          DATE                                        NOT NULL,
    [ActiveYN]            BIT                                         NOT NULL,
    [UpdatedBy]           VARCHAR (255)                               NULL,
    [ValidFrom]           DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]             DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaId] ASC, [AadGroupUid] ASC, [ApplicationRoleName] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaRoleMapHistory], DATA_CONSISTENCY_CHECK=ON));

