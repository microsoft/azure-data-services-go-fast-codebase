/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ExecutionEngine] (
    [EngineId]                BIGINT           IDENTITY (1, 1) NOT NULL,
    [EngineName]              VARCHAR (255)    NULL,
    [SystemType]              VARCHAR (255)    NULL,    
    [ResourceGroup]           VARCHAR (255)    NULL,
    [SubscriptionUid]         UNIQUEIDENTIFIER NULL,
    [DefaultKeyVaultURL]      VARCHAR (255)    NULL,
    [EngineJson]              VARCHAR (MAX)    CONSTRAINT [DF_ExecutionEngine_EngineJson] DEFAULT ('{}') NULL,
    [LogAnalyticsWorkspaceId] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ExecutionEngine] PRIMARY KEY CLUSTERED ([EngineId] ASC)
);



