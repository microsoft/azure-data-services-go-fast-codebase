function(referenceName="") 
{
    "name": "Set Variable TempOutput Fail",
    "type": "SetVariable",
    "dependsOn": [
        {
            "activity": referenceName,
            "dependencyConditions": [
                "Failed"
            ]
        }
    ],
    "userProperties": [],
    "typeProperties": {
        "variableName": "TempOutput",
        "value": {
            "value": "@string(activity('"+referenceName+"').error.message)",
            "type": "Expression"
        }
    }
}
