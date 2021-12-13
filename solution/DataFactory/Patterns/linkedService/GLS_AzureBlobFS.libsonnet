function(GFPIR="IRA")
{
	"name": "GLS_AzureBlobFS_" + GFPIR,
	"type": "Microsoft.DataFactory/factories/linkedservices",
	"properties": {
		"type": "AzureBlobFS",
		"parameters": {
			"StorageAccountEndpoint": {
				"type": "String",
				"defaultValue": ""
			}
		},
		"typeProperties": {
			"url": "@{linkedService().StorageAccountEndpoint}"
		},
		"annotations": [],
		"connectVia": {
			"referenceName": GFPIR,
			"type": "IntegrationRuntimeReference"
		}
	}
}