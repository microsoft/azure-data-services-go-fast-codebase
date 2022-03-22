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
        [EngineId]                         
    )
    select 
        0                          ,
        '[0]  File copy between datalake zones of SalesLT.Customer*.parquet (Binary) from ADLS to ADLS SalesLT.Customer.parquet (Binary)'                      ,
        -2                            ,
        -3                           ,
        -4                      ,
        -4                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer*.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "Type": "Binary"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/0",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Binary"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -1                          ,
        '[1]  File copy between datalake zones of SalesLT.Customer*.parquet (Binary) from ADLS to ADLS SalesLT.Customer.parquet (Binary)'                      ,
        -2                            ,
        -2                           ,
        -4                      ,
        -4                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer*.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "Type": "Binary"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/1",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Binary"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -2                          ,
        '[2]  Folder copy between datalake zones of *.* (Binary) from ADLS to ADLS  (Binary)'                      ,
        -2                            ,
        -2                           ,
        -4                      ,
        -4                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "*.*",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "Type": "Binary"
    },
    "Target": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/2",
        "SchemaFileName": "",
        "Type": "Binary"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -3                          ,
        '[3]  File copy between datalake zones of yellow_tripdata_2017-03.xlsx (Excel) from ADLS to ADLS yellow_tripdata_2017-03.parquet (Parquet)'                      ,
        -2                            ,
        -2                           ,
        -4                      ,
        -4                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": "",
        "Type": "Excel"
    },
    "Target": {
        "DataFileName": "yellow_tripdata_2017-03.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to SQL Database/3",
        "SchemaFileName": "",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -4                          ,
        '[4]  File copy between datalake zones of yellow_tripdata_2017-03.xlsx (Excel) from ADLS to ADLS yellow_tripdata_2017-03.csv (Csv)'                      ,
        -2                            ,
        -3                           ,
        -4                      ,
        -4                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": "",
        "Type": "Excel"
    },
    "Target": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/4",
        "SchemaFileName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -5                          ,
        '[5]  File copy between datalake zones of yellow_tripdata_2017-03.xlsx (Excel) from ADLS to ADLS yellow_tripdata_2017-03.json (Json)'                      ,
        -2                            ,
        -1                           ,
        -4                      ,
        -4                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": "",
        "Type": "Excel"
    },
    "Target": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/5",
        "SchemaFileName": "",
        "Type": "Json"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -6                          ,
        '[6]  File copy from data lake to FileServer of yellow_tripdata_2017-03.xlsx (Binary) from ADLS to FileServer yellow_tripdata_2017-03.xlsx (Binary)'                      ,
        -2                            ,
        -3                           ,
        -4                      ,
        -4                        ,
        -15                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "Type": "Binary"
    },
    "Target": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "c:/Tests/Azure Storage to Azure Storage/6",
        "SchemaFileName": "",
        "Type": "Binary"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -7                          ,
        '[-7]  FullLoad of SalesLT.Customer.parquet (Parquet) from ADLS to Azure SQL'                      ,
        -1                            ,
        -3                           ,
        -4                      ,
        -4                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "true",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_Customer-7",
        "StagingTableSchema": "dbo",
        "TableName": "Customer-7",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -8                          ,
        '[-6]  FullLoad of SalesLT.Customer.parquet (Parquet) from Azure Blob to Azure SQL'                      ,
        -1                            ,
        -2                           ,
        -4                      ,
        -3                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "true",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_Customer-6",
        "StagingTableSchema": "dbo",
        "TableName": "Customer-6",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -9                          ,
        '[-5]  FullLoad of yellow_tripdata_2017-03.xlsx (Excel) from ADLS to Azure SQL'                      ,
        -1                            ,
        -4                           ,
        -4                      ,
        -4                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": 0,
        "Type": "Excel"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata-5",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata-5",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -10                          ,
        '[-4]  FullLoad of yellow_tripdata_2017-03.xlsx (Excel) from Azure Blob to Azure SQL'                      ,
        -1                            ,
        -2                           ,
        -4                      ,
        -3                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": 0,
        "Type": "Excel"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata-4",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata-4",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -11                          ,
        '[-3]  FullLoad of yellow_tripdata_2017-03.csv (Csv) from Azure Blob to Azure SQL'                      ,
        -1                            ,
        -1                           ,
        -4                      ,
        -3                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata-3",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata-3",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -12                          ,
        '[-2]  FullLoad of yellow_tripdata_2017-03.json (Json) from Azure Blob to Azure SQL'                      ,
        -1                            ,
        -4                           ,
        -4                      ,
        -3                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "Type": "Json"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata-2",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata-2",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -13                          ,
        '[-1]  FullLoad of yellow_tripdata_2017-03.csv (Csv) from ADLS to Azure SQL'                      ,
        -1                            ,
        -2                           ,
        -4                      ,
        -4                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata-1",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata-1",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -14                          ,
        '[0]  FullLoad of yellow_tripdata_2017-03.json (Json) from ADLS to Azure SQL'                      ,
        -1                            ,
        -1                           ,
        -4                      ,
        -4                        ,
        -2                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "Type": "Json"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata0",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata0",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -15                          ,
        '[1]  FullLoad of SalesLT.Customer.parquet (Parquet) from ADLS to Azure Synapse'                      ,
        -1                            ,
        -2                           ,
        -4                      ,
        -4                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "true",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_Customer1",
        "StagingTableSchema": "dbo",
        "TableName": "Customer1",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -16                          ,
        '[2]  FullLoad of SalesLT.Customer.parquet (Parquet) from Azure Blob to Azure Synapse'                      ,
        -1                            ,
        -4                           ,
        -4                      ,
        -3                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "SalesLT.Customer.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "true",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_Customer2",
        "StagingTableSchema": "dbo",
        "TableName": "Customer2",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -17                          ,
        '[3]  FullLoad of yellow_tripdata_2017-03.xlsx (Excel) from ADLS to Azure Synapse'                      ,
        -1                            ,
        -1                           ,
        -4                      ,
        -4                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": 0,
        "Type": "Excel"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata3",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata3",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -18                          ,
        '[4]  FullLoad of yellow_tripdata_2017-03.xlsx (Excel) from Azure Blob to Azure Synapse'                      ,
        -1                            ,
        -4                           ,
        -4                      ,
        -3                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.xlsx",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SheetName": "yellow_tripdata_2017-03",
        "SkipLineCount": 0,
        "Type": "Excel"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata4",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata4",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -19                          ,
        '[5]  FullLoad of yellow_tripdata_2017-03.csv (Csv) from Azure Blob to Azure Synapse'                      ,
        -1                            ,
        -3                           ,
        -4                      ,
        -3                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata5",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata5",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -20                          ,
        '[6]  FullLoad of yellow_tripdata_2017-03.json (Json) from Azure Blob to Azure Synapse'                      ,
        -1                            ,
        -1                           ,
        -4                      ,
        -3                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "Type": "Json"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata6",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata6",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -21                          ,
        '[7]  FullLoad of yellow_tripdata_2017-03.csv (Csv) from ADLS to Azure Synapse'                      ,
        -1                            ,
        -4                           ,
        -4                      ,
        -4                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.csv",
        "DeleteAfterCompletion": "false",
        "FirstRowAsHeader": "true",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "SkipLineCount": 0,
        "Type": "Csv"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata7",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata7",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -22                          ,
        '[8]  FullLoad of yellow_tripdata_2017-03.json (Json) from ADLS to Azure Synapse'                      ,
        -1                            ,
        -2                           ,
        -4                      ,
        -4                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "DataFileName": "yellow_tripdata_2017-03.json",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "",
        "Type": "Json"
    },
    "Target": {
        "AutoCreateTable": "true",
        "AutoGenerateMerge": "false",
        "MergeSQL": "",
        "PostCopySQL": "",
        "PreCopySQL": "",
        "StagingTableName": "stg_yellow_tripdata8",
        "StagingTableSchema": "dbo",
        "TableName": "yellow_tripdata8",
        "TableSchema": "dbo",
        "Type": "Table"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -23                          ,
        '[-23]  FullLoad of SalesLT.Customer (Table) from Azure SQL to SalesLT.Customer.parquet in Azure Blob(Parquet)'                      ,
        -3                            ,
        -4                           ,
        -4                      ,
        -1                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-23",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -24                          ,
        '[-22]  FullLoad of SalesLT.Customer (Table) from Azure SQL to SalesLT.Customer.parquet in ADLS(Parquet)'                      ,
        -3                            ,
        -1                           ,
        -4                      ,
        -1                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-22",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -25                          ,
        '[-21]  FullLoadUsingExtractionSql of SalesLT.Customer (Table) from Azure SQL to SalesLT.Customer.parquet in ADLS(Parquet)'                      ,
        -3                            ,
        -1                           ,
        -4                      ,
        -1                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "Select top 10 * from SalesLT.Customer",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-21",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -26                          ,
        '[-20]  FullLoadWithChunk of SalesLT.Customer (Table) from Azure SQL to SalesLT.Customer.parquet in ADLS(Parquet)'                      ,
        -3                            ,
        -3                           ,
        -4                      ,
        -1                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "CustomerID",
        "ChunkSize": 100,
        "ExtractionSQL": "Select top 10 * from SalesLT.Customer",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-20",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -27                          ,
        '[-19]  IncrementalLoad of SalesLT.Customer (Table) from Azure SQL to SalesLT.Customer.parquet in ADLS(Parquet)'                      ,
        -3                            ,
        -1                           ,
        -4                      ,
        -1                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "Select top 10 * from SalesLT.Customer",
        "IncrementalType": "Watermark",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-19",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -28                          ,
        '[-18]  FullLoad of SalesLT.Customer (Table) from SQL Server to SalesLT.Customer.parquet in Azure Blob(Parquet)'                      ,
        -3                            ,
        -1                           ,
        -4                      ,
        -6                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-18",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -29                          ,
        '[-17]  FullLoad of SalesLT.Customer (Table) from SQL Server to SalesLT.Customer.parquet in ADLS(Parquet)'                      ,
        -3                            ,
        -2                           ,
        -4                      ,
        -6                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-17",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
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
        [EngineId]                         
    )
    select 
        -30                          ,
        '[-16]  FullLoad of SalesLT.Customer (Table) from SQL Server to dbo.all_objects.parquet in ADLS(Parquet)'                      ,
        -3                            ,
        -2                           ,
        -4                      ,
        -6                        ,
        -4                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "Source": {
        "ChunkField": "",
        "ChunkSize": 0,
        "ExtractionSQL": "",
        "IncrementalType": "Full",
        "TableName": "Customer",
        "TableSchema": "SalesLT",
        "Type": "Table"
    },
    "Target": {
        "DataFileName": "dbo.all_objects.parquet",
        "RelativePath": "/Tests/SQL Database to Azure Storage/-16",
        "SchemaFileName": "dbo_all_objects.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -1;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
