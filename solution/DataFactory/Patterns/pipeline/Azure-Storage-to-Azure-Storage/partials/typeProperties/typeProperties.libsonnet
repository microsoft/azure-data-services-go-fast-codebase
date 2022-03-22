function(GenerateArm=false,GFPIR="{IRA}",SourceType="AzureBlobStorage",SourceFormat="DelimitedText", TargetType="AzureBlobFS", TargetFormat="Excel")
{
    local source = import './source/source.libsonnet',	
    local sink   = import './sink/sink.libsonnet',	

    "source": source(SourceType, SourceFormat),
    "sink": sink(TargetType, TargetFormat),
    "enableStaging": false,
    "parallelCopies": {
        "value": "@pipeline().parameters.TaskObject.DegreeOfCopyParallelism",
        "type": "Expression"
    }
}