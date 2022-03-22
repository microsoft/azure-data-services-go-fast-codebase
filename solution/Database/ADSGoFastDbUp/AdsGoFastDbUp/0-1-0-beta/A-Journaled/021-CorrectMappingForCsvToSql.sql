update [dbo].[TaskTypeMapping]
set MappingName = 'GPL_AzureBlobFS_DelimitedText_AzureSqlTable_NA'
where sourcesystemtype = 'ADLS' and sourcetype = 'Csv' and targetsystemtype = 'Azure SQL' and TargetType = 'Table' and MappingType = 'ADF' and TaskTypeId = 1