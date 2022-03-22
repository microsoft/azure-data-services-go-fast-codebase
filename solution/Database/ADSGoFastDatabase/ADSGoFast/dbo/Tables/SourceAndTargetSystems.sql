/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[SourceAndTargetSystems] (
    [SystemId]              BIGINT          IDENTITY (1, 1) NOT NULL,
    [SystemName]            NVARCHAR (128)  NOT NULL,
    [SystemType]            NVARCHAR (128)  NOT NULL,
    [SystemDescription]     NVARCHAR (128)  NOT NULL,
    [SystemServer]          NVARCHAR (128)  NOT NULL,
    [SystemAuthType]        NVARCHAR (20)   NOT NULL,
    [SystemUserName]        NVARCHAR (128)  NULL,
    [SystemSecretName]      NVARCHAR (128)  NULL,
    [SystemKeyVaultBaseUrl] NVARCHAR (500)  NULL,
    [SystemJSON]            NVARCHAR (4000) NULL,
    [ActiveYN]              BIT             NOT NULL,
    [IsExternal]            BIT             NOT NULL,
    [DataFactoryIR]         VARCHAR (20)    NULL,
    PRIMARY KEY CLUSTERED ([SystemId] ASC)
);


GO

