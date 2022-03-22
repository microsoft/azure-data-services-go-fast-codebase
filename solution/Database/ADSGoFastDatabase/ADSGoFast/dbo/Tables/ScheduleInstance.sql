/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[ScheduleInstance] (
    [ScheduleInstanceId]      BIGINT             IDENTITY (1, 1) NOT NULL,
    [ScheduleMasterId]        BIGINT             NULL,
    [ScheduledDateUtc]        DATETIME           NULL,
    [ScheduledDateTimeOffset] DATETIMEOFFSET (7) NULL,
    [ActiveYN]                BIT                NULL,
    PRIMARY KEY CLUSTERED ([ScheduleInstanceId] ASC)
);

