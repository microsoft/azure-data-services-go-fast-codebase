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
SET IDENTITY_INSERT [dbo].[TaskMaster] ON 

INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-1, N'afs_lic_202006.xlsx - AFS_LIC_202006', 1, 1, 2, 3, 2, 1, 0, N'SH IR', N'
{
    "Source": {
        "Type": "Excel",               
        "RelativePath": "/Gov/AUFinancialLicenses/",
        "DataFileName": "afs_lic_202006.xlsx",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SheetName": "AFS_LIC_202006"
    },
    "Target": {
        "Type": "Table",
        "StagingTableSchema": "dbo",
        "StagingTableName": "stg_AUFinancialLicenses",
        "AutoCreateTable": "False",
        "TableSchema": "dbo",
        "TableName": "AUFinancialLicenses",
        "PreCopySQL": "IF OBJECT_ID(''dbo.stg_AUFinancialLicenses'') IS NOT NULL 
            Truncate Table dbo.stg_AUFinancialLicenses",
        "PostCopySQL": "",
        "MergeSQL": "",
        "AutoGenerateMerge": "False"
    }
}
', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-2, N'yellow_tripdata_2017-03.csv - NYTaxi', 1, 1, 2, 3, 2, 1, 0, N'SH IR', N'
{
    "Source": {
        "Type": "csv",        
        "RelativePath": "/NYTaxi/",
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
        "AutoCreateTable": "False",
        "PreCopySQL": "IF OBJECT_ID(''dbo.stg_NYTaxiYellowTripData'') IS NOT NULL 
            Truncate Table dbo.stg_NYTaxiYellowTripData",
        "PostCopySQL": "",
        "MergeSQL": "",
        "AutoGenerateMerge": "True",
        "DynamicMapping": {
        }
    }
}
', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-3, N'BrisbaneHospital JSON', 1, 1, 2, 3, 2, 1, 0, N'SH IR', N'
{
    "Source": {
        "Type": "json",        
        "RelativePath": "/Gov/BrisbaneHospital/",
        "DataFileName": "brisbane-hospital-registers-deaths-1933-1963.json",
        "SchemaFileName": "",
        "MaxConcorrentConnections" : "10"
    },
    "Target": {
        "Type": "Table",
        "TableSchema": "dbo",
        "TableName": "BrisbHospRegDeaths",
        "StagingTableSchema": "dbo",
        "StagingTableName": "stg_BrisbHospRegDeaths",
        "AutoCreateTable": "False",
        "PreCopySQL": "IF OBJECT_ID(''dbo.stg_BrisbHospRegDeaths'') IS NOT NULL 
            Truncate Table dbo.stg_BrisbHospRegDeaths",
        "PostCopySQL": "",
        "MergeSQL": "",
        "AutoGenerateMerge": "True"
    }
}
', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-4, N'Generate Tasks for AwSample Extract to Data Lake', 8, 5, 4, 1, 3, 1, 0, N'SH IR', N'  {
  "TaskMasterName": "AwSample {@TableSchema@}.{@TableName@} Extract to Data Lake",
  "TaskTypeId": 3,
  "TaskGroupId": 2,
  "ScheduleMasterId": 2,
  "SourceSystemId": 1,
  "TargetSystemId": 3,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
      "Type": "Table",
      "IncrementalType": "Watermark",
      "ChunkField": "{@TablePrimaryKey}",
      "ChunkSize": "5000",
      "ExtractionSQL": "",
      "TableSchema": "{@TableSchema@}",
      "TableName": "{@TableName@}"
  },
  "Target": {
      "Type": "Parquet",
      "RelativePath": "AwSample/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
      "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
      "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
  },
  "ActiveYN": 0,
  "DependencyChainTag": "{@TableSchema@}.{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-5, N'Generate Tasks for AwSample Data Lake to SQL', 8, 5, 4, 1, 3, 1, 0, N'SH IR', N'  {
  "TaskMasterName": "AwSample {@TableSchema@}.{@TableName@} Data Lake to SQL",
  "TaskTypeId": 1,
  "TaskGroupId": 4,
  "ScheduleMasterId": 2,
  "SourceSystemId": 3,
  "TargetSystemId": 2,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
     "Type": "Parquet",
       "RelativePath": "AwSample/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
       "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
       "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
   },
   "Target": {
     "Type": "Table",
     "TableSchema": "{@TableSchema@}",
     "TableName": "{@TableName@}",
     "StagingTableSchema": "{@TableSchema@}",
     "StagingTableName": "stg_{@TableName@}",
     "AutoCreateTable": "True",
     "PreCopySQL": "IF OBJECT_ID(''{@TableSchema@}.stg_{@TableName@}'') IS NOT NULL \r\n Truncate Table {@TableSchema@}.stg_{@TableName@}",
     "PostCopySQL": "",
     "MergeSQL": "",
     "AutoGenerateMerge": "True"    
   },
  "ActiveYN": 1,
  "DependencyChainTag": "{@TableSchema@}.{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-6, N'Generate Tasks for AwSample Extract to ADLS', 8, 5, 4, 1, 4, 1, 0, N'SH IR', N'  {
  "TaskMasterName": "AwSample {@TableSchema@}.{@TableName@} Extract to ADLS",
  "TaskTypeId": 3,
  "TaskGroupId": 2,
  "ScheduleMasterId": 2,
  "SourceSystemId": 1,
  "TargetSystemId": 4,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
      "Type": "Table",
      "IncrementalType": "Full",
      "ExtractionSQL": "",
      "TableSchema": "{@TableSchema@}",
      "TableName": "{@TableName@}"
  },
  "Target": {
      "Type": "Parquet",
      "RelativePath": "AwSample/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
      "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
      "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
  },
  "ActiveYN": 1,
  "DependencyChainTag": "{@TableSchema@}.adls_{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-7, N'Generate Tasks for AwSample ADLS to SQL', 8, 5, 4, 1, 4, 1, 0, N'SH IR', N'  {
  "TaskMasterName": "AwSample {@TableSchema@}.{@TableName@} ADLS to SQL",
  "TaskTypeId": 1,
  "TaskGroupId": 4,
  "ScheduleMasterId": 2,
  "SourceSystemId": 4,
  "TargetSystemId": 2,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
     "Type": "Parquet",
       "RelativePath": "AwSample/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
       "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
       "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
   },
   "Target": {
     "Type": "Table",
     "TableSchema": "{@TableSchema@}",
     "TableName": "adls_{@TableName@}",
     "StagingTableSchema": "{@TableSchema@}",
     "StagingTableName": "stg_adls_{@TableName@}",
     "AutoCreateTable": "True",
     "PreCopySQL": "IF OBJECT_ID(''{@TableSchema@}.stg_adls_{@TableName@}'') IS NOT NULL \r\n Truncate Table {@TableSchema@}.stg_adls_{@TableName@}",
     "PostCopySQL": "",
     "MergeSQL": "",
     "AutoGenerateMerge": "True"    
   },
  "ActiveYN": 1,
  "DependencyChainTag": "{@TableSchema@}.adls_{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-8, N'Generate Tasks for AdventureWorks2017 OnPrem Extract to Data Lake', 8, 5, 4, 6, 3, 1, 0, N'OnP SH IR', N'  {
  "TaskMasterName": "AdventureWorks2017 {@TableSchema@}.{@TableName@} Extract to Data Lake",
  "TaskTypeId": 3,
  "TaskGroupId": 3,
  "ScheduleMasterId": 2,
  "SourceSystemId": 6,
  "TargetSystemId": 3,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "OnP SH IR",
  "Source": {
      "Type": "Table",
      "IncrementalType": "Full",
      "ExtractionSQL": "",
      "TableSchema": "{@TableSchema@}",
      "TableName": "{@TableName@}"
  },
  "Target": {
      "Type": "Parquet",
      "RelativePath": "AdventureWorks2017/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
      "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
      "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
  },
  "ActiveYN": 1,
  "DependencyChainTag": "{@TableSchema@}.{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-9, N'Generate Tasks for AdventureWorks2017 Data Lake to SQL', 8, 5, 4, 6, 3, 1, 0, N'OnP SH IR', N'  {
  "TaskMasterName": "AdventureWorks2017 {@TableSchema@}.{@TableName@} Data Lake to SQL",
  "TaskTypeId": 1,
  "TaskGroupId": 6,
  "ScheduleMasterId": 2,
  "SourceSystemId": 3,
  "TargetSystemId": 2,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
     "Type": "Parquet",
       "RelativePath": "AdventureWorks2017/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
       "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
       "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
   },
   "Target": {
     "Type": "Table",
     "TableSchema": "{@TableSchema@}",
     "TableName": "{@TableName@}",
     "StagingTableSchema": "{@TableSchema@}",
     "StagingTableName": "stg_{@TableName@}",
     "AutoCreateTable": "True",
     "PreCopySQL": "IF OBJECT_ID(''{@TableSchema@}.stg_{@TableName@}'') IS NOT NULL \r\n Truncate Table {@TableSchema@}.stg_{@TableName@}",
     "PostCopySQL": "",
     "MergeSQL": "",
     "AutoGenerateMerge": "True"    
   },
  "ActiveYN": 1,
  "DependencyChainTag": "{@TableSchema@}.{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-10, N'AwSample SalesLT.Customer Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
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
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-11, N'AwSample SalesLT.ProductModel Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductModel"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModel/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModel.parquet",
    "SchemaFileName": "SalesLT.ProductModel.json"
  }
}', 0, N'SalesLT.ProductModel', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-12, N'AwSample SalesLT.ProductDescription Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductDescription"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductDescription.json"
  }
}', 0, N'SalesLT.ProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-13, N'AwSample SalesLT.Product Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "Product"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Product/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Product.parquet",
    "SchemaFileName": "SalesLT.Product.json"
  }
}', 0, N'SalesLT.Product', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-14, N'AwSample SalesLT.ProductModelProductDescription Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductModelProductDescription"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModelProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModelProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductModelProductDescription.json"
  }
}', 0, N'SalesLT.ProductModelProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-15, N'AwSample SalesLT.ProductCategory Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductCategory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductCategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductCategory.parquet",
    "SchemaFileName": "SalesLT.ProductCategory.json"
  }
}', 0, N'SalesLT.ProductCategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-16, N'AwSample dbo.BuildVersion Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "BuildVersion"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/BuildVersion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.BuildVersion.parquet",
    "SchemaFileName": "dbo.BuildVersion.json"
  }
}', 0, N'dbo.BuildVersion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-17, N'AwSample dbo.ErrorLog Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
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
}', 0, N'dbo.ErrorLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-18, N'AwSample SalesLT.Address Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "Address"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Address/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Address.parquet",
    "SchemaFileName": "SalesLT.Address.json"
  }
}', 0, N'SalesLT.Address', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-19, N'AwSample SalesLT.CustomerAddress Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "CustomerAddress"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerAddress/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerAddress.parquet",
    "SchemaFileName": "SalesLT.CustomerAddress.json"
  }
}', 0, N'SalesLT.CustomerAddress', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-20, N'AwSample SalesLT.SalesOrderDetail Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "SalesOrderDetail"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderDetail.parquet",
    "SchemaFileName": "SalesLT.SalesOrderDetail.json"
  }
}', 0, N'SalesLT.SalesOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-21, N'AwSample SalesLT.SalesOrderHeader Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "SalesOrderHeader"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderHeader.parquet",
    "SchemaFileName": "SalesLT.SalesOrderHeader.json"
  }
}', 0, N'SalesLT.SalesOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-22, N'AwSample SalesLT.Customer Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Customer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Customer.parquet",
    "SchemaFileName": "SalesLT.Customer.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "Customer",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_Customer",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_Customer'') IS NOT NULL \r\n Truncate Table SalesLT.stg_Customer",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.Customer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-23, N'AwSample SalesLT.ProductModel Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModel/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModel.parquet",
    "SchemaFileName": "SalesLT.ProductModel.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "ProductModel",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_ProductModel",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_ProductModel'') IS NOT NULL \r\n Truncate Table SalesLT.stg_ProductModel",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.ProductModel', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-24, N'AwSample SalesLT.ProductDescription Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductDescription.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "ProductDescription",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_ProductDescription",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_ProductDescription'') IS NOT NULL \r\n Truncate Table SalesLT.stg_ProductDescription",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.ProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-25, N'AwSample SalesLT.Product Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Product/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Product.parquet",
    "SchemaFileName": "SalesLT.Product.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "Product",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_Product",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_Product'') IS NOT NULL \r\n Truncate Table SalesLT.stg_Product",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.Product', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-26, N'AwSample SalesLT.ProductModelProductDescription Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModelProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModelProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductModelProductDescription.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "ProductModelProductDescription",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_ProductModelProductDescription",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_ProductModelProductDescription'') IS NOT NULL \r\n Truncate Table SalesLT.stg_ProductModelProductDescription",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.ProductModelProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-27, N'AwSample SalesLT.ProductCategory Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductCategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductCategory.parquet",
    "SchemaFileName": "SalesLT.ProductCategory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "ProductCategory",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_ProductCategory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_ProductCategory'') IS NOT NULL \r\n Truncate Table SalesLT.stg_ProductCategory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.ProductCategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-28, N'AwSample dbo.BuildVersion Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/BuildVersion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.BuildVersion.parquet",
    "SchemaFileName": "dbo.BuildVersion.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "BuildVersion",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_BuildVersion",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_BuildVersion'') IS NOT NULL \r\n Truncate Table dbo.stg_BuildVersion",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.BuildVersion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-29, N'AwSample dbo.ErrorLog Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/ErrorLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.ErrorLog.parquet",
    "SchemaFileName": "dbo.ErrorLog.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "ErrorLog",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_ErrorLog",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_ErrorLog'') IS NOT NULL \r\n Truncate Table dbo.stg_ErrorLog",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.ErrorLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-30, N'AwSample SalesLT.Address Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Address/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Address.parquet",
    "SchemaFileName": "SalesLT.Address.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "Address",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_Address",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_Address'') IS NOT NULL \r\n Truncate Table SalesLT.stg_Address",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.Address', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-31, N'AwSample SalesLT.CustomerAddress Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerAddress/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerAddress.parquet",
    "SchemaFileName": "SalesLT.CustomerAddress.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "CustomerAddress",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_CustomerAddress",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_CustomerAddress'') IS NOT NULL \r\n Truncate Table SalesLT.stg_CustomerAddress",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.CustomerAddress', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-32, N'AwSample SalesLT.SalesOrderDetail Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderDetail.parquet",
    "SchemaFileName": "SalesLT.SalesOrderDetail.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "SalesOrderDetail",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_SalesOrderDetail",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_SalesOrderDetail'') IS NOT NULL \r\n Truncate Table SalesLT.stg_SalesOrderDetail",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.SalesOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-33, N'AwSample SalesLT.SalesOrderHeader Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderHeader.parquet",
    "SchemaFileName": "SalesLT.SalesOrderHeader.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "SalesOrderHeader",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_SalesOrderHeader",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_SalesOrderHeader'') IS NOT NULL \r\n Truncate Table SalesLT.stg_SalesOrderHeader",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.SalesOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-34, N'AwSample SalesLT.Customer Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
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
}', 0, N'SalesLT.adls_Customer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-35, N'AwSample SalesLT.ProductModel Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductModel"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModel/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModel.parquet",
    "SchemaFileName": "SalesLT.ProductModel.json"
  }
}', 0, N'SalesLT.adls_ProductModel', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-36, N'AwSample SalesLT.ProductDescription Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductDescription"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductDescription.json"
  }
}', 0, N'SalesLT.adls_ProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-37, N'AwSample SalesLT.Product Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "Product"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Product/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Product.parquet",
    "SchemaFileName": "SalesLT.Product.json"
  }
}', 0, N'SalesLT.adls_Product', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-38, N'AwSample SalesLT.ProductModelProductDescription Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductModelProductDescription"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModelProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModelProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductModelProductDescription.json"
  }
}', 0, N'SalesLT.adls_ProductModelProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-39, N'AwSample SalesLT.ProductCategory Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "ProductCategory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductCategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductCategory.parquet",
    "SchemaFileName": "SalesLT.ProductCategory.json"
  }
}', 0, N'SalesLT.adls_ProductCategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-40, N'AwSample dbo.BuildVersion Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "BuildVersion"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/BuildVersion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.BuildVersion.parquet",
    "SchemaFileName": "dbo.BuildVersion.json"
  }
}', 0, N'dbo.adls_BuildVersion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-41, N'AwSample dbo.ErrorLog Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
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
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-42, N'AwSample SalesLT.Address Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "Address"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Address/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Address.parquet",
    "SchemaFileName": "SalesLT.Address.json"
  }
}', 0, N'SalesLT.adls_Address', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-43, N'AwSample SalesLT.CustomerAddress Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "CustomerAddress"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerAddress/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerAddress.parquet",
    "SchemaFileName": "SalesLT.CustomerAddress.json"
  }
}', 0, N'SalesLT.adls_CustomerAddress', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-44, N'AwSample SalesLT.SalesOrderDetail Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "SalesOrderDetail"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderDetail.parquet",
    "SchemaFileName": "SalesLT.SalesOrderDetail.json"
  }
}', 0, N'SalesLT.adls_SalesOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-45, N'AwSample SalesLT.SalesOrderHeader Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "SalesOrderHeader"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderHeader.parquet",
    "SchemaFileName": "SalesLT.SalesOrderHeader.json"
  }
}', 0, N'SalesLT.adls_SalesOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-46, N'AwSample SalesLT.Customer ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Customer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Customer.parquet",
    "SchemaFileName": "SalesLT.Customer.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_Customer",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_Customer",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_Customer'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_Customer",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_Customer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-47, N'AwSample SalesLT.ProductModel ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModel/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModel.parquet",
    "SchemaFileName": "SalesLT.ProductModel.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_ProductModel",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_ProductModel",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_ProductModel'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_ProductModel",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_ProductModel', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-48, N'AwSample SalesLT.ProductDescription ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductDescription.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_ProductDescription",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_ProductDescription",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_ProductDescription'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_ProductDescription",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_ProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-49, N'AwSample SalesLT.Product ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Product/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Product.parquet",
    "SchemaFileName": "SalesLT.Product.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_Product",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_Product",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_Product'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_Product",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_Product', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-50, N'AwSample SalesLT.ProductModelProductDescription ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductModelProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductModelProductDescription.parquet",
    "SchemaFileName": "SalesLT.ProductModelProductDescription.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_ProductModelProductDescription",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_ProductModelProductDescription",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_ProductModelProductDescription'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_ProductModelProductDescription",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_ProductModelProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-51, N'AwSample SalesLT.ProductCategory ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/ProductCategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.ProductCategory.parquet",
    "SchemaFileName": "SalesLT.ProductCategory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_ProductCategory",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_ProductCategory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_ProductCategory'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_ProductCategory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_ProductCategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-52, N'AwSample dbo.BuildVersion ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/BuildVersion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.BuildVersion.parquet",
    "SchemaFileName": "dbo.BuildVersion.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "adls_BuildVersion",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_adls_BuildVersion",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_adls_BuildVersion'') IS NOT NULL \r\n Truncate Table dbo.stg_adls_BuildVersion",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.adls_BuildVersion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-53, N'AwSample dbo.ErrorLog ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/dbo/ErrorLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.ErrorLog.parquet",
    "SchemaFileName": "dbo.ErrorLog.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "adls_ErrorLog",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_adls_ErrorLog",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_adls_ErrorLog'') IS NOT NULL \r\n Truncate Table dbo.stg_adls_ErrorLog",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.adls_ErrorLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-54, N'AwSample SalesLT.Address ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/Address/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.Address.parquet",
    "SchemaFileName": "SalesLT.Address.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_Address",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_Address",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_Address'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_Address",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_Address', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-55, N'AwSample SalesLT.CustomerAddress ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerAddress/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerAddress.parquet",
    "SchemaFileName": "SalesLT.CustomerAddress.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_CustomerAddress",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_CustomerAddress",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_CustomerAddress'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_CustomerAddress",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_CustomerAddress', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-56, N'AwSample SalesLT.SalesOrderDetail ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderDetail.parquet",
    "SchemaFileName": "SalesLT.SalesOrderDetail.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_SalesOrderDetail",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_SalesOrderDetail",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_SalesOrderDetail'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_SalesOrderDetail",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_SalesOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-57, N'AwSample SalesLT.SalesOrderHeader ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/SalesOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.SalesOrderHeader.parquet",
    "SchemaFileName": "SalesLT.SalesOrderHeader.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_SalesOrderHeader",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_SalesOrderHeader",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_SalesOrderHeader'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_SalesOrderHeader",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_SalesOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-59, N'AdventureWorks2017 Sales.SalesOrderHeaderSalesReason Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesOrderHeaderSalesReason/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesOrderHeaderSalesReason.parquet",
    "SchemaFileName": "Sales.SalesOrderHeaderSalesReason.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesOrderHeaderSalesReason",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesOrderHeaderSalesReason",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesOrderHeaderSalesReason'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesOrderHeaderSalesReason",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesOrderHeaderSalesReason', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-60, N'AdventureWorks2017 Sales.SalesPerson Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesPerson/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesPerson.parquet",
    "SchemaFileName": "Sales.SalesPerson.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesPerson",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesPerson",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesPerson'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesPerson",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesPerson', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-61, N'AdventureWorks2017 Production.Illustration Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Illustration/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Illustration.parquet",
    "SchemaFileName": "Production.Illustration.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "Illustration",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_Illustration",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_Illustration'') IS NOT NULL \r\n Truncate Table Production.stg_Illustration",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.Illustration', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-63, N'AdventureWorks2017 Production.Location Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Location/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Location.parquet",
    "SchemaFileName": "Production.Location.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "Location",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_Location",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_Location'') IS NOT NULL \r\n Truncate Table Production.stg_Location",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.Location', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-64, N'AdventureWorks2017 Person.Password Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/Password/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.Password.parquet",
    "SchemaFileName": "Person.Password.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "Password",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_Password",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_Password'') IS NOT NULL \r\n Truncate Table Person.stg_Password",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.Password', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-65, N'AdventureWorks2017 Sales.SalesPersonQuotaHistory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesPersonQuotaHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesPersonQuotaHistory.parquet",
    "SchemaFileName": "Sales.SalesPersonQuotaHistory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesPersonQuotaHistory",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesPersonQuotaHistory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesPersonQuotaHistory'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesPersonQuotaHistory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesPersonQuotaHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-66, N'AdventureWorks2017 Person.Person Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/Person/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.Person.parquet",
    "SchemaFileName": "Person.Person.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "Person",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_Person",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_Person'') IS NOT NULL \r\n Truncate Table Person.stg_Person",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.Person', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-67, N'AdventureWorks2017 Sales.SalesReason Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesReason/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesReason.parquet",
    "SchemaFileName": "Sales.SalesReason.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesReason",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesReason",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesReason'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesReason",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesReason', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-68, N'AdventureWorks2017 Sales.SalesTaxRate Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesTaxRate/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesTaxRate.parquet",
    "SchemaFileName": "Sales.SalesTaxRate.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesTaxRate",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesTaxRate",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesTaxRate'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesTaxRate",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesTaxRate', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-69, N'AdventureWorks2017 Sales.PersonCreditCard Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/PersonCreditCard/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.PersonCreditCard.parquet",
    "SchemaFileName": "Sales.PersonCreditCard.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "PersonCreditCard",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_PersonCreditCard",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_PersonCreditCard'') IS NOT NULL \r\n Truncate Table Sales.stg_PersonCreditCard",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.PersonCreditCard', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-70, N'AdventureWorks2017 Person.PersonPhone Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/PersonPhone/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.PersonPhone.parquet",
    "SchemaFileName": "Person.PersonPhone.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "PersonPhone",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_PersonPhone",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_PersonPhone'') IS NOT NULL \r\n Truncate Table Person.stg_PersonPhone",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.PersonPhone', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-71, N'AdventureWorks2017 Sales.SalesTerritory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesTerritory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesTerritory.parquet",
    "SchemaFileName": "Sales.SalesTerritory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesTerritory",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesTerritory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesTerritory'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesTerritory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesTerritory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-72, N'AdventureWorks2017 Person.PhoneNumberType Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/PhoneNumberType/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.PhoneNumberType.parquet",
    "SchemaFileName": "Person.PhoneNumberType.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "PhoneNumberType",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_PhoneNumberType",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_PhoneNumberType'') IS NOT NULL \r\n Truncate Table Person.stg_PhoneNumberType",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.PhoneNumberType', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-73, N'AdventureWorks2017 Production.Product Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Product/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Product.parquet",
    "SchemaFileName": "Production.Product.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "Product",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_Product",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_Product'') IS NOT NULL \r\n Truncate Table Production.stg_Product",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.Product', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-74, N'AdventureWorks2017 Sales.SalesTerritoryHistory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesTerritoryHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesTerritoryHistory.parquet",
    "SchemaFileName": "Sales.SalesTerritoryHistory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesTerritoryHistory",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesTerritoryHistory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesTerritoryHistory'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesTerritoryHistory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesTerritoryHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-75, N'AdventureWorks2017 Production.ScrapReason Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ScrapReason/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ScrapReason.parquet",
    "SchemaFileName": "Production.ScrapReason.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ScrapReason",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ScrapReason",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ScrapReason'') IS NOT NULL \r\n Truncate Table Production.stg_ScrapReason",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ScrapReason', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-77, N'AdventureWorks2017 Production.ProductCategory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductCategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductCategory.parquet",
    "SchemaFileName": "Production.ProductCategory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductCategory",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductCategory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductCategory'') IS NOT NULL \r\n Truncate Table Production.stg_ProductCategory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductCategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-78, N'AdventureWorks2017 Purchasing.ShipMethod Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/ShipMethod/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.ShipMethod.parquet",
    "SchemaFileName": "Purchasing.ShipMethod.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Purchasing",
    "TableName": "ShipMethod",
    "StagingTableSchema": "Purchasing",
    "StagingTableName": "stg_ShipMethod",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Purchasing.stg_ShipMethod'') IS NOT NULL \r\n Truncate Table Purchasing.stg_ShipMethod",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Purchasing.ShipMethod', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-79, N'AdventureWorks2017 Production.ProductCostHistory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductCostHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductCostHistory.parquet",
    "SchemaFileName": "Production.ProductCostHistory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductCostHistory",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductCostHistory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductCostHistory'') IS NOT NULL \r\n Truncate Table Production.stg_ProductCostHistory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductCostHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-80, N'AdventureWorks2017 Production.ProductDescription Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductDescription.parquet",
    "SchemaFileName": "Production.ProductDescription.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductDescription",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductDescription",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductDescription'') IS NOT NULL \r\n Truncate Table Production.stg_ProductDescription",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-81, N'AdventureWorks2017 Sales.ShoppingCartItem Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/ShoppingCartItem/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.ShoppingCartItem.parquet",
    "SchemaFileName": "Sales.ShoppingCartItem.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "ShoppingCartItem",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_ShoppingCartItem",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_ShoppingCartItem'') IS NOT NULL \r\n Truncate Table Sales.stg_ShoppingCartItem",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.ShoppingCartItem', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-83, N'AdventureWorks2017 dbo.DatabaseLog Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/dbo/DatabaseLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.DatabaseLog.parquet",
    "SchemaFileName": "dbo.DatabaseLog.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "DatabaseLog",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_DatabaseLog",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_DatabaseLog'') IS NOT NULL \r\n Truncate Table dbo.stg_DatabaseLog",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.DatabaseLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-84, N'AdventureWorks2017 Production.ProductInventory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductInventory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductInventory.parquet",
    "SchemaFileName": "Production.ProductInventory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductInventory",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductInventory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductInventory'') IS NOT NULL \r\n Truncate Table Production.stg_ProductInventory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductInventory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-85, N'AdventureWorks2017 Sales.SpecialOffer Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SpecialOffer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SpecialOffer.parquet",
    "SchemaFileName": "Sales.SpecialOffer.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SpecialOffer",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SpecialOffer",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SpecialOffer'') IS NOT NULL \r\n Truncate Table Sales.stg_SpecialOffer",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SpecialOffer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-86, N'AdventureWorks2017 dbo.ErrorLog Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/dbo/ErrorLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.ErrorLog.parquet",
    "SchemaFileName": "dbo.ErrorLog.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "ErrorLog",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_ErrorLog",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_ErrorLog'') IS NOT NULL \r\n Truncate Table dbo.stg_ErrorLog",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.ErrorLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-87, N'AdventureWorks2017 Production.ProductListPriceHistory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductListPriceHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductListPriceHistory.parquet",
    "SchemaFileName": "Production.ProductListPriceHistory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductListPriceHistory",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductListPriceHistory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductListPriceHistory'') IS NOT NULL \r\n Truncate Table Production.stg_ProductListPriceHistory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductListPriceHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-89, N'AdventureWorks2017 Sales.SpecialOfferProduct Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SpecialOfferProduct/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SpecialOfferProduct.parquet",
    "SchemaFileName": "Sales.SpecialOfferProduct.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SpecialOfferProduct",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SpecialOfferProduct",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SpecialOfferProduct'') IS NOT NULL \r\n Truncate Table Sales.stg_SpecialOfferProduct",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SpecialOfferProduct', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-90, N'AdventureWorks2017 Production.ProductModel Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductModel/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductModel.parquet",
    "SchemaFileName": "Production.ProductModel.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductModel",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductModel",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductModel'') IS NOT NULL \r\n Truncate Table Production.stg_ProductModel",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductModel', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-92, N'AdventureWorks2017 Person.StateProvince Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/StateProvince/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.StateProvince.parquet",
    "SchemaFileName": "Person.StateProvince.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "StateProvince",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_StateProvince",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_StateProvince'') IS NOT NULL \r\n Truncate Table Person.stg_StateProvince",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.StateProvince', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-93, N'AdventureWorks2017 Production.ProductModelIllustration Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductModelIllustration/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductModelIllustration.parquet",
    "SchemaFileName": "Production.ProductModelIllustration.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductModelIllustration",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductModelIllustration",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductModelIllustration'') IS NOT NULL \r\n Truncate Table Production.stg_ProductModelIllustration",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductModelIllustration', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-94, N'AdventureWorks2017 dbo.AWBuildVersion Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/dbo/AWBuildVersion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.AWBuildVersion.parquet",
    "SchemaFileName": "dbo.AWBuildVersion.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "dbo",
    "TableName": "AWBuildVersion",
    "StagingTableSchema": "dbo",
    "StagingTableName": "stg_AWBuildVersion",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''dbo.stg_AWBuildVersion'') IS NOT NULL \r\n Truncate Table dbo.stg_AWBuildVersion",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'dbo.AWBuildVersion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-95, N'AdventureWorks2017 Production.ProductModelProductDescriptionCulture Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductModelProductDescriptionCulture/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductModelProductDescriptionCulture.parquet",
    "SchemaFileName": "Production.ProductModelProductDescriptionCulture.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductModelProductDescriptionCulture",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductModelProductDescriptionCulture",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductModelProductDescriptionCulture'') IS NOT NULL \r\n Truncate Table Production.stg_ProductModelProductDescriptionCulture",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductModelProductDescriptionCulture', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-96, N'AdventureWorks2017 Production.BillOfMaterials Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/BillOfMaterials/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.BillOfMaterials.parquet",
    "SchemaFileName": "Production.BillOfMaterials.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "BillOfMaterials",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_BillOfMaterials",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_BillOfMaterials'') IS NOT NULL \r\n Truncate Table Production.stg_BillOfMaterials",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.BillOfMaterials', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-97, N'AdventureWorks2017 Sales.Store Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/Store/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.Store.parquet",
    "SchemaFileName": "Sales.Store.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "Store",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_Store",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_Store'') IS NOT NULL \r\n Truncate Table Sales.stg_Store",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.Store', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-98, N'AdventureWorks2017 Production.ProductPhoto Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductPhoto/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductPhoto.parquet",
    "SchemaFileName": "Production.ProductPhoto.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductPhoto",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductPhoto",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductPhoto'') IS NOT NULL \r\n Truncate Table Production.stg_ProductPhoto",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductPhoto', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-99, N'AdventureWorks2017 Production.ProductProductPhoto Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductProductPhoto/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductProductPhoto.parquet",
    "SchemaFileName": "Production.ProductProductPhoto.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductProductPhoto",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductProductPhoto",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductProductPhoto'') IS NOT NULL \r\n Truncate Table Production.stg_ProductProductPhoto",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductProductPhoto', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-100, N'AdventureWorks2017 Production.TransactionHistory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/TransactionHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.TransactionHistory.parquet",
    "SchemaFileName": "Production.TransactionHistory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "TransactionHistory",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_TransactionHistory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_TransactionHistory'') IS NOT NULL \r\n Truncate Table Production.stg_TransactionHistory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.TransactionHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-101, N'AdventureWorks2017 Production.ProductReview Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductReview/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductReview.parquet",
    "SchemaFileName": "Production.ProductReview.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductReview",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductReview",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductReview'') IS NOT NULL \r\n Truncate Table Production.stg_ProductReview",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductReview', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-102, N'AdventureWorks2017 Person.BusinessEntity Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/BusinessEntity/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.BusinessEntity.parquet",
    "SchemaFileName": "Person.BusinessEntity.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "BusinessEntity",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_BusinessEntity",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_BusinessEntity'') IS NOT NULL \r\n Truncate Table Person.stg_BusinessEntity",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.BusinessEntity', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-103, N'AdventureWorks2017 Production.TransactionHistoryArchive Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/TransactionHistoryArchive/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.TransactionHistoryArchive.parquet",
    "SchemaFileName": "Production.TransactionHistoryArchive.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "TransactionHistoryArchive",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_TransactionHistoryArchive",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_TransactionHistoryArchive'') IS NOT NULL \r\n Truncate Table Production.stg_TransactionHistoryArchive",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.TransactionHistoryArchive', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-104, N'AdventureWorks2017 Production.ProductSubcategory Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductSubcategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductSubcategory.parquet",
    "SchemaFileName": "Production.ProductSubcategory.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "ProductSubcategory",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_ProductSubcategory",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_ProductSubcategory'') IS NOT NULL \r\n Truncate Table Production.stg_ProductSubcategory",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.ProductSubcategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-106, N'AdventureWorks2017 Purchasing.ProductVendor Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/ProductVendor/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.ProductVendor.parquet",
    "SchemaFileName": "Purchasing.ProductVendor.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Purchasing",
    "TableName": "ProductVendor",
    "StagingTableSchema": "Purchasing",
    "StagingTableName": "stg_ProductVendor",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Purchasing.stg_ProductVendor'') IS NOT NULL \r\n Truncate Table Purchasing.stg_ProductVendor",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Purchasing.ProductVendor', 1)
