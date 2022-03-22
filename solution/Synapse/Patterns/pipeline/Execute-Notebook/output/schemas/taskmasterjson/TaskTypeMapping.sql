    BEGIN 
    Select * into #TempTTM from ( VALUES(-5, N'ADF', N'GPL_SparkNotebookExecution', N'N/A', N'Notebook-Optional', N'ADLS', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'N/A', N'Notebook-Optional', N'Azure Blob', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'N/A', N'Notebook-Optional', N'Azure SQL', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'N/A', N'Notebook-Optional', N'Azure Synapse', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'N/A', N'Notebook-Optional', N'SQL Server', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'N/A', N'Notebook-Optional', N'N/A', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Notebook-Optional', N'ADLS', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Notebook-Optional', N'Azure Blob', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Notebook-Optional', N'Azure SQL', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Notebook-Optional', N'Azure Synapse', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Notebook-Optional', N'SQL Server', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Blob', N'Notebook-Optional', N'N/A', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Notebook-Optional', N'ADLS', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Notebook-Optional', N'Azure Blob', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Notebook-Optional', N'Azure SQL', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Notebook-Optional', N'Azure Synapse', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Notebook-Optional', N'SQL Server', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'ADLS', N'Notebook-Optional', N'N/A', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure SQL', N'Notebook-Optional', N'ADLS', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure SQL', N'Notebook-Optional', N'Azure Blob', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure SQL', N'Notebook-Optional', N'Azure SQL', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure SQL', N'Notebook-Optional', N'Azure Synapse', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure SQL', N'Notebook-Optional', N'SQL Server', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure SQL', N'Notebook-Optional', N'N/A', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Synapse', N'Notebook-Optional', N'ADLS', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Synapse', N'Notebook-Optional', N'Azure Blob', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Synapse', N'Notebook-Optional', N'Azure SQL', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Synapse', N'Notebook-Optional', N'Azure Synapse', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Synapse', N'Notebook-Optional', N'SQL Server', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'Azure Synapse', N'Notebook-Optional', N'N/A', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'SQL Server', N'Notebook-Optional', N'ADLS', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'SQL Server', N'Notebook-Optional', N'Azure Blob', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'SQL Server', N'Notebook-Optional', N'Azure SQL', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'SQL Server', N'Notebook-Optional', N'Azure Synapse', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'SQL Server', N'Notebook-Optional', N'SQL Server', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
   ],
   "title": "TaskMasterJson",
   "type": "object"
}
',N'{}'),(-5, N'ADF', N'GPL_SparkNotebookExecution', N'SQL Server', N'Notebook-Optional', N'N/A', N'Notebook-Optional', NULL, 1,N'{
   "$schema": "http://json-schema.org/draft-04/schema#",
   "properties": {
      "CustomDefinitions": {
         "options": {
            "infoText": "Use this field to create fields to use in your notebook from the TaskObject.",
            "inputAttributes": {
               "placeholder": ""
            }
         },
         "type": "string"
      },
      "ExecuteNotebook": {
         "options": {
            "infoText": "Use this field to define the name of the notebook to execute.",
            "inputAttributes": {
               "placeholder": "DeltaProcessingNotebook"
            }
         },
         "type": "string"
      },
      "Source": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      },
      "Target": {
         "properties": {
            "DataFileName": {
               "options": {
                  "infoText": "Name of the file to be imported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "RelativePath": {
               "options": {
                  "infoText": "Path of the folder holding the file to be imported/exported.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "SchemaFileName": {
               "options": {
                  "infoText": "Name of the schema file to use when generating the target table.",
                  "inputAttributes": {
                     "placeholder": "Note: This field is completely optional to use for values to place into the TaskObject passed into the Notebook."
                  }
               },
               "type": "string"
            },
            "Type": {
               "enum": [
                  "Notebook-Optional"
               ],
               "options": {
                  "hidden": true
               },
               "type": "string"
            }
         },
         "required": [ ],
         "type": "object"
      }
   },
   "required": [
      "ExecuteNotebook",
      "CustomDefinitions"
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
