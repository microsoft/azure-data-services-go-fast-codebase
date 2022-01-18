------------------------------------------------------------------------------------------------------------------------------------------------------
-- Cleanup the old / noisy sample data
------------------------------------------------------------------------------------------------------------------------------------------------------
declare @integrationRuntimeName nvarchar(100)
declare @sampleTaskGroupId int

Set @integrationRuntimeName  = N'Azure'

delete from TaskInstanceExecution where taskinstanceid in (select te.taskinstanceid
	from [dbo].[TaskInstanceExecution] te
		inner join [dbo].[TaskInstance] ti
			on ti.TaskInstanceId = te.TaskInstanceId
	where ti.taskmasterid <= 228			)

delete from TaskInstance where taskmasterid <= 228
delete from TaskMaster where taskmasterid <= 228
delete from TaskMasterDependency where AncestorTaskMasterId <= 228
delete from TaskMasterWaterMark where TaskMasterId <= 228
delete from SubjectArea where subjectareaid <= 2
delete from SourceAndTargetSystems where SystemId in (5, 6, 10, 11, 12, 13)
delete from TaskGroupDependency
delete from TaskGroupDependency where AncestorTaskGroupId <= 9
delete from TaskGroup where TaskGroupId <= 9
delete from TaskType where tasktypeid between 5 and 11
delete from [dbo].[TaskTypeMapping] where tasktypeid between 5 and 11

------------------------------------------------------------------------------------------------------------------------------------------------------
-- Rename the existing useful samples to use actual resource names
------------------------------------------------------------------------------------------------------------------------------------------------------
Update SourceAndTargetSystems set SystemName = '$SqlServerName$\$SampleDatabaseName$', SystemDescription = 'Azure SQL Database - ADS Go Fast $SampleDatabaseName$ Db' where SystemId = 1
Update SourceAndTargetSystems set SystemName = '$SqlServerName$\$StagingDatabaseName$', SystemDescription = 'Azure SQL Database - ADS Go Fast $StagingDatabaseName$ Db' where SystemId = 2
Update SourceAndTargetSystems set SystemName = '$BlobStorageName$\datalakeraw', SystemDescription = 'Azure Blob - ADS Go Fast DataLakeLRaw Container' where SystemId = 3
Update SourceAndTargetSystems set SystemName = '$AdlsStorageName$\datalakeraw', SystemDescription = 'Azure Data Lake - ADS Go Fast DataLakeLRaw Container' where SystemId = 4
Update SourceAndTargetSystems set SystemName = '$BlobStorageName$\datalakelanding', SystemDescription = 'Azure Blob - ADS Go Fast DataLakeLandingZone Container' where SystemId = 7
Update SourceAndTargetSystems set SystemName = '$AdlsStorageName$\datalakelanding', SystemDescription = 'Azure Data Lake - ADS Go Fast DataLakeLandingZone Container' where SystemId = 8
Update SourceAndTargetSystems set SystemName = '$BlobStorageName$\transientin', SystemDescription = 'Azure Data Lake - ADS Go Fast TransientIn Container' where SystemId = 9


update [dbo].[SourceAndTargetSystems] set IsExternal = 0
update [dbo].[SourceAndTargetSystems] set IsExternal = 1 where SystemId = 9
------------------------------------------------------------------------------------------------------------------------------------------------------
-- Add new records
------------------------------------------------------------------------------------------------------------------------------------------------------
-- Subject Area
SET IDENTITY_INSERT [dbo].[SubjectArea] ON
INSERT INTO [dbo].[SubjectArea] ([SubjectAreaId], [SubjectAreaName], [ActiveYN], [SubjectAreaFormId], [DefaultTargetSchema], [UpdatedBy]) VALUES (1, N'Sample Subject Area', 1, NULL, N'N/A', N'system@microsoft.com')
SET IDENTITY_INSERT [dbo].[SubjectArea] OFF

-- Task Group
INSERT INTO [dbo].[TaskGroup] ([TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values ('Sample Task Group',1, 0, 10, '{}', 1)

Select @sampleTaskGroupId = TaskGroupId From dbo.TaskGroup where TaskGroupName = 'Sample Task Group'

SET IDENTITY_INSERT [dbo].[TaskMaster] ON
-- Task Master
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) 
VALUES (2, N'CSV Import NY Taxi Data into Azure SQL', 1, @sampleTaskGroupId, 2, 3, 2, 1, 0, @integrationRuntimeName, N'
{
    "Source": {
        "Type": "Csv",        
        "RelativePath": "/samples/",
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SkipLineCount": "0",
        "MaxConcorrentConnections" : "10"
    },
    "Target": {
        "Type": "Table",
        "TableSchema": "dbo",
        "TableName": "NYTaxiYellowTripData",
        "StagingTableSchema": "dbo",
        "StagingTableName": "stg_NYTaxiYellowTripData",
        "AutoCreateTable": "True",
        "PreCopySQL": "IF OBJECT_ID(''dbo.stg_NYTaxiYellowTripData'') IS NOT NULL \r\n Truncate Table dbo.stg_NYTaxiYellowTripData",
        "PostCopySQL": "",
        "MergeSQL": "",
        "AutoGenerateMerge": "False",
        "DynamicMapping": {
        }
    }
}
', 0, NULL, 1)

INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) 
VALUES (10, N'Azure SQL SalesLT.Customer Extract to Data Lake', 3, @sampleTaskGroupId, 2, 1, 3, 1, 0, @integrationRuntimeName, N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "Customer"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Customer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Customer.parquet",
    "SchemaFileName": "SalesLT.Customer.json"
  }
}', 0, N'SalesLT.Customer', 1)

INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) 
VALUES (41, N'Azure SQL ErrorLog Extract to Data Lake', 3, @sampleTaskGroupId, 2, 1, 4, 1, 0,@integrationRuntimeName, N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "ErrorLog"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/ErrorLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.ErrorLog.parquet",
    "SchemaFileName": "dbo.ErrorLog.json"
  }
}', 0, N'dbo.adls_ErrorLog', 1)

INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) 
VALUES (206, N'Excel Import NY Taxi Data into DelimitedText', 2, @sampleTaskGroupId, 2, 3, 3, 1, 0, @integrationRuntimeName, N'
{
    "Source": {
        "Type": "Excel",               
        "RelativePath": "/",
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SheetName": "yellow_tripdata_2017-03"
    },
    "Target": {
        "Type": "Csv",
        "RelativePath": "/",
        "DataFileName": "yellow_tripdata_2017-03_converted.csv",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True"
    }
}
', 0, NULL, 1)
SET IDENTITY_INSERT [dbo].[TaskMaster] OFF
-- Task Master Water Mark
INSERT [dbo].[TaskMasterWaterMark] ([TaskMasterId], [TaskMasterWaterMarkColumn], [TaskMasterWaterMarkColumnType], [TaskMasterWaterMark_DateTime], [TaskMasterWaterMark_BigInt], [TaskWaterMarkJSON], [ActiveYN], [UpdatedOn]) 
VALUES (10, N'ModifiedDate', N'DateTime', CAST(N'2009-05-16T16:33:33.123' AS DateTime), NULL, NULL, 1, CAST(N'2020-08-07T04:03:23.2200000+00:00' AS DateTimeOffset))