GO
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-107, N'AdventureWorks2017 Person.BusinessEntityContact Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/BusinessEntityContact/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.BusinessEntityContact.parquet",
    "SchemaFileName": "Person.BusinessEntityContact.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "BusinessEntityContact",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_BusinessEntityContact",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_BusinessEntityContact'') IS NOT NULL \r\n Truncate Table Person.stg_BusinessEntityContact",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.BusinessEntityContact', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-108, N'AdventureWorks2017 Production.UnitMeasure Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/UnitMeasure/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.UnitMeasure.parquet",
    "SchemaFileName": "Production.UnitMeasure.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "UnitMeasure",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_UnitMeasure",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_UnitMeasure'') IS NOT NULL \r\n Truncate Table Production.stg_UnitMeasure",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.UnitMeasure', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-109, N'AdventureWorks2017 Purchasing.Vendor Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/Vendor/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.Vendor.parquet",
    "SchemaFileName": "Purchasing.Vendor.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Purchasing",
    "TableName": "Vendor",
    "StagingTableSchema": "Purchasing",
    "StagingTableName": "stg_Vendor",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Purchasing.stg_Vendor'') IS NOT NULL \r\n Truncate Table Purchasing.stg_Vendor",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Purchasing.Vendor', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-110, N'AdventureWorks2017 Person.ContactType Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/ContactType/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.ContactType.parquet",
    "SchemaFileName": "Person.ContactType.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "ContactType",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_ContactType",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_ContactType'') IS NOT NULL \r\n Truncate Table Person.stg_ContactType",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.ContactType', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-111, N'AdventureWorks2017 Sales.CountryRegionCurrency Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/CountryRegionCurrency/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.CountryRegionCurrency.parquet",
    "SchemaFileName": "Sales.CountryRegionCurrency.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "CountryRegionCurrency",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_CountryRegionCurrency",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_CountryRegionCurrency'') IS NOT NULL \r\n Truncate Table Sales.stg_CountryRegionCurrency",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.CountryRegionCurrency', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-112, N'AdventureWorks2017 Person.CountryRegion Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/CountryRegion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.CountryRegion.parquet",
    "SchemaFileName": "Person.CountryRegion.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Person",
    "TableName": "CountryRegion",
    "StagingTableSchema": "Person",
    "StagingTableName": "stg_CountryRegion",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Person.stg_CountryRegion'') IS NOT NULL \r\n Truncate Table Person.stg_CountryRegion",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Person.CountryRegion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-113, N'AdventureWorks2017 Production.WorkOrder Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/WorkOrder/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.WorkOrder.parquet",
    "SchemaFileName": "Production.WorkOrder.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "WorkOrder",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_WorkOrder",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_WorkOrder'') IS NOT NULL \r\n Truncate Table Production.stg_WorkOrder",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.WorkOrder', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-114, N'AdventureWorks2017 Purchasing.PurchaseOrderDetail Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/PurchaseOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.PurchaseOrderDetail.parquet",
    "SchemaFileName": "Purchasing.PurchaseOrderDetail.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Purchasing",
    "TableName": "PurchaseOrderDetail",
    "StagingTableSchema": "Purchasing",
    "StagingTableName": "stg_PurchaseOrderDetail",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Purchasing.stg_PurchaseOrderDetail'') IS NOT NULL \r\n Truncate Table Purchasing.stg_PurchaseOrderDetail",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Purchasing.PurchaseOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-115, N'AdventureWorks2017 Sales.CreditCard Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/CreditCard/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.CreditCard.parquet",
    "SchemaFileName": "Sales.CreditCard.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "CreditCard",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_CreditCard",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_CreditCard'') IS NOT NULL \r\n Truncate Table Sales.stg_CreditCard",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.CreditCard', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-116, N'AdventureWorks2017 Production.Culture Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Culture/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Culture.parquet",
    "SchemaFileName": "Production.Culture.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "Culture",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_Culture",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_Culture'') IS NOT NULL \r\n Truncate Table Production.stg_Culture",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.Culture', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-117, N'AdventureWorks2017 Production.WorkOrderRouting Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/WorkOrderRouting/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.WorkOrderRouting.parquet",
    "SchemaFileName": "Production.WorkOrderRouting.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Production",
    "TableName": "WorkOrderRouting",
    "StagingTableSchema": "Production",
    "StagingTableName": "stg_WorkOrderRouting",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Production.stg_WorkOrderRouting'') IS NOT NULL \r\n Truncate Table Production.stg_WorkOrderRouting",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Production.WorkOrderRouting', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-118, N'AdventureWorks2017 Sales.Currency Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/Currency/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.Currency.parquet",
    "SchemaFileName": "Sales.Currency.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "Currency",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_Currency",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_Currency'') IS NOT NULL \r\n Truncate Table Sales.stg_Currency",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.Currency', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-119, N'AdventureWorks2017 Purchasing.PurchaseOrderHeader Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/PurchaseOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.PurchaseOrderHeader.parquet",
    "SchemaFileName": "Purchasing.PurchaseOrderHeader.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Purchasing",
    "TableName": "PurchaseOrderHeader",
    "StagingTableSchema": "Purchasing",
    "StagingTableName": "stg_PurchaseOrderHeader",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Purchasing.stg_PurchaseOrderHeader'') IS NOT NULL \r\n Truncate Table Purchasing.stg_PurchaseOrderHeader",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Purchasing.PurchaseOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-120, N'AdventureWorks2017 Sales.CurrencyRate Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/CurrencyRate/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.CurrencyRate.parquet",
    "SchemaFileName": "Sales.CurrencyRate.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "CurrencyRate",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_CurrencyRate",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_CurrencyRate'') IS NOT NULL \r\n Truncate Table Sales.stg_CurrencyRate",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.CurrencyRate', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-121, N'AdventureWorks2017 Sales.Customer Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/Customer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.Customer.parquet",
    "SchemaFileName": "Sales.Customer.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "Customer",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_Customer",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_Customer'') IS NOT NULL \r\n Truncate Table Sales.stg_Customer",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.Customer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-122, N'AdventureWorks2017 HumanResources.Department Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/HumanResources/Department/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "HumanResources.Department.parquet",
    "SchemaFileName": "HumanResources.Department.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "HumanResources",
    "TableName": "Department",
    "StagingTableSchema": "HumanResources",
    "StagingTableName": "stg_Department",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''HumanResources.stg_Department'') IS NOT NULL \r\n Truncate Table HumanResources.stg_Department",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'HumanResources.Department', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-124, N'AdventureWorks2017 Sales.SalesOrderDetail Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesOrderDetail.parquet",
    "SchemaFileName": "Sales.SalesOrderDetail.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesOrderDetail",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesOrderDetail",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesOrderDetail'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesOrderDetail",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-127, N'AdventureWorks2017 Sales.SalesOrderHeader Data Lake to SQL', 1, 6, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesOrderHeader.parquet",
    "SchemaFileName": "Sales.SalesOrderHeader.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "Sales",
    "TableName": "SalesOrderHeader",
    "StagingTableSchema": "Sales",
    "StagingTableName": "stg_SalesOrderHeader",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''Sales.stg_SalesOrderHeader'') IS NOT NULL \r\n Truncate Table Sales.stg_SalesOrderHeader",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'Sales.SalesOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-130, N'AdventureWorks2017 Sales.SalesOrderHeaderSalesReason Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesOrderHeaderSalesReason"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesOrderHeaderSalesReason/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesOrderHeaderSalesReason.parquet",
    "SchemaFileName": "Sales.SalesOrderHeaderSalesReason.json"
  }
}', 0, N'Sales.SalesOrderHeaderSalesReason', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-131, N'AdventureWorks2017 Sales.SalesPerson Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesPerson"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesPerson/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesPerson.parquet",
    "SchemaFileName": "Sales.SalesPerson.json"
  }
}', 0, N'Sales.SalesPerson', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-132, N'AdventureWorks2017 Production.Illustration Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "Illustration"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Illustration/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Illustration.parquet",
    "SchemaFileName": "Production.Illustration.json"
  }
}', 0, N'Production.Illustration', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-134, N'AdventureWorks2017 Production.Location Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "Location"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Location/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Location.parquet",
    "SchemaFileName": "Production.Location.json"
  }
}', 0, N'Production.Location', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-135, N'AdventureWorks2017 Person.Password Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "Password"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/Password/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.Password.parquet",
    "SchemaFileName": "Person.Password.json"
  }
}', 0, N'Person.Password', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-136, N'AdventureWorks2017 Sales.SalesPersonQuotaHistory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesPersonQuotaHistory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesPersonQuotaHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesPersonQuotaHistory.parquet",
    "SchemaFileName": "Sales.SalesPersonQuotaHistory.json"
  }
}', 0, N'Sales.SalesPersonQuotaHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-137, N'AdventureWorks2017 Person.Person Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "Person"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/Person/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.Person.parquet",
    "SchemaFileName": "Person.Person.json"
  }
}', 0, N'Person.Person', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-138, N'AdventureWorks2017 Sales.SalesReason Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesReason"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesReason/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesReason.parquet",
    "SchemaFileName": "Sales.SalesReason.json"
  }
}', 0, N'Sales.SalesReason', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-139, N'AdventureWorks2017 Sales.SalesTaxRate Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesTaxRate"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesTaxRate/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesTaxRate.parquet",
    "SchemaFileName": "Sales.SalesTaxRate.json"
  }
}', 0, N'Sales.SalesTaxRate', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-140, N'AdventureWorks2017 Sales.PersonCreditCard Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "PersonCreditCard"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/PersonCreditCard/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.PersonCreditCard.parquet",
    "SchemaFileName": "Sales.PersonCreditCard.json"
  }
}', 0, N'Sales.PersonCreditCard', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-141, N'AdventureWorks2017 Person.PersonPhone Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "PersonPhone"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/PersonPhone/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.PersonPhone.parquet",
    "SchemaFileName": "Person.PersonPhone.json"
  }
}', 0, N'Person.PersonPhone', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-142, N'AdventureWorks2017 Sales.SalesTerritory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesTerritory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesTerritory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesTerritory.parquet",
    "SchemaFileName": "Sales.SalesTerritory.json"
  }
}', 0, N'Sales.SalesTerritory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-143, N'AdventureWorks2017 Person.PhoneNumberType Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "PhoneNumberType"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/PhoneNumberType/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.PhoneNumberType.parquet",
    "SchemaFileName": "Person.PhoneNumberType.json"
  }
}', 0, N'Person.PhoneNumberType', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-144, N'AdventureWorks2017 Production.Product Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "Product"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Product/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Product.parquet",
    "SchemaFileName": "Production.Product.json"
  }
}', 0, N'Production.Product', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-145, N'AdventureWorks2017 Sales.SalesTerritoryHistory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesTerritoryHistory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesTerritoryHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesTerritoryHistory.parquet",
    "SchemaFileName": "Sales.SalesTerritoryHistory.json"
  }
}', 0, N'Sales.SalesTerritoryHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-146, N'AdventureWorks2017 Production.ScrapReason Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ScrapReason"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ScrapReason/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ScrapReason.parquet",
    "SchemaFileName": "Production.ScrapReason.json"
  }
}', 0, N'Production.ScrapReason', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-148, N'AdventureWorks2017 Production.ProductCategory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductCategory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductCategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductCategory.parquet",
    "SchemaFileName": "Production.ProductCategory.json"
  }
}', 0, N'Production.ProductCategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-149, N'AdventureWorks2017 Purchasing.ShipMethod Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Purchasing",
    "TableName": "ShipMethod"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/ShipMethod/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.ShipMethod.parquet",
    "SchemaFileName": "Purchasing.ShipMethod.json"
  }
}', 0, N'Purchasing.ShipMethod', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-150, N'AdventureWorks2017 Production.ProductCostHistory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductCostHistory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductCostHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductCostHistory.parquet",
    "SchemaFileName": "Production.ProductCostHistory.json"
  }
}', 0, N'Production.ProductCostHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-151, N'AdventureWorks2017 Production.ProductDescription Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductDescription"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductDescription/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductDescription.parquet",
    "SchemaFileName": "Production.ProductDescription.json"
  }
}', 0, N'Production.ProductDescription', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-152, N'AdventureWorks2017 Sales.ShoppingCartItem Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "ShoppingCartItem"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/ShoppingCartItem/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.ShoppingCartItem.parquet",
    "SchemaFileName": "Sales.ShoppingCartItem.json"
  }
}', 0, N'Sales.ShoppingCartItem', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-154, N'AdventureWorks2017 dbo.DatabaseLog Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "DatabaseLog"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/dbo/DatabaseLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.DatabaseLog.parquet",
    "SchemaFileName": "dbo.DatabaseLog.json"
  }
}', 0, N'dbo.DatabaseLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-155, N'AdventureWorks2017 Production.ProductInventory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductInventory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductInventory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductInventory.parquet",
    "SchemaFileName": "Production.ProductInventory.json"
  }
}', 0, N'Production.ProductInventory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-156, N'AdventureWorks2017 Sales.SpecialOffer Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SpecialOffer"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SpecialOffer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SpecialOffer.parquet",
    "SchemaFileName": "Sales.SpecialOffer.json"
  }
}', 0, N'Sales.SpecialOffer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-157, N'AdventureWorks2017 dbo.ErrorLog Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "ErrorLog"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/dbo/ErrorLog/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.ErrorLog.parquet",
    "SchemaFileName": "dbo.ErrorLog.json"
  }
}', 0, N'dbo.ErrorLog', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-158, N'AdventureWorks2017 Production.ProductListPriceHistory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductListPriceHistory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductListPriceHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductListPriceHistory.parquet",
    "SchemaFileName": "Production.ProductListPriceHistory.json"
  }
}', 0, N'Production.ProductListPriceHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-160, N'AdventureWorks2017 Sales.SpecialOfferProduct Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SpecialOfferProduct"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SpecialOfferProduct/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SpecialOfferProduct.parquet",
    "SchemaFileName": "Sales.SpecialOfferProduct.json"
  }
}', 0, N'Sales.SpecialOfferProduct', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-161, N'AdventureWorks2017 Production.ProductModel Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductModel"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductModel/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductModel.parquet",
    "SchemaFileName": "Production.ProductModel.json"
  }
}', 0, N'Production.ProductModel', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-163, N'AdventureWorks2017 Person.StateProvince Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "StateProvince"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/StateProvince/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.StateProvince.parquet",
    "SchemaFileName": "Person.StateProvince.json"
  }
}', 0, N'Person.StateProvince', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-164, N'AdventureWorks2017 Production.ProductModelIllustration Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductModelIllustration"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductModelIllustration/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductModelIllustration.parquet",
    "SchemaFileName": "Production.ProductModelIllustration.json"
  }
}', 0, N'Production.ProductModelIllustration', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-165, N'AdventureWorks2017 dbo.AWBuildVersion Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "dbo",
    "TableName": "AWBuildVersion"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/dbo/AWBuildVersion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "dbo.AWBuildVersion.parquet",
    "SchemaFileName": "dbo.AWBuildVersion.json"
  }
}', 0, N'dbo.AWBuildVersion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-166, N'AdventureWorks2017 Production.ProductModelProductDescriptionCulture Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductModelProductDescriptionCulture"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductModelProductDescriptionCulture/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductModelProductDescriptionCulture.parquet",
    "SchemaFileName": "Production.ProductModelProductDescriptionCulture.json"
  }
}', 0, N'Production.ProductModelProductDescriptionCulture', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-167, N'AdventureWorks2017 Production.BillOfMaterials Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "BillOfMaterials"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/BillOfMaterials/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.BillOfMaterials.parquet",
    "SchemaFileName": "Production.BillOfMaterials.json"
  }
}', 0, N'Production.BillOfMaterials', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-168, N'AdventureWorks2017 Sales.Store Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "Store"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/Store/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.Store.parquet",
    "SchemaFileName": "Sales.Store.json"
  }
}', 0, N'Sales.Store', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-169, N'AdventureWorks2017 Production.ProductPhoto Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductPhoto"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductPhoto/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductPhoto.parquet",
    "SchemaFileName": "Production.ProductPhoto.json"
  }
}', 0, N'Production.ProductPhoto', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-170, N'AdventureWorks2017 Production.ProductProductPhoto Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductProductPhoto"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductProductPhoto/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductProductPhoto.parquet",
    "SchemaFileName": "Production.ProductProductPhoto.json"
  }
}', 0, N'Production.ProductProductPhoto', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-171, N'AdventureWorks2017 Production.TransactionHistory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "TransactionHistory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/TransactionHistory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.TransactionHistory.parquet",
    "SchemaFileName": "Production.TransactionHistory.json"
  }
}', 0, N'Production.TransactionHistory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-172, N'AdventureWorks2017 Production.ProductReview Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductReview"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductReview/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductReview.parquet",
    "SchemaFileName": "Production.ProductReview.json"
  }
}', 0, N'Production.ProductReview', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-173, N'AdventureWorks2017 Person.BusinessEntity Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "BusinessEntity"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/BusinessEntity/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.BusinessEntity.parquet",
    "SchemaFileName": "Person.BusinessEntity.json"
  }
}', 0, N'Person.BusinessEntity', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-174, N'AdventureWorks2017 Production.TransactionHistoryArchive Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "TransactionHistoryArchive"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/TransactionHistoryArchive/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.TransactionHistoryArchive.parquet",
    "SchemaFileName": "Production.TransactionHistoryArchive.json"
  }
}', 0, N'Production.TransactionHistoryArchive', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-175, N'AdventureWorks2017 Production.ProductSubcategory Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "ProductSubcategory"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/ProductSubcategory/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.ProductSubcategory.parquet",
    "SchemaFileName": "Production.ProductSubcategory.json"
  }
}', 0, N'Production.ProductSubcategory', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-177, N'AdventureWorks2017 Purchasing.ProductVendor Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Purchasing",
    "TableName": "ProductVendor"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/ProductVendor/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.ProductVendor.parquet",
    "SchemaFileName": "Purchasing.ProductVendor.json"
  }
}', 0, N'Purchasing.ProductVendor', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-178, N'AdventureWorks2017 Person.BusinessEntityContact Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "BusinessEntityContact"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/BusinessEntityContact/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.BusinessEntityContact.parquet",
    "SchemaFileName": "Person.BusinessEntityContact.json"
  }
}', 0, N'Person.BusinessEntityContact', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-179, N'AdventureWorks2017 Production.UnitMeasure Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "UnitMeasure"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/UnitMeasure/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.UnitMeasure.parquet",
    "SchemaFileName": "Production.UnitMeasure.json"
  }
}', 0, N'Production.UnitMeasure', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-180, N'AdventureWorks2017 Purchasing.Vendor Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Purchasing",
    "TableName": "Vendor"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/Vendor/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.Vendor.parquet",
    "SchemaFileName": "Purchasing.Vendor.json"
  }
}', 0, N'Purchasing.Vendor', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-181, N'AdventureWorks2017 Person.ContactType Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "ContactType"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/ContactType/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.ContactType.parquet",
    "SchemaFileName": "Person.ContactType.json"
  }
}', 0, N'Person.ContactType', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-182, N'AdventureWorks2017 Sales.CountryRegionCurrency Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "CountryRegionCurrency"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/CountryRegionCurrency/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.CountryRegionCurrency.parquet",
    "SchemaFileName": "Sales.CountryRegionCurrency.json"
  }
}', 0, N'Sales.CountryRegionCurrency', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-183, N'AdventureWorks2017 Person.CountryRegion Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Person",
    "TableName": "CountryRegion"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/CountryRegion/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Person.CountryRegion.parquet",
    "SchemaFileName": "Person.CountryRegion.json"
  }
}', 0, N'Person.CountryRegion', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-184, N'AdventureWorks2017 Production.WorkOrder Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "WorkOrder"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/WorkOrder/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.WorkOrder.parquet",
    "SchemaFileName": "Production.WorkOrder.json"
  }
}', 0, N'Production.WorkOrder', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-185, N'AdventureWorks2017 Purchasing.PurchaseOrderDetail Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Purchasing",
    "TableName": "PurchaseOrderDetail"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/PurchaseOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.PurchaseOrderDetail.parquet",
    "SchemaFileName": "Purchasing.PurchaseOrderDetail.json"
  }
}', 0, N'Purchasing.PurchaseOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-186, N'AdventureWorks2017 Sales.CreditCard Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "CreditCard"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/CreditCard/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.CreditCard.parquet",
    "SchemaFileName": "Sales.CreditCard.json"
  }
}', 0, N'Sales.CreditCard', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-187, N'AdventureWorks2017 Production.Culture Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "Culture"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/Culture/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.Culture.parquet",
    "SchemaFileName": "Production.Culture.json"
  }
}', 0, N'Production.Culture', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-188, N'AdventureWorks2017 Production.WorkOrderRouting Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Production",
    "TableName": "WorkOrderRouting"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Production/WorkOrderRouting/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Production.WorkOrderRouting.parquet",
    "SchemaFileName": "Production.WorkOrderRouting.json"
  }
}', 0, N'Production.WorkOrderRouting', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-189, N'AdventureWorks2017 Sales.Currency Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "Currency"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/Currency/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.Currency.parquet",
    "SchemaFileName": "Sales.Currency.json"
  }
}', 0, N'Sales.Currency', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-190, N'AdventureWorks2017 Purchasing.PurchaseOrderHeader Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Purchasing",
    "TableName": "PurchaseOrderHeader"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Purchasing/PurchaseOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Purchasing.PurchaseOrderHeader.parquet",
    "SchemaFileName": "Purchasing.PurchaseOrderHeader.json"
  }
}', 0, N'Purchasing.PurchaseOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-191, N'AdventureWorks2017 Sales.CurrencyRate Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "CurrencyRate"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/CurrencyRate/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.CurrencyRate.parquet",
    "SchemaFileName": "Sales.CurrencyRate.json"
  }
}', 0, N'Sales.CurrencyRate', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-192, N'AdventureWorks2017 Sales.Customer Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",      "ChunkField": "CustomerID",      "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "Customer"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/Customer/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.Customer.parquet",
    "SchemaFileName": "Sales.Customer.json"
  }
}', 0, N'Sales.Customer', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-193, N'AdventureWorks2017 HumanResources.Department Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "HumanResources",
    "TableName": "Department"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/HumanResources/Department/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "HumanResources.Department.parquet",
    "SchemaFileName": "HumanResources.Department.json"
  }
}', 0, N'HumanResources.Department', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-195, N'AdventureWorks2017 Sales.SalesOrderDetail Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",      "ChunkField": "SalesOrderID",      "ChunkSize": "",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesOrderDetail"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesOrderDetail/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesOrderDetail.parquet",
    "SchemaFileName": "Sales.SalesOrderDetail.json"
  }
}', 0, N'Sales.SalesOrderDetail', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-198, N'AdventureWorks2017 Sales.SalesOrderHeader Extract to Data Lake', 3, 3, 2, 6, 3, 1, 0, N'OnP SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",      "ChunkField": "SalesOrderID",      "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "Sales",
    "TableName": "SalesOrderHeader"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Sales/SalesOrderHeader/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "Sales.SalesOrderHeader.parquet",
    "SchemaFileName": "Sales.SalesOrderHeader.json"
  }
}', 0, N'Sales.SalesOrderHeader', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-202, N'Archive AdventureWorks2017 Person Data Lake (BLOB To BLOB)', 2, 7, 4, 3, 7, 1, 0, N'SH IR', N'  {
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/",
    "DataFileName": "*.parquet",
	"Recursively" : "True",
	"DeleteAfterCompletion" : "False"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/",
    "DataFileName": ""
  }
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-203, N'Archive AdventureWorks2017 Person Data Lake (BLOB To ADLS)', 2, 7, 4, 3, 8, 1, 0, N'SH IR', N'  {
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/",
    "DataFileName": "*.parquet",
	"Recursively" : "True",
	"DeleteAfterCompletion" : "False"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AdventureWorks2017/Person/",
    "DataFileName": ""
  }
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-204, N'Archive AwSample ALL Data Lake (ADLS To ADLS)', 2, 7, 4, 4, 8, 1, 0, N'SH IR', N'  {
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/",
    "DataFileName": "*.parquet",
	"Recursively" : "True",
	"DeleteAfterCompletion" : "False"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/",
    "DataFileName": ""
  }
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-205, N'Archive AwSample ALL Data Lake (ADLS To Blob)', 2, 7, 4, 4, 7, 1, 0, N'SH IR', N'  {
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/",
    "DataFileName": "*.parquet",
	"Recursively" : "True",
	"DeleteAfterCompletion" : "False"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/",
    "DataFileName": ""
  }
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-206, N'afs_lic_202006.xlsx - AFS_LIC_202006 to CSV', 2, 1, 2, 3, 3, 1, 0, N'SH IR', N'
{
    "Source": {
        "Type": "Excel",               
        "RelativePath": "/Gov/AUFinancialLicenses/",
        "DataFileName": "afs_lic_202006.xlsx",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SheetName": "AFS_LIC_202006"
    },
    "Target": {
        "Type": "csv",
        "RelativePath": "/Gov/AUFinancialLicenses/",
        "DataFileName": "afs_lic_202006.csv",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True"
    }
}
', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-207, N'afs_lic_202006.xlsx - AFS_LIC_202006 to CSV ADLS', 2, 1, 2, 4, 4, 1, 0, N'SH IR', N'
{
    "Source": {
        "Type": "Excel",               
        "RelativePath": "/Gov/AUFinancialLicenses/",
        "DataFileName": "afs_lic_202006.xlsx",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True",
        "SheetName": "AFS_LIC_202006"
    },
    "Target": {
        "Type": "csv",
        "RelativePath": "/Gov/AUFinancialLicenses/",
        "DataFileName": "afs_lic_202006.csv",
        "SchemaFileName": "",
        "FirstRowAsHeader": "True"
    }
}
', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-210, N'Azure SQL Run SP [dbo].[usp_DimCustomer]', 7, 8, 2, 2, 2, 1, 0, N'SH IR', N'  {
  "Source": {
    "Type": "StoredProcedure",
    "TableSchema": "dbo",
    "TableName": "DIM_Customer",
	"StoredProcedure" : "[dbo].[usp_DimCustomer]",
	"Parameters" : ""
  },
  "Target": {
    "Type": "StoredProcedure",
  }
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-211, N'Azure SQL Run SP [dbo].[usp_DimCustomer_CleanData]', 7, 8, 2, 2, 2, 1, 0, N'SH IR', N'  {
  "Source": {
    "Type": "StoredProcedure",
    "TableSchema": "dbo",
    "TableName": "DIM_Customer",
	"StoredProcedure" : "[dbo].[usp_DimCustomer_CleanData]",
	"Parameters" : "6"
  },
  "Target": {
    "Type": "StoredProcedure",
  }
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-213, N'AwSample SalesLT.CustomerCopy ADLS to SQL', 1, 4, 2, 4, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerCopy/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerCopy.parquet",
    "SchemaFileName": "SalesLT.CustomerCopy.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "adls_CustomerCopy",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_adls_CustomerCopy",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_adls_CustomerCopy'') IS NOT NULL \r\n Truncate Table SalesLT.stg_adls_CustomerCopy",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.adls_CustomerCopy', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-214, N'AwSample SalesLT.CustomerCopy Data Lake to SQL', 1, 4, 2, 3, 2, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerCopy/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerCopy.parquet",
    "SchemaFileName": "SalesLT.CustomerCopy.json"
  },
  "Target": {
    "Type": "Table",
    "TableSchema": "SalesLT",
    "TableName": "CustomerCopy",
    "StagingTableSchema": "SalesLT",
    "StagingTableName": "stg_CustomerCopy",
    "AutoCreateTable": "True",
    "PreCopySQL": "IF OBJECT_ID(''SalesLT.stg_CustomerCopy'') IS NOT NULL \r\n Truncate Table SalesLT.stg_CustomerCopy",
    "PostCopySQL": "",
    "MergeSQL": "",
    "AutoGenerateMerge": "True"
  }
}', 0, N'SalesLT.CustomerCopy', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-215, N'AwSample SalesLT.CustomerCopy Extract to ADLS', 3, 2, 2, 1, 4, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Full",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "CustomerCopy"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerCopy/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerCopy.parquet",
    "SchemaFileName": "SalesLT.CustomerCopy.json"
  }
}', 0, N'SalesLT.adls_CustomerCopy', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-216, N'AwSample SalesLT.CustomerCopy Extract to Data Lake', 3, 2, 2, 1, 3, 1, 0, N'SH IR', N'{
  "Source": {
    "Type": "Table",
    "IncrementalType": "Watermark",
    "ChunkField": "{@TablePrimaryKey}",
    "ChunkSize": "5000",
    "ExtractionSQL": "",
    "TableSchema": "SalesLT",
    "TableName": "CustomerCopy"
  },
  "Target": {
    "Type": "Parquet",
    "RelativePath": "AwSample/SalesLT/CustomerCopy/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
    "DataFileName": "SalesLT.CustomerCopy.parquet",
    "SchemaFileName": "SalesLT.CustomerCopy.json"
  }
}', 0, N'SalesLT.CustomerCopy', 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-217, N'Generate Tasks for AwSample Extract to Data Lake', 8, 5, 4, 1, 3, 1, 0, N'SH IR', N'  {
  "TaskMasterName": "AwSample {@TableSchema@}.{@TableName@} Extract to Data Lake",
  "TaskTypeId": 3,
  "TaskGroupId": 2,
  "ScheduleMasterId": 2,
  "SourceSystemId": 1,
  "TargetSystemId": 3,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
      "Type": "Table",
      "IncrementalType": "Watermark",
      "ChunkField": "{@TablePrimaryKey}",
      "ChunkSize": "5000",
      "ExtractionSQL": "",
      "TableSchema": "{@TableSchema@}",
      "TableName": "{@TableName@}"
  },
  "Target": {
      "Type": "Parquet",
      "RelativePath": "AwSample/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
      "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
      "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
  },
  "ActiveYN": 0,
  "DependencyChainTag": "{@TableSchema@}.{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-218, N'Generate Tasks for AwSample Data Lake to SQL', 8, 5, 4, 1, 3, 1, 0, N'SH IR', N'  {
  "TaskMasterName": "AwSample {@TableSchema@}.{@TableName@} Data Lake to SQL",
  "TaskTypeId": 1,
  "TaskGroupId": 4,
  "ScheduleMasterId": 2,
  "SourceSystemId": 3,
  "TargetSystemId": 2,
  "DegreeOfCopyParallelism": 1,
  "AllowMultipleActiveInstances": 0,
  "TaskDatafactoryIR": "SH IR",
  "Source": {
     "Type": "Parquet",
       "RelativePath": "AwSample/{@TableSchema@}/{@TableName@}/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
       "DataFileName": "{@TableSchema@}.{@TableName@}.parquet",
       "SchemaFileName": "{@TableSchema@}.{@TableName@}.json"
   },
   "Target": {
     "Type": "Table",
     "TableSchema": "{@TableSchema@}",
     "TableName": "{@TableName@}",
     "StagingTableSchema": "{@TableSchema@}",
     "StagingTableName": "stg_{@TableName@}",
     "AutoCreateTable": "True",
     "PreCopySQL": "IF OBJECT_ID(''{@TableSchema@}.stg_{@TableName@}'') IS NOT NULL \r\n Truncate Table {@TableSchema@}.stg_{@TableName@}",
     "PostCopySQL": "",
     "MergeSQL": "",
     "AutoGenerateMerge": "True"    
   },
  "ActiveYN": 1,
  "DependencyChainTag": "{@TableSchema@}.{@TableName@}",
  "DataFactoryId":1
} ', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-222, N'Generate SAS Uri for GP sergio.zenatti@microsoft.com', 9, 9, 5, 9, 10, 1, 0, N'N/A', N'{
    "Source": {
        "Type": "SASUri",
        "PHIWideTransientInZoneIDForPHNX": 1,
        "TargetSystem": "1", //This is the configuration databases ID for the PHNs transient in data lake zone.    
        "RelativePath": "GPSergioZenatti/PipQi/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
        "SasURIDaysValid": "7",
        "DataFileName": "TestPIPQIFile.csv"
    },
    "Target": {
        "Type": "Email",
        "Email Recipient": "sergio.zenatti@microsoft.com",
        "Email Recipient Name": "Sergio Zenatti Filho",
        "Email Template File Name": ""
    }
}', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-225, N'Generate SAS Uri for GP john.rampono@microsoft.com', 9, 9, 3, 9, 10, 1, 0, N'N/A', N'{
    "Source": {
        "Type": "SASUri",        
        "TargetSystem": "1", //This is the configuration databases ID for the PHNs transient in data lake zone. Used by framework to issue SASURI
        "TargetSystemUidInPHI": "0db4573e-38e9-48ea-a83f-941869e9161c", //This is the ID that will be used by the uploader app to find the Transient In zone''s base URL
        "FileUploaderWebAppURL": "https://www.testfileuploader",
        "RelativePath": "JohnRampono/PipQi/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
        "SasURIDaysValid": "7",
        "DataFileName": "TestPIPQIFile.csv"
    },
    "Target": {
        "Type": "Email",
        "Email Subject": "PipQi File Upload Link",
        "Email Recipient": "john.rampono@microsoft.com",
        "Email Recipient Name": "John Rampono",
        "Email Template File Name": "PipQISasUriEmail"
    }
}', 0, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-226, N'Sync Azure Storage Listing to SQL Cache - Transient In Zone', 10, 9, 3, 9, 11, 1, 0, N'N/A', N'{
  "Source": {
    "Type": "Filelist",
    "StorageAccountToken": "?sv=2018-03-28&tn=Filelist&sig=fVSG%2FiB1akTncKfIJInXrdxMINYrA32ORBAydF26dr4%3D&se=2021-09-06T10%3A43%3A05Z&sp=r"
  },
  "Target": {
    "Type":"Table"
  }
}', 1, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-227, N'Copy PipQiFile From Transient Stage', 2, 9, 3, 9, 3, 1, 0, N'SH IR', N'{
    "Source": {
        "Type": "*",
        "RelativePath": "JohnRampono/PipQi/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
        "DataFileName": "TestPIPQIFile.csv",
        "Recursively": "False",
        "TriggerUsingAzureStorageCache": true,
        "DeleteAfterCompletion": "False"
    },
    "Target": {
        "Type": "*",
        "RelativePath": "JohnRampono/PipQi/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
        "DataFileName": "TestPIPQIFile.csv"
    },
    "Alerts" :[
      {"AlertCategory": "Generic Task Executed Alert", "EmailTemplateFileName":"PipQI_FileDropped", "EmailRecepient": "jrampono@gmail.com", "EmailRecepientName": "jrampono@gmail.com"}
    ]

}', 1, NULL, 1)
INSERT [dbo].[TaskMaster] ([TaskMasterId], [TaskMasterName], [TaskTypeId], [TaskGroupId], [ScheduleMasterId], [SourceSystemId], [TargetSystemId], [DegreeOfCopyParallelism], [AllowMultipleActiveInstances], [TaskDatafactoryIR], [TaskMasterJSON], [ActiveYN], [DependencyChainTag], [DataFactoryId]) VALUES (-228, N'Send email alert PIpQiFle', 11, 9, 3, 3, 10, 1, 0, N'*', N'{
    "Source": {
        "Type": "*",
        "RelativePath": "JohnRampono/PipQi/{yyyy}/{MM}/{dd}/{hh}/{mm}/",
        "DataFileName": "TestPIPQIFile.csv",
        "Recursively": "False",
        "TriggerUsingAzureStorageCache": true,
        "DeleteAfterCompletion": "False"
    },
    "Target": {
        "Type": "*",
        "Alerts": [{
                "AlertCategory": "Generic Task Executed Alert",
                "EmailTemplateFileName": "PipQI_FileDropped",
                "EmailRecepient": "jrampono@gmail.com",
                "EmailSubject": "File has landed",
                "EmailRecepientName": "jrampono@gmail.com"
            },
            {
                "AlertCategory": "Generic Task Executed Alert",
                "EmailTemplateFileName": "PipQI_FileDropped",
                "EmailRecepient": "jrampono@gmail.com",
                "EmailSubject": "File has landed",
                "EmailRecepientName": "jrampono@gmail.com"
            }
        ]
    }
}', 1, NULL, 1)
SET IDENTITY_INSERT [dbo].[TaskMaster] OFF
