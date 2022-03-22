function(seed=0)
local tests =
[
    //****************************************************************/
    //**                    Storage to Storage Tests                 */
    //****************************************************************/
    //GPL_AzureBlobFS_Binary_AzureBlobFS_Binary_FullLoad
    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Binary",
        "SourceType":"ADLS",        
        "SourceDataFilename":"SalesLT.Customer*.parquet",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"SalesLT.Customer*.json", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Binary",
        "TargetType":"ADLS",        
        "TargetDataFilename":"SalesLT.Customer.parquet",
        "TargetSchemaFileName":"SalesLT.Customer.json",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_AzureBlobFS_Binary" 
       
    },
    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",            
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Binary",
        "SourceType":"ADLS",        
        "SourceDataFilename":"SalesLT.Customer*.parquet",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"SalesLT.Customer*.json", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Binary",
        "TargetType":"ADLS",        
        "TargetDataFilename":"SalesLT.Customer.parquet",
        "TargetSchemaFileName":"SalesLT.Customer.json",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_AzureBlobFS_Binary" 
       
    },
    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Binary",
        "SourceType":"ADLS",        
        "SourceDataFilename":"*.*",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Binary",
        "TargetType":"ADLS",        
        "TargetDataFilename":"",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "Folder copy between datalake zones",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_AzureBlobFS_Binary" 
       
    },
    {        
        "Active": true,        
        "Pattern": "Azure Storage to SQL Database",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"ADLS",        
        "SourceDataFilename":"yellow_tripdata_2017-03.xlsx",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "true",
        "SourceSheetName":"yellow_tripdata_2017-03",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Parquet",
        "TargetType":"ADLS",        
        "TargetDataFilename":"yellow_tripdata_2017-03.parquet",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "true",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_AzureBlobFS_Binary" 
       
    },
    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",            
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"ADLS",        
        "SourceDataFilename":"yellow_tripdata_2017-03.xlsx",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "true",
        "SourceSheetName":"yellow_tripdata_2017-03",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Csv",
        "TargetType":"ADLS",        
        "TargetDataFilename":"yellow_tripdata_2017-03.csv",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "true",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_AzureBlobFS_Binary" 
       
    },
    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",          
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Excel",
        "SourceType":"ADLS",        
        "SourceDataFilename":"yellow_tripdata_2017-03.xlsx",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "true",
        "SourceSheetName":"yellow_tripdata_2017-03",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Json",
        "TargetType":"ADLS",        
        "TargetDataFilename":"yellow_tripdata_2017-03.json",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "true",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_AzureBlobFS_Binary" 
       
    },
    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",          
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Binary",
        "SourceType":"ADLS",        
        "SourceDataFilename":"yellow_tripdata_2017-03.xlsx",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Binary",
        "TargetType":"FileServer",        
        "TargetDataFilename":"yellow_tripdata_2017-03.xlsx",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "true",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy from data lake to FileServer",  
        "ADFPipeline": "GPL_AzureBlobFS_Binary_FileServer_Binary" 
       
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
    t.SourceDataFilename,
    t.SourceSchemaFileName,
    t.SourceSourceSystemAuthType,
    t.SourceSkipLineCount,
    t.SourceFirstRowAsHeader,
    t.SourceSheetName,
    t.SourceMaxConcurrentConnections,
    t.SourceRecursively,
    t.SourceDeleteAfterCompletion,
    t.TargetFormat,
    t.TargetType,
    t.TargetDataFilename,
    t.TargetSchemaFileName,
    t.TargetSourceSystemAuthType,
    t.TargetSkipLineCount,
    t.TargetFirstRowAsHeader,
    t.TargetSheetName,
    t.TargetMaxConcurrentConnections,
    t.TargetRecursively,
    t.TargetDeleteAfterCompletion,
    t.Description
);


std.mapWithIndex(process, tests)

