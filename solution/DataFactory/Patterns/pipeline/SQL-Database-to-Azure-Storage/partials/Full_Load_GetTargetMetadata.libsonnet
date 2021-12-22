function(GenerateArm="false",GFPIR="IRA", TargetType, TargetFormat) 
if (TargetType=="AzureBlobFS"&&TargetFormat=="Parquet") then
{
  local referenceName = "GDS_AzureBlobFS_Parquet_",
  "dataset": {    
    "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",   
    "type": "DatasetReference",
    "parameters": {
      "RelativePath": {
        "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
        "type": "Expression"
      },
      "FileName": {
        "value": "@replace(pipeline().parameters.TaskObject.Target.DataFileName,'.parquet',concat('.chunk_', string(pipeline().parameters.Item),'.parquet'))",
        "type": "Expression"
      },
      "StorageAccountEndpoint": {
        "value": "@pipeline().parameters.TaskObject.Target.StorageAccountName",
        "type": "Expression"
      },
      "StorageAccountContainerName": {
        "value": "@pipeline().parameters.TaskObject.Target.StorageAccountContainer",
        "type": "Expression"
      }
    }
  },
  "fieldList": [
    "structure"
  ],
  "storeSettings": {
    "type": "AzureBlobFSReadSettings",
    "recursive": true
  }
}
else if (TargetType=="AzureBlobStorage"&&TargetFormat=="Parquet") then
{
  local referenceName = "GDS_AzureBlobStorage_Parquet_",
  "dataset": {    
    "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",   
    "type": "DatasetReference",
    "parameters": {
      "RelativePath": {
        "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
        "type": "Expression"
      },
      "FileName": {
        "value": "@replace(pipeline().parameters.TaskObject.Target.DataFileName,'.parquet',concat('.chunk_', string(pipeline().parameters.Item),'.parquet'))",
        "type": "Expression"
      },
      "StorageAccountEndpoint": {
        "value": "@pipeline().parameters.TaskObject.Target.StorageAccountName",
        "type": "Expression"
      },
      "StorageAccountContainerName": {
        "value": "@pipeline().parameters.TaskObject.Target.StorageAccountContainer",
        "type": "Expression"
      }
    }
  },
  "fieldList": [
    "structure"
  ],
  "storeSettings": {
    "type": "AzureBlobFSReadSettings",
    "recursive": true
  }
}
else 
  error 'Full_Load_GetTargetMetadata.libsonnet failed. No mapping for:' +GFPIR+","+TargetType+","+TargetFormat

