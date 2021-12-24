function (GenerateArm=false, SourceType = "AzureBlobStorage", GFPIR = "{IRA}")
{
        "type": "DelimitedTextReadSettings",
        "skipLineCount": {
            "value": "@pipeline().parameters.TaskObject.Source.SkipLineCount",
            "type": "Expression"
        }
    }