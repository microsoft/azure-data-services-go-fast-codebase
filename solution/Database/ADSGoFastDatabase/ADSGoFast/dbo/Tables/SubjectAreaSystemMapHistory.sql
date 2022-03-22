/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaSystemMapHistory] (
    [SubjectAreaId]       INT           NOT NULL,
    [SystemId]            BIGINT        NOT NULL,
    [MappingType]         TINYINT       NOT NULL,
    [AllowedSchemas]      VARCHAR (MAX) NOT NULL,
    [ActiveYN]            BIT           NULL,
    [SubjectAreaFormId]   INT           NULL,
    [DefaultTargetSchema] VARCHAR (255) NULL,
    [UpdatedBy]           VARCHAR (255) NULL,
    [ValidFrom]           DATETIME2 (0) NOT NULL,
    [ValidTo]             DATETIME2 (0) NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_SubjectAreaSystemMapHistory]
    ON [dbo].[SubjectAreaSystemMapHistory]([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);

