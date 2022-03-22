CREATE TABLE [dbo].[ExecutionEngine_JsonSchema] (
    [SystemType] VARCHAR (255)  NOT NULL,
    [JsonSchema] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([SystemType] ASC)
);

