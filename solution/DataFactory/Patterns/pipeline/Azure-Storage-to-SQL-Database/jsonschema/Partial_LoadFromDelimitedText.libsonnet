function() 
{
            "type": "object",
            "properties": {
                "Type": {
                    "type": "string",                    
                    "enum": [
                        "Csv"
                    ], 
                    "options" : {
                        "hidden": true
                    }
                },
                "RelativePath": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                        },
                        "infoText": "(optional) Path of the file to be imported."
                    }
                },
                "DataFileName": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. Customer.xlsx"
                        },
                        "infoText": "(required) Name of the file to be imported."
                    }
                },
                "SchemaFileName": {
                    "type": "string",             
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. Customer_Schema.json"
                        },
                        "infoText": "(required) Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data."
                    }
                },
                "SkipLineCount": {
                    "type": "integer",                    
                    "default": 0,
                    "options": {                        
                        "infoText": "(required) Number of lines to skip."
                    }
                },
                "FirstRowAsHeader": {
                    "type": "string",
                    "enum": [
                        "true",
                        "false"
                    ],
                    "default": "true",
                    "options": {                        
                        "infoText": "(required) Set to true if you want the first row of data to be used as column names."
                    }
                },         
                "Delimiter": {
                    "type": "string",            
                    "default": ",",
                    "options": {                        
                        "infoText": "The delimiter character or string."
                    }
                }, 
                "MaxConcurrentConnections": {
                    "type": "integer",
                    "default": 100,
                    "options": {                        
                        "infoText": "(required) The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
                    }
                }                
            },
            "required": [
                "Type",
                "RelativePath",
                "DataFileName",
                "SchemaFileName",
                "SkipLineCount",
                "FirstRowAsHeader",
                "MaxConcurrentConnections"
            ]
 
}