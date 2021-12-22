function() 
{"inputs":
[
  {
    "referenceName": "[concat('GDS_AzureBlobStorage_DelimitedText_', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
      "RelativePath": {
        "value": "@pipeline().parameters.TaskObject.Source.RelativePath",
        "type": "Expression"
      },
      "FileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
      },
      "StorageAccountEndpoint": {
        "value": "@pipeline().parameters.TaskObject.Source.StorageAccountName",
        "type": "Expression"
      },
      "StorageAccountContainerName": {
        "value": "@pipeline().parameters.TaskObject.Source.StorageAccountContainer",
        "type": "Expression"
      },
      "FirstRowAsHeader": {
        "value": "@pipeline().parameters.TaskObject.Source.FirstRowAsHeader",
        "type": "Expression"
      }
    }
  }
]
}

