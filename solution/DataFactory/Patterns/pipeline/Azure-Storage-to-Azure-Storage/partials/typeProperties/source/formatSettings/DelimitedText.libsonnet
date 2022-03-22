function()	
{
    "formatSettings": {
        "type": "DelimitedTextReadSettings",
        "skipLineCount": {
            "value": "@pipeline().parameters.TaskObject.Source.SkipLineCount",
            "type": "Expression"
        }
    }
}