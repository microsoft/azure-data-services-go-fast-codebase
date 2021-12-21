function() 
{
  "Target": {
      "type": "object",
      "properties": {
          "Type": {
              "type": "string",                    
              "enum": [
                  "Table"
              ], 
              "options": {
                  "hidden": true
              }
          },
          "StagingTableSchema": {
              "type": "string",
              "options": {
                  "inputAttributes": {
                      "placeholder": "eg. dbo"
                  },
                  "infoText": "Schema for the transient table in which data will first be staged before being merged into final target table."
              }
          },
          "StagingTableName": {
              "type": "string",
              "options": {
                  "inputAttributes": {
                      "placeholder": "eg. StgCustomer"
                  },
                  "infoText": "Table name for the transient table in which data will first be staged before being merged into final target table."
              }
          },
          "AutoCreateTable": {
              "type": "string",
              "enum": [
                  "true",
                  "false"
              ],
              "default": "true",
              "options": {
                  "infoText": "Set to true if you want the framework to automatically create the target table if it does not exist. If this is false and the target table does not exist then the task will fail with an error."
              }
          },
          "TableSchema": {
              "type": "string",
              "options": {
                  "inputAttributes": {
                      "placeholder": "eg. dbo"
                  },
                  "infoText": "Schema of the final target table. Note that this must exist in the target database as it will not be autogenerated."
              }
          },
          "TableName": {
              "type": "string",
              "options": {
                  "inputAttributes": {
                      "placeholder": "eg. Customer"
                  },
                  "infoText": "Name of the final target table."
              }
          },
          "PreCopySQL": {
              "type": "string",
              "options": {
                  "inputAttributes": {
                      "placeholder": "eg. Delete from dbo.StgCustomer where Active = 0"
                  },
                  "infoText": "A SQL statement that you wish to be applied prior to merging the staging table and the final table"
              }
          },
          "PostCopySQL": {
              "type": "string",
              "options": {
                  "inputAttributes": {
                      "placeholder": "eg. Delete from dbo.Customer where Active = 0"
                  },
                  "infoText": "A SQL statement that you wish to be applied after merging the staging table and the final table"
              }
          },
          "AutoGenerateMerge": {
              "type": "string",
              "enum": [
                  "true",
                  "false"
              ],
              "default": "true",
              "options": {
                  "infoText": "Set to true if you want the framework to autogenerate the merge based on the primary key of the target table."
              }
          },
          "MergeSQL": {
              "type": "string",
              "format": "sql",
              "options": {
                  "infoText": "A custom merge statement to exectute. Note that this will be ignored if 'AutoGenerateMerge' is true. Click in the box below to view or edit ",
                  "ace": {
                      "tabSize": 2,
                      "useSoftTabs": true,
                      "wrap": true
                  }
              }
          }
      },
      "required": [
          "Type",
          "StagingTableSchema",
          "StagingTableName",
          "AutoCreateTable",
          "TableSchema",
          "TableName",
          "PreCopySQL",
          "PostCopySQL",
          "AutoGenerateMerge"
      ]
  }
}