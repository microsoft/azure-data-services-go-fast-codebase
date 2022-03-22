## TaskMaster


This table defines a copy task between source and target systems.  In general, it references other tables for:
* TaskType - for the type of task
* TaskGroup and ScheduleMaster - for when this task should be scheduled
* two references to the SourceAndTargetSystems table - for the Source and Target system

The detailed specification for the source and target details is contained in JSON format in the TaskMasterJSON column. 

An example of this type of format is:
``` js
{ "Source": { 
    "Type": "Excel",
	"RelativePath": "/data/sampledata/",
	"DataFileName": "FinancialSample.xlsx",
	"SchemaFileName": "",
	"FirstRowAsHeader": "True",
	"SheetName": "Sheet1"
},    
"Target": 
{  "Type": "Table",
	"StagingTableSchema": "dbo",
	"StagingTableName": "stg_AUFinancialLicenses",
	"AutoCreateTable": "False",
	"TableSchema": "dbo",
	"TableName": "AUFinancialLicenses",
	"PreCopySQL": "IF OBJECT_ID('dbo.stg_AUFinancialLicenses') 
	               IS NOT NULL Truncate Table dbo.stg_AUFinancialLicenses",
	"PostCopySQL": "",
	"MergeSQL": "",
	"AutoGenerateMerge": "False"
}}
```