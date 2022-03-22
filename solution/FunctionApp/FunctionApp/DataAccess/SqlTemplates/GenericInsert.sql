/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
 

INSERT INTO {TargetFullName} 
({InsertList})
SELECT
{SelectListForInsert}
FROM 
[{SourceFullName}] AS b
