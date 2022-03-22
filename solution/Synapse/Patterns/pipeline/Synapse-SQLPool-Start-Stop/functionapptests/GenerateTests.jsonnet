function(seed=0)
local tests =
[
    //****************************************************************//
    //*                    Synapse Dedicated Pool Tests              *//
    //****************************************************************//
    {        
        "Active": true,        
        "Pattern": "Synapse-SQLPool-Start-Stop",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Not-Applicable",
        "SourceType":"N/A",        
        "SourceDataFilename":"",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Not-Applicable",
        "TargetType":"N/A",        
        "TargetDataFilename":"",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        "SynapsePipeline": "Not-Applicable",
        "Description": "Testing Starting of SQL Dedicated Pool",  
        "SQLPoolOperation": "start",
        "SQLPoolName": "TestPool"
    },

    {        
        "Active": true,        
        "Pattern": "Synapse-SQLPool-Start-Stop",         
        "SourceSystemAuthType": "MSI",
        
        "SourceFormat":"Not-Applicable",
        "SourceType":"N/A",        
        "SourceDataFilename":"",
        "SourceSourceSystemAuthType": "MSI",
        "SourceSchemaFileName":"", 
        "SourceSkipLineCount":"",
        "SourceFirstRowAsHeader": "false",
        "SourceSheetName":"",
        "SourceMaxConcurrentConnections":0,
        "SourceRecursively":"false",
        "SourceDeleteAfterCompletion":"false",
        
        "TargetFormat":"Not-Applicable",
        "TargetType":"N/A",        
        "TargetDataFilename":"",
        "TargetSchemaFileName":"",
        "TargetSourceSystemAuthType":"MSI", 
        "TargetSkipLineCount":"",
        "TargetFirstRowAsHeader": "false",
        "TargetSheetName":"",
        "TargetMaxConcurrentConnections":0,
        "TargetRecursively":"false",
        "TargetDeleteAfterCompletion":"false",
        "SynapsePipeline": "Not-Applicable",
        "Description": "Testing Pausing of SQL Dedicated Pool",  
        "SQLPoolOperation": "pause",
        "SQLPoolName": "TestPool"
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
    t.Description,
    t.SQLPoolName,
    t.SQLPoolOperation


);


std.mapWithIndex(process, tests)

