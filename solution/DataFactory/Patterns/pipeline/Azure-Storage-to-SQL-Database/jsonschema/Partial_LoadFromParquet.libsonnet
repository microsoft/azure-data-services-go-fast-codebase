function()
{
    "Source": {
            "type": "object",
            "properties": {
                "Type": {
                    "type": "string",
                    "enum": [
                        "Parquet"
                    ],
                    "options": {
                        "hidden": true
                    }
                },
                "RelativePath": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                        },
                        "infoText": "Path of the file to be imported."
                    }
                },
                "DataFileName": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. Customer.xlsx"
                        },
                        "infoText": "Name of the file to be imported."
                    }
                },
                "SchemaFileName": {
                    "type": "string"
                }
            },
            "required": [
                "Type",
                "RelativePath",
                "DataFileName",
                "SchemaFileName"
            ]
        }
}