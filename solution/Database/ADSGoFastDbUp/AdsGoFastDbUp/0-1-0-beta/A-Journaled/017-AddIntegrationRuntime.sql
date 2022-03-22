
CREATE TABLE [dbo].[IntegrationRuntime] (
    [IntegrationRuntimeId]       INT                                         IDENTITY (1, 1) NOT NULL,
    [IntegrationRuntimeName]     VARCHAR (255)                               NULL,
    [DataFactoryId]       BIGINT                                         NULL,
    [ActiveYN]            BIT                                         NULL,
    
    PRIMARY KEY CLUSTERED ([IntegrationRuntimeId] ASC)
)


