/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
Create procedure [dbo].[UpdFrameworkTaskRunner] (@TaskRunnerId as int) as 
Update FrameworkTaskRunner
Set Status = 'Idle', LastExecutionEndDateTime = GETUTCDATE()
