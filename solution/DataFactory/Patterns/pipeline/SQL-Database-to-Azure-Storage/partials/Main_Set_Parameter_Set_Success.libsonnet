function(referenceName="") 
{
    "name": "Set Variable TempOutput Success",
    "type": "SetVariable",
    "dependsOn": [
        {
            "activity": referenceName,
            "dependencyConditions": [
                "Succeeded"
            ]
        }
    ],
    "userProperties": [],
    "typeProperties": {
        "variableName": "TempOutput",
        "value": {
            "value": "@string(activity('"+referenceName+"').output)\n\n",
            "type": "Expression"
        }
    }
}