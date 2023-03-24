function()
 {
    "type": "object",
    "properties": {
        "Type": {
            "type": "string",
            "enum": [
                "dbt"
            ],
            "options": {
                "hidden": true
            },
            "default": "dbt",
        },
        "ExecutionCommand": {
            "type": "string",
            "enum": [
                "dbt build",
                "Test enum"
            ],
            "options": {
                "infoText": "(required) Use this field to select the command you wish to execute."
            },
        },
        "ExecutionParameters": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "TestPool"
                },
                "infoText": "(optional) Use this field to define any parameters / flags that go along with your command. NOTE: Certain characters not expected will be stripped from this string"
            }
        }
    },
    "options": {
        "hidden": true
    },
    "required": [
    ]
}