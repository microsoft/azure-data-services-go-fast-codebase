/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[AzureStorageChangeFeedCursor] (
    [SourceSystemId]   BIGINT        NOT NULL,
    [ChangeFeedCursor] VARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([SourceSystemId] ASC)
);

