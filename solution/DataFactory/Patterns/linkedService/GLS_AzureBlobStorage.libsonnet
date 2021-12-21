function(GFPIR="IRA")
{
    "name": "GLS_AzureBlobStorage_" + GFPIR,
    "type": "Microsoft.DataFactory/factories/linkedservices",
    "properties": {
        "type": "AzureBlobStorage",
        "parameters": {
            "StorageAccountEndpoint": {
                "type": "String",
                "defaultValue": ""
            }
        },
        "typeProperties": {
            "serviceEndpoint": "@{linkedService().StorageAccountEndpoint}"
        },
        "annotations": [],
        "connectVia": {
            "referenceName": GFPIR,
            "type": "IntegrationRuntimeReference"
        }
    }
}
