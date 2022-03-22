/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaHistory] (
    [SubjectAreaId]       INT           NOT NULL,
    [SubjectAreaName]     VARCHAR (255) NULL,
    [ActiveYN]            BIT           NULL,
    [SubjectAreaFormId]   INT           NULL,
    [DefaultTargetSchema] VARCHAR (255) NULL,
    [UpdatedBy]           VARCHAR (255) NULL,
    [ValidFrom]           DATETIME2 (0) NOT NULL,
    [ValidTo]             DATETIME2 (0) NOT NULL
);


GO
CREATE CLUSTERED INDEX [ix_SubjectAreaHistory]
    ON [dbo].[SubjectAreaHistory]([ValidTo] ASC, [ValidFrom] ASC) WITH (DATA_COMPRESSION = PAGE);

