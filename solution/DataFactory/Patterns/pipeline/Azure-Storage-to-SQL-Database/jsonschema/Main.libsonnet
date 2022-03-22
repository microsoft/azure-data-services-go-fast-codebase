local partials = {
   "DelimitedText": import "Partial_LoadFromDelimitedText.libsonnet",
   "Excel": import "Partial_LoadFromExcel.libsonnet",
   "Json": import "Partial_LoadFromJson.libsonnet",
   "Parquet": import "Partial_LoadFromParquet.libsonnet",
   "AzureSqlTable": import "Partial_LoadIntoSql.libsonnet",
   "AzureSqlDWTable": import "Partial_LoadIntoSql.libsonnet"
};


function(SourceType = "", SourceFormat = "Excel",TargetType = "AzureSqlTable", TargetFormat = "")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "Source": partials[SourceFormat](),
        "Target": partials[TargetType]()
    },
    "required": [
        "Source",
        "Target"
    ]
}