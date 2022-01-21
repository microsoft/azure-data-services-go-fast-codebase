delete from [dbo].[TaskGroup] where taskgroupid <=0;            
            
SET IDENTITY_INSERT [dbo].[TaskGroup] ON
INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-1,'Test Tasks',1, 0,10,null,1)

INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-2,'Test Tasks2',1, 0,10,null,1)

INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-3,'Test Tasks3',1, 0,10,null,1)

INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-4,'Test Tasks4',1, 0,10,null,1)

SET IDENTITY_INSERT [dbo].[TaskGroup] OFF

delete from [dbo].[TaskMaster] where taskmasterid <=0;

delete from [dbo].[TaskInstance] where taskmasterid <=0;




                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        0                          ,
        'GPL_AzureBlobFS_Binary_AzureBlobFS_Binary0'                      ,
        1                            ,
        -3                           ,
        4                      ,
        4                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer*.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/storage-to-storage-copy/",
        "SchemaFileName": "SalesLT.Customer.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -1                          ,
        'GPL_AzureBlobFS_Binary_AzureBlobFS_Binary1'                      ,
        1                            ,
        -2                           ,
        4                      ,
        4                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer*.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/storage-to-storage-copy/",
        "SchemaFileName": "SalesLT.Customer.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -2                          ,
        'GPL_AzureBlobFS_Parquet_AzureSqlTable_NA_IRA2'                      ,
        1                            ,
        -4                           ,
        4                      ,
        4                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "true",
        "DataFileName": "SalesLT.Customer.parquet",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "SalesLT.Customer.json",
        "StagingTableName": "stg_Customer2",
        "StagingTableSchema": "dbo",
        "TableName": "Customer2",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -3                          ,
        'GPL_AzureBlobStorage_Parquet_AzureSqlTable_NA_IRA3'                      ,
        1                            ,
        -2                           ,
        4                      ,
        3                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "true",
        "DataFileName": "SalesLT.Customer.parquet",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "SalesLT.Customer.json",
        "StagingTableName": "stg_Customer3",
        "StagingTableSchema": "dbo",
        "TableName": "Customer3",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -4                          ,
        'GPL_AzureBlobFS_Excel_AzureSqlTable_NA_IRA4'                      ,
        1                            ,
        -1                           ,
        4                      ,
        4                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": "",
        "Type": "Excel"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "",
        "StagingTableName": "stg_yellow_tripdata4",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata4",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -5                          ,
        'GPL_AzureBlobStorage_Excel_AzureSqlTable_NA_IRA5'                      ,
        1                            ,
        -2                           ,
        4                      ,
        3                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": "",
        "Type": "Excel"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "",
        "StagingTableName": "stg_yellow_tripdata5",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata5",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -6                          ,
        'GPL_AzureBlobStorage_DelimitedText_AzureSqlTable_NA_IRA6'                      ,
        1                            ,
        -2                           ,
        4                      ,
        3                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "",
        "StagingTableName": "stg_yellow_tripdata6",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata6",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -7                          ,
        'GPL_AzureBlobStorage_json_AzureSqlTable_NA_IRA7'                      ,
        1                            ,
        -1                           ,
        4                      ,
        3                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "",
        "SkipLineCount": 0,
        "Type": "Json"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "ALTER TABLE stg_yellow_tripdata12 ALTER COLUMN fare_amount float; ALTER TABLE stg_yellow_tripdata12 ALTER COLUMN tolls_amount float;",
        "SchemaFileName": "",
        "StagingTableName": "stg_yellow_tripdata7",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata7",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -8                          ,
        'GPL_AzureBlobFS_DelimitedText_AzureSqlTable_NA_IRA8'                      ,
        1                            ,
        -3                           ,
        4                      ,
        4                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "",
        "StagingTableName": "stg_yellow_tripdata8",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata8",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -9                          ,
        'GPL_AzureBlobFS_json_AzureSqlTable_NA_IRA9'                      ,
        1                            ,
        -1                           ,
        4                      ,
        4                        ,
        2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "",
        "SkipLineCount": 0,
        "Type": "Json"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "ALTER TABLE stg_yellow_tripdata14 ALTER COLUMN fare_amount float; ALTER TABLE stg_yellow_tripdata14 ALTER COLUMN tolls_amount float;",
        "SchemaFileName": "",
        "StagingTableName": "stg_yellow_tripdata9",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata9",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -10                          ,
        'GPL_AzureBlobStorage_Parquet_AzureSqlDWTable_NA_IRA10'                      ,
        1                            ,
        -2                           ,
        4                      ,
        3                        ,
        10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "false",
        "MaxConcorrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "SheetName": "",
        "SkipLineCount": "",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "false",
        "AutoGenerateMerge": "false",
        "DataFileName": "SalesLT.Customer.parquet",
        "DynamicMapping": {

        },
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "SchemaFileName": "SalesLT.Customer.json",
        "StagingTableName": "stg_Customer10",
        "StagingTableSchema": "dbo",
        "TableName": "Customer10",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -11                          ,
        'GPL_AzureSqlTable_NA_AzureBlobStorage_Parquet11'                      ,
        3                            ,
        -4                           ,
        4                      ,
        1                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalColumnType": "",
        "IncrementalField": "",
        "IncrementalType": "Full",
        "IncrementalValue": "0",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/11",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -12                          ,
        'GPL_AzureSqlTable_NA_AzureBlobFS_Parquet12'                      ,
        3                            ,
        -1                           ,
        4                      ,
        1                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalColumnType": "",
        "IncrementalField": "",
        "IncrementalType": "Full",
        "IncrementalValue": "0",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/12",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -13                          ,
        'GPL_AzureSqlTable_NA_AzureBlobFS_Parquet13'                      ,
        3                            ,
        -1                           ,
        4                      ,
        1                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "Select top 10 * from SalesLT.Customer",
        "IncrementalColumnType": "",
        "IncrementalField": "",
        "IncrementalType": "Full",
        "IncrementalValue": "0",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/13",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -14                          ,
        'GPL_AzureSqlTable_NA_AzureBlobFS_Parquet14'                      ,
        3                            ,
        -2                           ,
        4                      ,
        1                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "CustomerID",
        "ChunkSize": 100,
        "ExtractionSQL": "Select top 10 * from SalesLT.Customer",
        "IncrementalColumnType": "",
        "IncrementalField": "",
        "IncrementalType": "Full",
        "IncrementalValue": "0",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/14",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -15                          ,
        'GPL_AzureSqlTable_NA_AzureBlobFS_Parquet15'                      ,
        3                            ,
        -4                           ,
        4                      ,
        1                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "Select top 10 * from SalesLT.Customer",
        "IncrementalColumnType": "int",
        "IncrementalField": "CustomerID",
        "IncrementalType": "Watermark",
        "IncrementalValue": "10",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/15",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -16                          ,
        'GPL_SqlServerTable_NA_AzureBlobStorage_Parquet16'                      ,
        3                            ,
        -3                           ,
        4                      ,
        6                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalColumnType": "",
        "IncrementalField": "",
        "IncrementalType": "Full",
        "IncrementalValue": "0",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/16",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [DataFactoryId]                         
    )
    select 
        -17                          ,
        'GPL_SqlServerTable_NA_AzureBlobFS_Parquet17'                      ,
        3                            ,
        -4                           ,
        4                      ,
        6                        ,
        4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalColumnType": "",
        "IncrementalField": "",
        "IncrementalType": "Full",
        "IncrementalValue": "0",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/17",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        1                              ,
        ''                  ,
        1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
