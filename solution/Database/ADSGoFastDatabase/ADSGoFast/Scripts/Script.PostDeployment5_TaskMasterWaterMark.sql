/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
/*
TaskMasterWaterMark
*/

INSERT INTO [dbo].[TaskMasterWaterMark]
([TaskMasterId],[TaskMasterWaterMarkColumn],[TaskMasterWaterMarkColumnType],[TaskMasterWaterMark_DateTime],[TaskMasterWaterMark_BigInt],[TaskWaterMarkJSON],[ActiveYN],[UpdatedOn])
VALUES (2,'ModifiedDate','DateTime',null,null,null,1,getdate())
GO
