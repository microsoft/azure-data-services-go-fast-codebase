function(seed=0)
local tests =
[
//****************************************************************/
//**                    Azure SQL                                */
//****************************************************************/
    //GPL_AzureBlobFS_Parquet_AzureSqlTable_NA_FullLoad
    {        
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Parquet",
        "SourceType":"ADLS",        
        "DataFilename":"SalesLT.Customer.parquet",
        "SchemaFileName":"SalesLT.Customer.json", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "false",
        "SheetName":"",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"Customer",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_Customer",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "true",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_Parquet_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_Parquet_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Parquet",
        "SourceType":"Azure Blob",        
        "DataFilename":"SalesLT.Customer.parquet",
        "SchemaFileName":"SalesLT.Customer.json", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "false",
        "SheetName":"",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"Customer",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_Customer",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "true",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_Parquet_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobFS_Excel_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"ADLS",        
        "DataFilename":"yellow_tripdata_2017-03.xlsx",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "yellow_tripdata_2017-03",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_Excel_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_Excel_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"Azure Blob",        
        "DataFilename":"yellow_tripdata_2017-03.xlsx",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "yellow_tripdata_2017-03",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_Excel_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_DelimitedText_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Csv",
        "SourceType":"Azure Blob",        
        "DataFilename":"yellow_tripdata_2017-03.csv",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 


        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_DelimitedText_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_json_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Json",
        "SourceType":"Azure Blob",        
        "DataFilename":"yellow_tripdata_2017-03.json",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 

        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_json_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobFS_DelimitedText_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Csv",
        "SourceType":"ADLS",        
        "DataFilename":"yellow_tripdata_2017-03.csv",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 


        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_DelimitedText_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobFS_json_AzureSqlTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Json",
        "SourceType":"ADLS",        
        "DataFilename":"yellow_tripdata_2017-03.json",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure SQL", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 

        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_json_AzureSqlTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
//****************************************************************/
//**                    Azure Synapse                            */
//****************************************************************/
   //GPL_AzureBlobFS_Parquet_AzureSqlDWTable_NA_FullLoad
    {        
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Parquet",
        "SourceType":"ADLS",        
        "DataFilename":"SalesLT.Customer.parquet",
        "SchemaFileName":"SalesLT.Customer.json", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "false",
        "SheetName":"",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"Customer",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_Customer",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "true",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_Parquet_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure" 
       
    },
    //GPL_AzureBlobStorage_Parquet_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Parquet",
        "SourceType":"Azure Blob",        
        "DataFilename":"SalesLT.Customer.parquet",
        "SchemaFileName":"SalesLT.Customer.json", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "false",
        "SheetName":"",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"Customer",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_Customer",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "true",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_Parquet_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure" 
       
    },
    //GPL_AzureBlobFS_Excel_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"ADLS",        
        "DataFilename":"yellow_tripdata_2017-03.xlsx",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "yellow_tripdata_2017-03",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_Excel_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_Excel_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"Azure Blob",        
        "DataFilename":"yellow_tripdata_2017-03.xlsx",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "yellow_tripdata_2017-03",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 
        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_Excel_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_DelimitedText_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Csv",
        "SourceType":"Azure Blob",        
        "DataFilename":"yellow_tripdata_2017-03.csv",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 


        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_DelimitedText_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobStorage_json_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Json",
        "SourceType":"Azure Blob",        
        "DataFilename":"yellow_tripdata_2017-03.json",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 

        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobStorage_json_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobFS_DelimitedText_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Csv",
        "SourceType":"ADLS",        
        "DataFilename":"yellow_tripdata_2017-03.csv",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 


        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_DelimitedText_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    },
    //GPL_AzureBlobFS_json_AzureSqlDWTable_NA_FullLoad
    {
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Json",
        "SourceType":"ADLS",        
        "DataFilename":"yellow_tripdata_2017-03.json",
        "SchemaFileName":"", 
        "SkipLineCount":0,
        "FirstRowAsHeader": "true",
        "SheetName": "",
        "MaxConcurrentConnections":0,
        "Recursively":"false",
        "DeleteAfterCompletion":"false",
        
        "TargetFormat":"Table",
        "TargetType": "Azure Synapse", 
        "TableSchema":"dbo",
        "TableName":"yellow_tripdata",
        "StagingTableSchema":"dbo",
        "StagingTableName":"stg_yellow_tripdata",
        "AutoCreateTable": "true",
        "PreCopySQL": "",
        "PostCopySQL": "",
        "AutoGenerateMerge": "false",
        "MergeSQL":"", 

        
        "Description": "FullLoad",  
        "ADFPipeline": "GPL_AzureBlobFS_json_AzureSqlDWTable_NA",
        "TaskDatafactoryIR":"Azure"
       
    }

];

local template = import "./partials/functionapptest.libsonnet";

local process = function(index, t)
template(
    t.ADFPipeline,
    t.Pattern, 
    seed+index,//t.TestNumber,
    t.SourceFormat,
    t.SourceType,
    t.DataFilename,
    t.SchemaFileName,
    t.SourceSystemAuthType,
    t.SkipLineCount,
    t.FirstRowAsHeader,
    t.SheetName,
    t.MaxConcurrentConnections,
    t.Recursively,
    t.DeleteAfterCompletion,
    t.TargetFormat,
    t.TargetType,
    t.TableSchema,
    t.TableName,
    t.StagingTableSchema,
    t.StagingTableName,
    t.AutoCreateTable,
    t.PreCopySQL,
    t.PostCopySQL,
    t.AutoGenerateMerge,
    t.MergeSQL,
    t.Description,
    t.TaskDatafactoryIR
);


std.mapWithIndex(process, tests)

