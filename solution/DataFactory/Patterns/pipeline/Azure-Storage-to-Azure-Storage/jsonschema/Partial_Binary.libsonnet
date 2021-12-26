function()
{
    "type": "object",
    "properties": {
        "Type": {
            "type": "string",
            "enum": [
                "Binary"
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
        }
    },
    "required": [
        "Type",
        "RelativePath",
        "DataFileName",
        "MaxConcorrentConnections",
        "DeleteAfterCompletion"
    ]
}
