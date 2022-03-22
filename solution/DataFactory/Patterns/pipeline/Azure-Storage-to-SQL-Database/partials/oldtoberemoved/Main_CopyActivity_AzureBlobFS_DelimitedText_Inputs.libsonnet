function(GenerateArm=false,GFPIR="IRA")
{
local referenceName = "GDS_AzureBlobFS_DelimitedText_",
"inputs":
[
  {
    "referenceName":  if(GenerateArm=="false") 
                      then referenceName + GFPIR
                      else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
    "type": "DatasetReference",
    "parameters": {
      "RelativePath": {
        "value": "@pipeline().parameters.TaskObject.Source.Instance.SourceRelativePath",
        "type": "Expression"
      },
      "FileName": {
        "value": "@pipeline().parameters.TaskObject.Source.DataFileName",
        "type": "Expression"
      },
      "StorageAccountEndpoint": {
        "value": "@pipeline().parameters.TaskObject.Source.System.SystemServer",
        "type": "Expression"
      },
      "StorageAccountContainerName": {
        "value": "@pipeline().parameters.TaskObject.Source.System.Container",
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
