function(GenerateArm="false",GFPIR="IRA") 
{
  "outputs": [
    {
      local referenceName = "GDS_AzureBlobFS_Parquet_",
      "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
      "type": "DatasetReference",
      "parameters": {
        "RelativePath": {
          "value": "@pipeline().parameters.TaskObject.Target.Instance.TargetRelativePath",
          "type": "Expression"
        },
        "FileName": {
          "value": "@if(equals(pipeline().parameters.TaskObject.Source.ChunkSize,0),\n    pipeline().parameters.TaskObject.Target.DataFileName,\n    replace(\n        pipeline().parameters.TaskObject.Target.DataFileName,\n        '.parquet',\n        concat('.chunk_', string(pipeline().parameters.Item),'.parquet')\n    )\n)",
          "type": "Expression"
        },
        "StorageAccountEndpoint": {
          "value": "@pipeline().parameters.TaskObject.Target.System.SystemServer",
          "type": "Expression"
        },
        "StorageAccountContainerName": {
          "value": "@pipeline().parameters.TaskObject.Target.System.Container",
          "type": "Expression"
        }
      }
    }
  ]
}