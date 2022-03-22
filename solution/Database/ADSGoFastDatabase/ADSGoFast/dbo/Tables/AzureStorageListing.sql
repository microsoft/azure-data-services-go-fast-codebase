/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[AzureStorageListing] (
    [SystemId]     BIGINT         NOT NULL,
    [PartitionKey] VARCHAR (50)   NOT NULL,
    [RowKey]       VARCHAR (50)   NOT NULL,
    [FilePath]     VARCHAR (2000) NULL,
    CONSTRAINT [PK_AzureStorageListing] PRIMARY KEY CLUSTERED ([SystemId] ASC, [PartitionKey] ASC, [RowKey] ASC)
);



