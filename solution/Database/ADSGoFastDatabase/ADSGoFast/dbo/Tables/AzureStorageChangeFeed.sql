/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[AzureStorageChangeFeed] (
    [EventTime]                                DATETIMEOFFSET (7) NULL,
    [EventType]                                VARCHAR (MAX)      NULL,
    [Subject]                                  VARCHAR (MAX)      NULL,
    [Topic]                                    VARCHAR (MAX)      NULL,
    [EventData.BlobOperationName]              VARCHAR (MAX)      NULL,
    [EventData.BlobType]                       VARCHAR (MAX)      NULL,
    [Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff] BIGINT             IDENTITY (1, 1) NOT NULL,
    PRIMARY KEY CLUSTERED ([Pkey1ebebb3a-d7af-4315-93c8-a438fe7a36ff] ASC)
);

