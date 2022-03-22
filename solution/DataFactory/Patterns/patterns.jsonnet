local Template_SQL_Database_to_Azure_Storage = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "SQL-Database-to-Azure-Storage",
        "GFPIR": "Azure",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-3,
        "Pipeline":"GPL_" + SourceType + "_" + "NA" + "_" + TargetType + "_" + TargetFormat  
};
local Template_Azure_Storage_to_SQL_Database = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "Azure-Storage-to-SQL-Database",
        "GFPIR": "Azure",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-1,
        "Pipeline":"GPL_" + SourceType + "_" + SourceFormat + "_" + TargetType + "_" + "NA"  
};
local Template_Azure_Storage_to_Azure_Storage = function(SourceType, SourceFormat, TargetType, TargetFormat)
{
        "Folder": "Azure-Storage-to-Azure-Storage",
        "GFPIR": "Azure",
        "SourceType": SourceType,
        "SourceFormat": SourceFormat,
        "TargetType": TargetType,
        "TargetFormat": TargetFormat,
        "TaskTypeId":-2,
        "Pipeline":"GPL_" + SourceType + "_" + SourceFormat + "_" + TargetType + "_" + TargetFormat  
};

#SQL_Database_to_Azure_Storage
[   
    #Blob
    Template_SQL_Database_to_Azure_Storage("AzureSqlTable","Sql","AzureBlobStorage","Parquet"),
    Template_SQL_Database_to_Azure_Storage("SqlServerTable","Sql","AzureBlobStorage","Parquet"),
    #Template_SQL_Database_to_Azure_Storage("AzureSqlDWTable","Sql","AzureBlobStorage","Parquet"),
    Template_SQL_Database_to_Azure_Storage("AzureSqlTable","Table","AzureBlobStorage","Parquet"),
    Template_SQL_Database_to_Azure_Storage("SqlServerTable","Table","AzureBlobStorage","Parquet"),
    #Template_SQL_Database_to_Azure_Storage("AzureSqlDWTable","Table","AzureBlobStorage","Parquet"),
    #ADLS
    Template_SQL_Database_to_Azure_Storage("AzureSqlTable","Sql","AzureBlobFS","Parquet"),
    Template_SQL_Database_to_Azure_Storage("SqlServerTable","Sql","AzureBlobFS","Parquet"),
    #Template_SQL_Database_to_Azure_Storage("AzureSqlDWTable","Sql","AzureBlobFS","Parquet"),
    Template_SQL_Database_to_Azure_Storage("AzureSqlTable","Table","AzureBlobFS","Parquet"),
    Template_SQL_Database_to_Azure_Storage("SqlServerTable","Table","AzureBlobFS","Parquet"),
    #Template_SQL_Database_to_Azure_Storage("AzureSqlDWTable","Table","AzureBlobFS","Parquet")   
    Template_SQL_Database_to_Azure_Storage("AzureSqlTable","Table","FileServer","Parquet"),
    Template_SQL_Database_to_Azure_Storage("SqlServerTable","Table","FileServer","Parquet")
]
+
#Azure_Storage_to_SQL_Database
[
    #Blob - AzureSqlTable
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","Parquet","AzureSqlTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","Excel","AzureSqlTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","Json","AzureSqlTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","DelimitedText","AzureSqlTable","Table"),

    #ADLS - AzureSqlTable
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","Parquet","AzureSqlTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","Excel","AzureSqlTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","Json","AzureSqlTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","DelimitedText","AzureSqlTable","Table"),

    #Blob - AzureSqlDWTable
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","Parquet","AzureSqlDWTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","Excel","AzureSqlDWTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","Json","AzureSqlDWTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobStorage","DelimitedText","AzureSqlDWTable","Table"),

    #ADLS  - AzureSqlDWTable
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","Parquet","AzureSqlDWTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","Excel","AzureSqlDWTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","Json","AzureSqlDWTable","Table"),
    Template_Azure_Storage_to_SQL_Database("AzureBlobFS","DelimitedText","AzureSqlDWTable","Table")
]
+ 
#Azure_Storage_to_Azure_Storage 
[   
    #Binary to Binary
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Binary","AzureBlobStorage","Binary"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Binary","AzureBlobFS","Binary"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Binary","AzureBlobStorage","Binary"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Binary","AzureBlobFS","Binary"),
    Template_Azure_Storage_to_Azure_Storage("FileServer","Binary","AzureBlobStorage","Binary"),
    Template_Azure_Storage_to_Azure_Storage("FileServer","Binary","AzureBlobFS","Binary"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Binary","FileServer","Binary"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Binary","FileServer","Binary"),
    
    #Blob to Blob 
    # Parquet to *        
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobStorage","Excel") -- Excel is not supported as a datafactory target!!!,
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobStorage","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobStorage","DelimitedText"),
        
    # Excel to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Excel","AzureBlobStorage","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Excel","AzureBlobStorage","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Excel","AzureBlobStorage","DelimitedText"),

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","DelimitedText","AzureBlobStorage","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","DelimitedText","AzureBlobStorage","Json"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","DelimitedText","AzureBlobStorage","Excel") -- Excel is not supported as a datafactory target!!!,

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Json","AzureBlobStorage","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Json","AzureBlobStorage","DelimitedText"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Json","AzureBlobStorage","Excel") -- Excel is not supported as a datafactory target!!!,
    
    #ADLS to ADLS
    # Parquet to *
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobFS","Excel") -- Excel is not supported as a datafactory target!!!,
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobFS","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobFS","DelimitedText"),
        
    # Excel to --0 *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Excel","AzureBlobFS","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Excel","AzureBlobFS","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Excel","AzureBlobFS","DelimitedText"),

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","DelimitedText","AzureBlobFS","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","DelimitedText","AzureBlobFS","Json"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","DelimitedText","AzureBlobFS","Excel") --Excel is not supported as a datafactory target!!!,

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Json","AzureBlobFS","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Json","AzureBlobFS","DelimitedText"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Json","AzureBlobFS","Excel") -- Excel is not supported as a datafactory target!!!,
  
    #ADLS to Blob
    # Parquet to *
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobStorage","Excel") --Excel is not supported as a datafactory target!!!,
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobStorage","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Parquet","AzureBlobStorage","DelimitedText"),
        
    # Excel to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Excel","AzureBlobStorage","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Excel","AzureBlobStorage","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Excel","AzureBlobStorage","DelimitedText"),

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","DelimitedText","AzureBlobStorage","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","DelimitedText","AzureBlobStorage","Json"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","DelimitedText","AzureBlobStorage","Excel") -- Excel is not supported as a datafactory target!!!,

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Json","AzureBlobStorage","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Json","AzureBlobStorage","DelimitedText"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobFS","Json","AzureBlobStorage","Excel") -- Excel is not supported as a datafactory target!!!,

    #Blob to ADLS
    # Parquet to *
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobFS","Excel") -- Excel is not supported as a datafactory target!!!,
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobFS","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Parquet","AzureBlobFS","DelimitedText"),
        
    # Excel to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Excel","AzureBlobFS","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Excel","AzureBlobFS","Json"),
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Excel","AzureBlobFS","DelimitedText"),

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","DelimitedText","AzureBlobFS","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","DelimitedText","AzureBlobFS","Json"),
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","DelimitedText","AzureBlobFS","Excel") -- Excel is not supported as a datafactory target!!!,

    # DelimitedText to *
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Json","AzureBlobFS","Parquet"),    
    Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Json","AzureBlobFS","DelimitedText")
    #Template_Azure_Storage_to_Azure_Storage("AzureBlobStorage","Json","AzureBlobFS","Excel") -- Excel is not supported as a datafactory target!!!,
]