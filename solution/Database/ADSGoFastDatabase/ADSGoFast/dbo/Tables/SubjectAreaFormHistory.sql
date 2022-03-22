/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SubjectAreaFormHistory] (
    [SubjectAreaFormId] INT           NOT NULL,
    [FormJson]          VARCHAR (MAX) NULL,
    [FormStatus]        TINYINT       NULL,
    [UpdatedBy]         VARCHAR (255) NULL,
    [ValidFrom]         DATETIME2 (0) NOT NULL,
    [ValidTo]           DATETIME2 (0) NOT NULL
);



