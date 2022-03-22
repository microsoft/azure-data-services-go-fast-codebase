/* Adding a column called "IsExternal" to the [SourceAndTargetSystems] Table */

IF EXISTS 
(
  SELECT * 
  FROM INFORMATION_SCHEMA.COLUMNS 
  WHERE table_name = 'SourceAndTargetSystems'
	AND table_schema = 'dbo'
  AND column_name = 'IsExternal'
)
SELECT 'Column exists in table already - Not adding IsExternal' AS [Status] ;
ELSE
ALTER TABLE [dbo].[SourceAndTargetSystems] ADD IsExternal BIT NOT NULL default 0