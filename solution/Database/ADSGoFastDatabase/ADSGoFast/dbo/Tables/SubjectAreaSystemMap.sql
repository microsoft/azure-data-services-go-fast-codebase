/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaSystemMap] (
    [SubjectAreaId]       INT                                         NOT NULL,
    [SystemId]            BIGINT                                      NOT NULL,
    [MappingType]         TINYINT                                     NOT NULL,
    [AllowedSchemas]      VARCHAR (MAX)                               NOT NULL,
    [ActiveYN]            BIT                                         NULL,
    [SubjectAreaFormId]   INT                                         NULL,
    [DefaultTargetSchema] VARCHAR (255)                               NULL,
    [UpdatedBy]           VARCHAR (255)                               NULL,
    [ValidFrom]           DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]             DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaId] ASC, [SystemId] ASC, [MappingType] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaSystemMapHistory], DATA_CONSISTENCY_CHECK=ON));

