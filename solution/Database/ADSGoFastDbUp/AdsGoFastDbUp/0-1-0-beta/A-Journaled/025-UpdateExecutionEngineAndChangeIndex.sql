/* 
Replacing the Tasktype primary key with negative integers
*/
BEGIN

drop table if exists #TempTaskType 

CREATE TABLE #TempTaskType (
    [TaskTypeId]        INT,
    [TaskTypeName]      NVARCHAR (128) NOT NULL,
    [TaskExecutionType] NVARCHAR (5)   NOT NULL,
    [TaskTypeJson]      NVARCHAR (MAX) NULL,
    [ActiveYN]          BIT            NOT NULL
);

insert into #TempTaskType
Select *
from [dbo].[TaskType]

Update #TempTaskType 
Set TaskTypeId = -1*TaskTypeId

SET IDENTITY_INSERT [dbo].[TaskType] ON 
truncate table TaskType
Insert into [dbo].[TaskType]
([TaskTypeId], [TaskTypeName], [TaskExecutionType], [TaskTypeJson], [ActiveYN])

Select * from #TempTaskType
SET IDENTITY_INSERT [dbo].[TaskType] OFF

END

/* 
Replacing the SourceAndTargetSystems primary key with negative integers
*/

BEGIN

drop table if exists #TempSourceAndTargetSystems 

CREATE TABLE #TempSourceAndTargetSystems (
    [SystemId]              BIGINT   		NOT NULL,
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
	[DataFactoryIR]         VARCHAR  (20)   NULL
);
insert into #TempSourceAndTargetSystems
Select *
from [dbo].[SourceAndTargetSystems]

Update #TempSourceAndTargetSystems 
Set SystemId = -1*SystemId

SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON 
truncate table SourceAndTargetSystems
Insert into [dbo].[SourceAndTargetSystems]
(
[SystemId],
[SystemName],
[SystemType],
[SystemDescription],
[SystemServer],
[SystemAuthType],
[SystemUserName],
[SystemSecretName],
[SystemKeyVaultBaseUrl],
[SystemJSON],
[ActiveYN],
[IsExternal],
[DataFactoryIR]
)

Select * from #TempSourceAndTargetSystems
SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF

END

/* 
Replacing the ScheduleMaster primary key with negative integers
*/

BEGIN

drop table if exists #TempScheduleMaster

CREATE TABLE #TempScheduleMaster (
    [ScheduleMasterId]       BIGINT         NOT NULL,
    [ScheduleCronExpression] NVARCHAR (200) NOT NULL,
    [ScheduleDesciption]     VARCHAR (200)  NOT NULL,
    [ActiveYN]               BIT            NULL

);
insert into #TempScheduleMaster
Select *
from [dbo].[ScheduleMaster]

Update #TempScheduleMaster 
Set ScheduleMasterId = -1*ScheduleMasterId

SET IDENTITY_INSERT [dbo].[ScheduleMaster] ON 
truncate table ScheduleMaster
Insert into [dbo].[ScheduleMaster]
(
    [ScheduleMasterId],
    [ScheduleCronExpression],
    [ScheduleDesciption],
    [ActiveYN]
)

Select * from #TempScheduleMaster
SET IDENTITY_INSERT [dbo].[ScheduleMaster] OFF

END


/*
We are modifying the execution engine table and adding the datafactory and synapse datafactory to it
We are also creating a ExecutionEngineSchema table
*/

alter table [dbo].[ExecutionEngine] drop column [ResouceName], [ResourceGroup], [SubscriptionUid]


/*
Adding two engines (datafactory and synapse) into the execution engines
*/

BEGIN

SET IDENTITY_INSERT [dbo].[ExecutionEngine] ON 

INSERT INTO [dbo].[ExecutionEngine] (EngineId, EngineName, DefaultKeyVaultURL, EngineJson) 
VALUES (-1,'Datafactory','https://$KeyVaultName$.vault.azure.net/',N'
{}
')

SET IDENTITY_INSERT [dbo].[ExecutionEngine] OFF

END

BEGIN

SET IDENTITY_INSERT [dbo].[ExecutionEngine] ON 

INSERT INTO [dbo].[ExecutionEngine] (EngineId, EngineName, DefaultKeyVaultURL, EngineJson) 
VALUES (-2,'Synapse','https://$KeyVaultName$.vault.azure.net/',N'
{
    "endpoint": "placeholderendpoint"
}
')

SET IDENTITY_INSERT [dbo].[ExecutionEngine] OFF

END

/*
Creating the Execution Engine JsonSchema table
*/


BEGIN

CREATE TABLE [dbo].[ExecutionEngine_JsonSchema] (
    [SystemType] VARCHAR (255)  NOT NULL,
    [JsonSchema] NVARCHAR (MAX) NULL,
    PRIMARY KEY CLUSTERED ([SystemType] ASC)
);

END

/*
Inserting the schema's for a synapse pipeline and datafactory pipeline
*/
BEGIN

INSERT INTO [dbo].[ExecutionEngine_JsonSchema] (SystemType, JsonSchema)
VALUES ('Datafactory',N'
{
    "$schema": "http://json-schema.org/draft-04/schema#",  
    "type": "object", 
    "properties": 
    {    
    },  
    "required": [      ]}
}
')

END

BEGIN

INSERT INTO [dbo].[ExecutionEngine_JsonSchema] (SystemType, JsonSchema) 
VALUES ('Synapse',N'
{
    "$schema": "http://json-schema.org/draft-04/schema#",  
    "type": "object", 
    "properties": 
    {    
        "endpoint": 
        {      
            "type": "string"    
        }  
    },  
    "required": [    "endpoint"  ]}
}
')

END
