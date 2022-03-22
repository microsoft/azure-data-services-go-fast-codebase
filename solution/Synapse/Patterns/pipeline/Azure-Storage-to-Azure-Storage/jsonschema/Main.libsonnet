local partials = {
   "Parquet": import "Partial_Parquet.libsonnet",
   "Delta": import "Partial_Delta.libsonnet"   
};


function(SourceType = "", SourceFormat = "Parquet",TargetType = "AzureSqlTable", TargetFormat = "Delta")
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {
        "Source": partials[SourceFormat](),
        "Target": partials[TargetFormat]()
    },
    "required": [
        "Source",
        "Target"
    ]
}