function(parquet = {}, sqlimport = {})
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {} 
    + parquet
    + sqlimport,
    "required": [
        "Source",
        "Target"
    ]
}