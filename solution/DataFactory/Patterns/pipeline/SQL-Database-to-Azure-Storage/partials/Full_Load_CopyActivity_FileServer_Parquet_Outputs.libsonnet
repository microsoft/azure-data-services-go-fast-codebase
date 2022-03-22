function(GenerateArm="false",GFPIR="IRA") 
{
  "outputs": [
    {
      local referenceName = "GDS_FileServer_Parquet_",
      "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",
      "type": "DatasetReference",
      "parameters": {
        "Directory": {
            "value": "@pipeline().parameters.TaskObject.Target.RelativePath",
            "type": "Expression"
        },
        "File": {
            "value": "@pipeline().parameters.TaskObject.Target.DataFileName",
            "type": "Expression"
        },
        "Host": {
            "value": "@pipeline().parameters.TaskObject.Target.System.SystemServer",
            "type": "Expression"
        },
        "KeyVaultBaseUrl": {
            "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
            "type": "Expression"
        },
        "Secret": {
            "value": "@pipeline().parameters.TaskObject.Target.System.PasswordKeyVaultSecretName",
            "type": "Expression"
        },
        "UserId": {
            "value": "@pipeline().parameters.TaskObject.Target.System.Username",
            "type": "Expression"
        }
      }
    }
  ]
}