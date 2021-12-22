function(GenerateArm=false,GFPIR="IRA")
{
local referenceName = "GDS_AzureBlobStorage_Excel_",
"inputs":
[
  {
          "referenceName":  if(GenerateArm=="false") 
                      then referenceName + GFPIR
                      else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
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
          "SheetName": {
              "value": "@pipeline().parameters.TaskObject.Source.SheetName",
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