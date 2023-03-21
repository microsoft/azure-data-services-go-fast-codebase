function(GenerateArm="false",GFPIR="IRA") 
[{ 
    local referenceName = "GDS_OracleServerTable_NA_",   
    "referenceName":if(GenerateArm=="false") 
                    then referenceName + GFPIR
                    else "[concat('"+referenceName+"', parameters('integrationRuntimeShortName'))]",   
    "type": "DatasetReference",
    "parameters": {
        "Host": {
            "value": "@pipeline().parameters.TaskObject.Source.System.SystemServer",
            "type": "Expression"
        },
        "Port": {
            "value": "@pipeline().parameters.TaskObject.Source.System.Port",
            "type": "Expression"
        },
        "ServiceName": {
            "value": "@pipeline().parameters.TaskObject.Source.System.ServiceName",
            "type": "Expression"
        },
        "UserName": {
            "value": "@pipeline().parameters.TaskObject.Source.System.Username",
            "type": "Expression"
        },
        "KeyVaultBaseUrl": {
            "value": "@pipeline().parameters.TaskObject.KeyVaultBaseUrl",
            "type": "Expression"
        },
        "Secret": {
            "value": "@pipeline().parameters.TaskObject.Source.System.SecretName",
            "type": "Expression"
        },
        "TableSchema": {
            "value": "@pipeline().parameters.TaskObject.Source.TableSchema",
            "type": "Expression"
        },
        "TableName": {
            "value": "@pipeline().parameters.TaskObject.Source.TableName",
            "type": "Expression"
        }
    }
}]
