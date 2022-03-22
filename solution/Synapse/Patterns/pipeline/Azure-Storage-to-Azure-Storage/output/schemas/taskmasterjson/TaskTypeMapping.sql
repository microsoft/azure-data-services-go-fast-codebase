    BEGIN 
    Select * into #TempTTM from ( VALUES(-2, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Parquet', N'Azure Blob', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Parquet', N'ADLS', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Parquet', N'ADLS', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Parquet', N'Azure Blob', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Delta', N'Azure Blob', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Delta', N'ADLS', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Delta', N'ADLS', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Delta', N'Azure Blob', N'Delta', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Delta', N'Azure Blob', N'Parquet', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Delta', N'ADLS', N'Parquet', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Delta', N'ADLS', N'Parquet', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
',N'{}'),(-2, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Delta', N'Azure Blob', N'Parquet', NULL, 1,N'{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
                  "inputAttributes": {
                     "placeholder": "eg. AwSamp{
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
                  "infoText": "Path of the folder holding the delta table to be imported.",
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
                  "Delta"
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
