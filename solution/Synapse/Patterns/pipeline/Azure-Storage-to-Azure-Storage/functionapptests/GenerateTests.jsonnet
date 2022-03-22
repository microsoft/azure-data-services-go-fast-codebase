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
        
        "SourceFormat":"Parquet",
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
        
        "TargetFormat":"Delta",
        "TargetType":"ADLS",        
        "TargetDataFilename":"SalesLT.Customer",
        "TargetSchemaFileName":"SalesLT.Customer.json",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "SynapsePipeline": "GPL_SparkNotebookExecution_Primary_Azure" 
       
    },

    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Delta",
        "SourceType":"ADLS",        
        "SourceDataFilename":"SalesLT-Customer-Delta/SalesLT.Customer/",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"SalesLT.Customer*.json", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Delta",
        "TargetType":"ADLS",        
        "TargetDataFilename":"DeltaTable/SalesLT.Customer",
        "TargetSchemaFileName":"SalesLT.Customer.json",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "SynapsePipeline": "GPL_SparkNotebookExecution_Primary_Azure" 
       
    },


    {        
        "Active": true,        
        "Pattern": "Azure Storage to Azure Storage",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Delta",
        "SourceType":"ADLS",        
        "SourceDataFilename":"SalesLT-Customer-Delta/SalesLT.Customer/",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"SalesLT.Customer*.json", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Parquet",
        "TargetType":"ADLS",        
        "TargetDataFilename":"SalesLT.Customer*.parquet",
        "TargetSchemaFileName":"SalesLT.Customer.json",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        
        "Description": "File copy between datalake zones",  
        "SynapsePipeline": "GPL_SparkNotebookExecution_Primary_Azure" 
       
    }

];

local template = import "./partials/functionapptest.libsonnet";

local process = function(index, t)
template(
    t.SynapsePipeline,
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

