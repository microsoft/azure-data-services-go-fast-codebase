/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskMaster] (
    [TaskMasterId]                 BIGINT          IDENTITY (1, 1) NOT NULL,
    [TaskMasterName]               NVARCHAR (200)  NOT NULL,
    [TaskTypeId]                   INT             NOT NULL,
    [TaskGroupId]                  BIGINT          NOT NULL,
    [ScheduleMasterId]             BIGINT          NOT NULL,
    [SourceSystemId]               BIGINT          NOT NULL,
    [TargetSystemId]               BIGINT          NOT NULL,
    [DegreeOfCopyParallelism]      INT             CONSTRAINT [DF__TaskMaste__Degre__43A1090D] DEFAULT ((1)) NOT NULL,
    [AllowMultipleActiveInstances] BIT             CONSTRAINT [DF__TaskMaste__Allow__42ACE4D4] DEFAULT ((0)) NOT NULL,
    [TaskDatafactoryIR]            NVARCHAR (20)   NOT NULL,
    [TaskMasterJSON]               NVARCHAR (4000) NULL,
    [ActiveYN]                     BIT             NOT NULL,
    [DependencyChainTag]           VARCHAR (50)    NULL,
    [EngineId]                     BIGINT          NOT NULL,
    CONSTRAINT [PK__TaskMast__EB7286F6C9A58EA9] PRIMARY KEY CLUSTERED ([TaskMasterId] ASC)
);












GO
CREATE NONCLUSTERED INDEX [nci_wi_TaskMaster_D7BDAE69478BDFB67BBA9E4F9BB3DD7F]
    ON [dbo].[TaskMaster]([TaskGroupId] ASC, [DependencyChainTag] ASC)
    INCLUDE([SourceSystemId], [TargetSystemId]);

