function(GFPIR="IRA") 
[
  {
    "referenceName": "GDS_AzureBlobFS_DelimitedText_" + GFPIR,
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
