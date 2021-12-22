function(source = {}, target = {})
{
    "$schema": "http://json-schema.org/draft-04/schema#",
    "type": "object",
    "title": "TaskMasterJson",
    "properties": {} 
    + source
    + target,
    "required": [
        "Source",
        "Target"
    ]
}