/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
CREATE TABLE [dbo].[TaskMasterWaterMark] (
    [TaskMasterId]                  BIGINT             NOT NULL,
    [TaskMasterWaterMarkColumn]     NVARCHAR (200)     NOT NULL,
    [TaskMasterWaterMarkColumnType] NVARCHAR (50)      NOT NULL,
    [TaskMasterWaterMark_DateTime]  DATETIME           NULL,
    [TaskMasterWaterMark_BigInt]    BIGINT             NULL,
    [TaskWaterMarkJSON]             NVARCHAR (4000)    NULL,
    [ActiveYN]                      BIT                NOT NULL,
    [UpdatedOn]                     DATETIMEOFFSET (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([TaskMasterId] ASC)
);

