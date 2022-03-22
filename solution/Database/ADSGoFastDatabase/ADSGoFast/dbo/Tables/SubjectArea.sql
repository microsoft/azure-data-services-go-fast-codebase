/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectArea] (
    [SubjectAreaId]       INT                                         IDENTITY (1, 1) NOT NULL,
    [SubjectAreaName]     VARCHAR (255)                               NULL,
    [ActiveYN]            BIT                                         NULL,
    [SubjectAreaFormId]   INT                                         NULL,
    [DefaultTargetSchema] VARCHAR (255)                               NULL,
    [UpdatedBy]           VARCHAR (255)                               NULL,
    [ValidFrom]           DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]             DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaId] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaHistory], DATA_CONSISTENCY_CHECK=ON));

