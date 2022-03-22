/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[FrameworkTaskRunner] (
    [TaskRunnerId]               INT                NOT NULL,
    [TaskRunnerName]             VARCHAR (255)      NULL,
    [ActiveYN]                   BIT                NULL,
    [Status]                     VARCHAR (25)       NULL,
    [MaxConcurrentTasks]         INT                NULL,
    [LastExecutionStartDateTime] DATETIMEOFFSET (7) NULL,
    [LastExecutionEndDateTime]   DATETIMEOFFSET (7) NULL,
    PRIMARY KEY CLUSTERED ([TaskRunnerId] ASC)
);





