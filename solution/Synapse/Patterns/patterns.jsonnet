local Template_Azure_Storage_to_Azure_Storage = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "Azure-Storage-to-Azure-Storage",
        "GFPIR": "Azure",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-2,
        "Pipeline":"GPL_SparkNotebookExecution"
};

local Template_Execute_Notebook = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "Execute-Notebook",
        "GFPIR": "Azure",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-5,
        "Pipeline":"GPL_SparkNotebookExecution"


};

local Template_Synapse_SQLPool_StartStop = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "Synapse-SQLPool-Start-Stop",
        "GFPIR": "Azure",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-6,
        "Pipeline":"Synapse_SQLPool_Start_Stop"
};


#Azure_Storage_to_Azure_Storage 
[   
    #Parquet to Delta

    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobStorage","Delta"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobFS","Delta"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobFS","Delta"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobStorage","Delta"),



    #Delta to Delta

    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Delta","AzureBlobStorage","Delta"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Delta","AzureBlobFS","Delta"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Delta","AzureBlobFS","Delta"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Delta","AzureBlobStorage","Delta"),

    #Delta to Parquet


    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Delta","AzureBlobStorage","Parquet"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Delta","AzureBlobFS","Parquet"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Delta","AzureBlobFS","Parquet"),

    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Delta","AzureBlobStorage","Parquet")

]
+
#Execute Notebook 
[

    #From N/A to anything

    Template_Execute_Notebook("N/A","Notebook-Optional","AzureBlobFS","Notebook-Optional"),

    Template_Execute_Notebook("N/A","Notebook-Optional","AzureBlobStorage","Notebook-Optional"),

    Template_Execute_Notebook("N/A","Notebook-Optional","AzureSqlTable","Notebook-Optional"),
    
    Template_Execute_Notebook("N/A","Notebook-Optional","AzureSqlDWTable","Notebook-Optional"),

    Template_Execute_Notebook("N/A","Notebook-Optional","SqlServerTable","Notebook-Optional"),

    Template_Execute_Notebook("N/A","Notebook-Optional","N/A","Notebook-Optional"),
    
    #From Storage to anything

    Template_Execute_Notebook("AzureBlobStorage","Notebook-Optional","AzureBlobFS","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobStorage","Notebook-Optional","AzureBlobStorage","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobStorage","Notebook-Optional","AzureSqlTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureBlobStorage","Notebook-Optional","AzureSqlDWTable","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobStorage","Notebook-Optional","SqlServerTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureBlobStorage","Notebook-Optional","N/A","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobFS","Notebook-Optional","AzureBlobFS","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobFS","Notebook-Optional","AzureBlobStorage","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobFS","Notebook-Optional","AzureSqlTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureBlobFS","Notebook-Optional","AzureSqlDWTable","Notebook-Optional"),

    Template_Execute_Notebook("AzureBlobFS","Notebook-Optional","SqlServerTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureBlobFS","Notebook-Optional","N/A","Notebook-Optional"),


    #From SQL to anything
    Template_Execute_Notebook("AzureSqlTable","Notebook-Optional","AzureBlobFS","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlTable","Notebook-Optional","AzureBlobStorage","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlTable","Notebook-Optional","AzureSqlTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureSqlTable","Notebook-Optional","AzureSqlDWTable","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlTable","Notebook-Optional","SqlServerTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureSqlTable","Notebook-Optional","N/A","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlDWTable","Notebook-Optional","AzureBlobFS","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlDWTable","Notebook-Optional","AzureBlobStorage","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlDWTable","Notebook-Optional","AzureSqlTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureSqlDWTable","Notebook-Optional","AzureSqlDWTable","Notebook-Optional"),

    Template_Execute_Notebook("AzureSqlDWTable","Notebook-Optional","SqlServerTable","Notebook-Optional"),
    
    Template_Execute_Notebook("AzureSqlDWTable","Notebook-Optional","N/A","Notebook-Optional"),

    Template_Execute_Notebook("SqlServerTable","Notebook-Optional","AzureBlobFS","Notebook-Optional"),

    Template_Execute_Notebook("SqlServerTable","Notebook-Optional","AzureBlobStorage","Notebook-Optional"),

    Template_Execute_Notebook("SqlServerTable","Notebook-Optional","AzureSqlTable","Notebook-Optional"),
    
    Template_Execute_Notebook("SqlServerTable","Notebook-Optional","AzureSqlDWTable","Notebook-Optional"),

    Template_Execute_Notebook("SqlServerTable","Notebook-Optional","SqlServerTable","Notebook-Optional"),
    
    Template_Execute_Notebook("SqlServerTable","Notebook-Optional","N/A","Notebook-Optional"),


]

+
#Synapse-SQLPool-Start-Stop
[
    Template_Synapse_SQLPool_StartStop("N/A","Not-Applicable","Azure Synapse","Not-Applicable")

]