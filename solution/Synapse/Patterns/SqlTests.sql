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
        '[0]  File copy between datalake zones of SalesLT.Customer*.parquet (Parquet) from ADLS to ADLS SalesLT.Customer (Delta)'                      ,
        -2                            ,
        -4                           ,
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
        "Type": "Parquet"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Delta"
    }
}'                      ,
        0                              ,
        ''                  ,
        -2;  
    
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
        '[1]  File copy between datalake zones of SalesLT-Customer-Delta/SalesLT.Customer/ (Delta) from ADLS to ADLS DeltaTable/SalesLT.Customer (Delta)'                      ,
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
        "DataFileName": "SalesLT-Customer-Delta/SalesLT.Customer/",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "Type": "Delta"
    },
    "Target": {
        "DataFileName": "DeltaTable/SalesLT.Customer",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Delta"
    }
}'                      ,
        0                              ,
        ''                  ,
        -2;  
    
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
        '[2]  File copy between datalake zones of SalesLT-Customer-Delta/SalesLT.Customer/ (Delta) from ADLS to ADLS SalesLT.Customer*.parquet (Parquet)'                      ,
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
        "DataFileName": "SalesLT-Customer-Delta/SalesLT.Customer/",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "samples/",
        "SchemaFileName": "SalesLT.Customer*.json",
        "Type": "Delta"
    },
    "Target": {
        "DataFileName": "SalesLT.Customer*.parquet",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "/Tests/Azure Storage to Azure Storage/",
        "SchemaFileName": "SalesLT.Customer.json",
        "Type": "Parquet"
    }
}'                      ,
        0                              ,
        ''                  ,
        -2;  
    
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
        '[-3]  Notebook execution test.'                      ,
        -5                            ,
        -3                           ,
        -4                      ,
        -16                        ,
        -16                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "CustomDefinitions": "",
    "ExecuteNotebook": "Notebook 1",
    "Source": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "",
        "SchemaFileName": "",
        "Type": "Notebook-Optional"
    },
    "Target": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "",
        "SchemaFileName": "",
        "Type": "Notebook-Optional"
    }
}'                      ,
        0                              ,
        ''                  ,
        -2;  
    
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
        '[-4]  SQL Dedicated Pool start execution test.'                      ,
        -6                            ,
        -3                           ,
        -4                      ,
        -16                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "SQLPoolName": "TestPool",
    "SQLPoolOperation": "start",
    "Source": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "",
        "SchemaFileName": "",
        "Type": "Not-Applicable"
    },
    "Target": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "",
        "SchemaFileName": "",
        "Type": "Not-Applicable"
    }
}'                      ,
        0                              ,
        ''                  ,
        -2;  
    
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
        '[-3]  SQL Dedicated Pool pause execution test.'                      ,
        -6                            ,
        -1                           ,
        -4                      ,
        -16                        ,
        -10                        ,
        1               ,
        0          ,
        'Azure'                     ,
        '{
    "SQLPoolName": "TestPool",
    "SQLPoolOperation": "pause",
    "Source": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "",
        "SchemaFileName": "",
        "Type": "Not-Applicable"
    },
    "Target": {
        "DataFileName": "",
        "DeleteAfterCompletion": "false",
        "MaxConcurrentConnections": 0,
        "Recursively": "false",
        "RelativePath": "",
        "SchemaFileName": "",
        "Type": "Not-Applicable"
    }
}'                      ,
        0                              ,
        ''                  ,
        -2;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    
