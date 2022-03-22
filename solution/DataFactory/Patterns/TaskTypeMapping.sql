    BEGIN 
    Select * into #TempTTM from ( VALUES(, N'ADF', N'GPL_AzureBlobFS_Binary_AzureBlobFS_Binary', N'ADLS', N'Binary', N'ADLS', N'Binary', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Binary_AzureBlobStorage_Binary', N'ADLS', N'Binary', N'Azure Blob', N'Binary', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobFS_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobFS_Json', N'ADLS', N'Csv', N'ADLS', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobFS_Parquet', N'ADLS', N'Csv', N'ADLS', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobStorage_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobStorage_Json', N'ADLS', N'Csv', N'Azure Blob', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_DelimitedText_AzureBlobStorage_Parquet', N'ADLS', N'Csv', N'Azure Blob', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobFS_DelimitedText', N'ADLS', N'Excel', N'ADLS', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobFS_Json', N'ADLS', N'Excel', N'ADLS', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobFS_Parquet', N'ADLS', N'Excel', N'ADLS', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobStorage_DelimitedText', N'ADLS', N'Excel', N'Azure Blob', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobStorage_Json', N'ADLS', N'Excel', N'Azure Blob', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Excel_AzureBlobStorage_Parquet', N'ADLS', N'Excel', N'Azure Blob', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobFS_DelimitedText', N'ADLS', N'Json', N'ADLS', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobFS_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobFS_Parquet', N'ADLS', N'Json', N'ADLS', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobStorage_DelimitedText', N'ADLS', N'Json', N'Azure Blob', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobStorage_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Json_AzureBlobStorage_Parquet', N'ADLS', N'Json', N'Azure Blob', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobFS_DelimitedText', N'ADLS', N'Parquet', N'ADLS', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobFS_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobFS_Json', N'ADLS', N'Parquet', N'ADLS', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobStorage_DelimitedText', N'ADLS', N'Parquet', N'Azure Blob', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobStorage_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobFS_Parquet_AzureBlobStorage_Json', N'ADLS', N'Parquet', N'Azure Blob', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobFS_Binary', N'Azure Blob', N'Binary', N'ADLS', N'Binary', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Binary_AzureBlobStorage_Binary', N'Azure Blob', N'Binary', N'Azure Blob', N'Binary', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "description": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Name of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. *.parquet"
                  }
               },
               "type": "string"
            },
            "DeleteAfterCompletion": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to remove the source file after a successsful copy."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "Recursively": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the framework to copy files from subfolders."
               },
               "type": "string"
            },
            "RelativePath": {
               "description": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
               "options": {
                  "infoText": "Path of the file to be copied. You can use pattern match characters eg. *. See https://docs.microsoft.com/en-us/azure/data-factory/connector-azure-blob-storage?tabs=data-factory#blob-storage-as-a-source-type",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Binary"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "Recursively",
            "MaxConcurrentConnections",
            "DeleteAfterCompletion",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobFS_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobFS_Json', N'Azure Blob', N'Csv', N'ADLS', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobFS_Parquet', N'Azure Blob', N'Csv', N'ADLS', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobStorage_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobStorage_Json', N'Azure Blob', N'Csv', N'Azure Blob', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_DelimitedText_AzureBlobStorage_Parquet', N'Azure Blob', N'Csv', N'Azure Blob', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobFS_DelimitedText', N'Azure Blob', N'Excel', N'ADLS', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobFS_Json', N'Azure Blob', N'Excel', N'ADLS', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobFS_Parquet', N'Azure Blob', N'Excel', N'ADLS', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobStorage_DelimitedText', N'Azure Blob', N'Excel', N'Azure Blob', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobStorage_Json', N'Azure Blob', N'Excel', N'Azure Blob', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Excel_AzureBlobStorage_Parquet', N'Azure Blob', N'Excel', N'Azure Blob', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobFS_DelimitedText', N'Azure Blob', N'Json', N'ADLS', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobFS_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobFS_Parquet', N'Azure Blob', N'Json', N'ADLS', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobStorage_DelimitedText', N'Azure Blob', N'Json', N'Azure Blob', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobStorage_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Json_AzureBlobStorage_Parquet', N'Azure Blob', N'Json', N'Azure Blob', N'Parquet', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobFS_DelimitedText', N'Azure Blob', N'Parquet', N'ADLS', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobFS_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobFS_Json', N'Azure Blob', N'Parquet', N'ADLS', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobStorage_DelimitedText', N'Azure Blob', N'Parquet', N'Azure Blob', N'Csv', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "Number of lines to skip."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Csv"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
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
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobStorage_Excel', N'', N'', N'', N'', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "FirstRowAsHeader": {
               "default": "true",
               "enum": [
                  "true",
                  "false"
               ],
               "options": {
                  "infoText": "Set to true if you want the first row of data to be used as column names."
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "SheetName": {
               "options": {
                  "infoText": "Name of the Excel Worksheet that you wish to import",
                  "inputAttributes": {
                     "placeholder": "eg. Sheet1"
                  }
               },
               "type": "string"
            },
            "SkipLineCount": {
               "default": 0,
               "options": {
                  "infoText": "The number of rows to skip or ignore in the incoming file."
               },
               "type": "integer"
            },
            "Type": {
               "enum": [
                  "Excel"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "FirstRowAsHeader",
            "SheetName",
            "SkipLineCount",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(, N'ADF', N'GPL_AzureBlobStorage_Parquet_AzureBlobStorage_Json', N'Azure Blob', N'Parquet', N'Azure Blob', N'Json', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Parquet"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer.xlsx"
                  }
               },
               "type": "string"
            },
            "MaxConcurrentConnections": {
               "default": 100,
               "options": {
                  "infoText": "The upper limit of concurrent connections established to the data store during the activity run. Specify a value only when you want to limit concurrent connections"
               },
               "type": "integer"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSample/dbo/Customer/{yyyy}/{MM}/{dd}/{hh}/"
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table. *Note that if you do not provide a schema file then the schema will be automatically inferred based on the source data.",
                  "inputAttributes": {
                     "placeholder": "eg. Customer_Schema.json"
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Json"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [
            "Type",
            "RelativePath",
            "DataFileName",
            "SchemaFileName",
            "MaxConcurrentConnections"
         ],
         "type": "object"
      }
   },
   "required": [
      "Source",
      "Target"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}')    ) a([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema])
    
    
    Update [dbo].[TaskTypeMapping]
    Set 
    MappingName = ttm2.MappingName,
    TaskMasterJsonSchema = ttm2.TaskMasterJsonSchema,
    TaskInstanceJsonSchema = ttm2.TaskInstanceJsonSchema
    from 
    [dbo].[TaskTypeMapping] ttm  
    inner join #TempTTM ttm2 on 
        ttm2.TaskTypeId = ttm.TaskTypeId 
        and ttm2.MappingType = ttm.MappingType
        and ttm2.SourceSystemType = ttm.SourceSystemType 
        and ttm2.SourceType = ttm.SourceType 
        and ttm2.TargetSystemType = ttm.TargetSystemType 
        and ttm2.TargetType = ttm.TargetType 

    Insert into 
    [dbo].[TaskTypeMapping]
    ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema])
    Select ttm2.* 
    from [dbo].[TaskTypeMapping] ttm  
    right join #TempTTM ttm2 on 
        ttm2.TaskTypeId = ttm.TaskTypeId 
        and ttm2.MappingType = ttm.MappingType
        and ttm2.SourceSystemType = ttm.SourceSystemType 
        and ttm2.SourceType = ttm.SourceType 
        and ttm2.TargetSystemType = ttm.TargetSystemType 
        and ttm2.TargetType = ttm.TargetType 
    where ttm.TaskTypeMappingId is null

    END 
