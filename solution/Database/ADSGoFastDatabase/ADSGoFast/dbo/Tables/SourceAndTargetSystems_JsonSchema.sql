/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SourceAndTargetSystems_JsonSchema] (
    [SystemType] VARCHAR (255)  NOT NULL,
    [JsonSchema] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([SystemType] ASC)
);

