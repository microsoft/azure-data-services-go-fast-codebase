function(GFPIR="IRA") {
    "value": "{PipelineName}",
    "activities": [
        {
            "name": "{ActivityName}",
            "type": "ExecutePipeline",
            "dependsOn": [],
            "userProperties": [],
            "typeProperties": {
                "pipeline": {
                    "referenceName": "{PipelineName}",
                    "type": "PipelineReference"
                },
                "waitOnCompletion": true,
                "parameters": {
                    "TaskObject": {
                        "value": "@pipeline().parameters.TaskObject",
                        "type": "Expression"
                    }
                }
            }
        }
    ]
}

