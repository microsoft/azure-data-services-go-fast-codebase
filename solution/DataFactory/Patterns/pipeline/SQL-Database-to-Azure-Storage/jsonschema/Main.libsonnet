local partials = {
   "AzureSqlTable": import "Partial_LoadFromSql.libsonnet",
   "AzureSqlDWTable": import "Partial_LoadFromSql.libsonnet",   
   "SqlServerTable": import "Partial_LoadFromSql.libsonnet",   
   "Parquet": import "Partial_LoadIntoParquet.libsonnet",   
};


function(SourceType = "AzureSqlTable", SourceFormat = "",TargetType = "", TargetFormat = "Parquet")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "Source": partials[SourceType](),
        "Target": partials[TargetFormat]()
    },
    "required": [
        "Source",
        "Target"
    ]
}