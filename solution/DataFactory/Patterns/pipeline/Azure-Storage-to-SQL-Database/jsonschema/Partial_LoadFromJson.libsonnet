function() 
{
            "type": "object",
            "properties": {
                "Type": {
                    "type": "string",                    
                    "enum": [
                        "Json"
                    ], 
                    "options":{
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
                    "type": "string",             
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. Customer_Schema.json"
                        },
                        "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data."
                    }
                },
                "MaxConcurrentConnections": {
                    "type": "integer",
                    "default": 10,                                       
                    "options": {                        
                        "infoText": ""
                    }
                }
            },
            "required": [
                "Type",
                "RelativePath",
                "DataFileName",
                "SchemaFileName",
                "MaxConcurrentConnections"
            ]
        
}