/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ScheduleMaster] (
    [ScheduleMasterId]       BIGINT         IDENTITY (1, 1) NOT NULL,
    [ScheduleCronExpression] NVARCHAR (200) NOT NULL,
    [ScheduleDesciption]     VARCHAR (200)  NOT NULL,
    [ActiveYN]               BIT            NULL,
    PRIMARY KEY CLUSTERED ([ScheduleMasterId] ASC)
);

