function() 
{
  "Source": {
            "type": "object",
            "properties": {
                "Type": {
                    "type": "string",                    
                    "enum": [
                        "Table",
                        "SQL"
                    ],
                    "options": {
                        "hidden":true,
                        "infoText": "Select TABLE if you want to select all columns in a table. Select SQL if you want to define a custom SQL statement to be used to extract data."
                    }
                },
                "IncrementalType": {
                    "type": "string",
                    "description": "Full Extraction or Incremental based on a Watermark Column",
                    "enum": [
                        "Full",
                        "Watermark"
                    ],
                    "options": {
                        "infoText": "Select Full for Full Table Extraction & Watermark for Incremental based on a Watermark column"
                    },
                    "default":"Table"
                },
                "ExtractionSQL": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. Select top 100 * from Customer"
                        },
                        "infoText": "A custom SQL statement that you wish to be used to extract the data. **Note that this is ignored if the Source Type is 'Table'"
                    },
                    "default":""
                },
                "TableSchema": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. dbo"
                        }, 
                        "infoText": "The schema of the table to extract. **Note that this is ignored if the Source Type is 'SQL'"
                    },
                    "default":""

                },
                "TableName": {
                    "type": "string",
                    "options": {                        
                        "inputAttributes": {
                            "placeholder": "eg. Customer"
                        }, 
                        "infoText": "The name of the table to extract. **Note that this is ignored if the Source Type is 'SQL'"
                    },
                    "default":""
                },
                "ChunkField": {
                    "type": "string",
                    "options": {
                        "inputAttributes": {
                            "placeholder": "eg. Customer Id"
                        },
                        "infoText": "If you want to break an extraction down into multiple files fill out the chunk fields. Otherwise leave blank."
                    },
                    "default":""
                },
                "ChunkSize": {
                    "type": "integer",
                    "options": {
                        "inputAttributes": {
                            "placeholder": 0                        
                        },                        
                        "infoText": "Number of rows to use for each 'chunk' of data."
                    },
                    "default": 0
                }
            },
            "required": [
                "Type",
                "IncrementalType"
            ]
        }
}