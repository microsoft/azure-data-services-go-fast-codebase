/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaForm] (
    [SubjectAreaFormId] INT                                         IDENTITY (1, 1) NOT NULL,
    [FormJson]          VARCHAR (MAX)                               NULL,
    [FormStatus]        TINYINT                                     NULL,
    [UpdatedBy]         VARCHAR (255)                               NULL,
    [ValidFrom]         DATETIME2 (0) GENERATED ALWAYS AS ROW START NOT NULL,
    [ValidTo]           DATETIME2 (0) GENERATED ALWAYS AS ROW END   NOT NULL,
    PRIMARY KEY CLUSTERED ([SubjectAreaFormId] ASC),
    PERIOD FOR SYSTEM_TIME ([ValidFrom], [ValidTo])
)
WITH (SYSTEM_VERSIONING = ON (HISTORY_TABLE=[dbo].[SubjectAreaFormHistory], DATA_CONSISTENCY_CHECK=ON));



