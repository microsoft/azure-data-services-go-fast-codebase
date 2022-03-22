function()
 {
    "type": "object",
    "properties": {
        "Type": {
            "type": "string",
            "enum": [
                "Notebook-Optional"
            ],
            "options": {
                "hidden": true
            }
        },
        "RelativePath": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                },
                "infoText": "Path of the folder holding the file to be imported/exported."
            }
        },
        "DataFileName": {
            "type": "string",
            "options": {
                "inputAttributes": {
                    "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                },
                "infoText": "Name of the file to be imported."
            }
        },
        "SchemaFileName": {
            "type": "string",             
            "options": {
                "inputAttributes": {
                    "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                },
                "infoText": "Name of the schema file to use when generating the target table."
            }
        } 
    },
    "required": [
    ]
}