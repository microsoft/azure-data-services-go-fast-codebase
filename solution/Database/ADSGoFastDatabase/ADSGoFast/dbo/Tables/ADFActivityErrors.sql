/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ADFActivityErrors] (
    [EngineId]                    BIGINT           NULL,
    [TenantId]                    VARCHAR (MAX)    NULL,
    [SourceSystem]                VARCHAR (MAX)    NULL,
    [TimeGenerated]               DATETIME         NULL,
    [ResourceId]                  VARCHAR (MAX)    NULL,
    [OperationName]               VARCHAR (MAX)    NULL,
    [Category]                    VARCHAR (MAX)    NULL,
    [CorrelationId]               UNIQUEIDENTIFIER NOT NULL,
    [Level]                       VARCHAR (MAX)    NULL,
    [Location]                    VARCHAR (MAX)    NULL,
    [Tags]                        VARCHAR (MAX)    NULL,
    [Status]                      VARCHAR (MAX)    NULL,
    [UserProperties]              VARCHAR (MAX)    NULL,
    [Annotations]                 VARCHAR (MAX)    NULL,
    [EventMessage]                VARCHAR (MAX)    NULL,
    [Start]                       DATETIME         NULL,
    [ActivityName]                VARCHAR (MAX)    NULL,
    [ActivityRunId]               VARCHAR (MAX)    NULL,
    [PipelineRunId]               UNIQUEIDENTIFIER NULL,
    [EffectiveIntegrationRuntime] VARCHAR (MAX)    NULL,
    [ActivityType]                VARCHAR (MAX)    NULL,
    [ActivityIterationCount]      INT              NULL,
    [LinkedServiceName]           VARCHAR (MAX)    NULL,
    [End]                         DATETIME         NULL,
    [FailureType]                 VARCHAR (MAX)    NULL,
    [PipelineName]                VARCHAR (MAX)    NULL,
    [Input]                       VARCHAR (MAX)    NULL,
    [Output]                      VARCHAR (MAX)    NULL,
    [ErrorCode]                   VARCHAR (50)     NULL,
    [ErrorMessage]                VARCHAR (MAX)    NULL,
    [Error]                       VARCHAR (MAX)    NULL,
    [Type]                        VARCHAR (MAX)    NULL
);






GO
CREATE CLUSTERED INDEX [IX_ADFActivityErrors]
    ON [dbo].[ADFActivityErrors]([TimeGenerated] ASC);

