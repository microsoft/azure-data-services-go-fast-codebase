function(GenerateArm=false,SparkPoolName = "")
{


    "notebook": {
        "referenceName": {
                "value": "@if(contains(string(pipeline().parameters.TaskObject), 'ExecuteNotebook'), string(json(string(pipeline().parameters.TaskObject)).TMOptionals.ExecuteNotebook), string(json(string(pipeline().parameters.TaskObject)).ExecutionEngine.JsonProperties.DeltaProcessingNotebook))",
                "type": "Expression"
            },
            "type": "NotebookReference"
        
    },

    "parameters": {
        "TaskObject": {
            "value": {
                "value": "@string(pipeline().parameters.TaskObject)",
                "type": "Expression"
            },
            "type": "string"
        }
    },
    "snapshot": true,
    "sparkPool": {
        "referenceName": SparkPoolName,
        "type": "BigDataPoolReference"
    }
}