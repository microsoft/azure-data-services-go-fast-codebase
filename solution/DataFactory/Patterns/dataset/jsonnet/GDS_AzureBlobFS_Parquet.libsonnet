function(GFPIR="IRA") {
	"name": "GDS_AzureBlobFS_Parquet_" + GFIR,
	"properties": {
		"linkedServiceName": {
			"referenceName": "GLS_AzureBlobFS_" + GFIR,
			"type": "LinkedServiceReference",
			"parameters": {
				"StorageAccountEndpoint": {
					"value": "@dataset().StorageAccountEndpoint",
					"type": "Expression"
				}
			}
		},
		"parameters": {
			"RelativePath": {
				"type": "string"
			},
			"FileName": {
				"type": "string"
			},
			"StorageAccountEndpoint": {
				"type": "string"
			},
			"StorageAccountContainerName": {
				"type": "string"
			}
		},
		"folder": {
			"name": "ADS Go Fast/Generic/" + GFIR
		},
		"annotations": [],
		"type": "Parquet",
		"typeProperties": {
			"location": {
				"type": "AzureBlobFSLocation",
				"fileName": {
					"value": "@dataset().FileName",
					"type": "Expression"
				},
				"folderPath": {
					"value": "@dataset().RelativePath",
					"type": "Expression"
				},
				"fileSystem": {
					"value": "@dataset().StorageAccountContainerName",
					"type": "Expression"
				}
			},
			"compressionCodec": "gzip"
		},
		"schema": []
	},
	"type": "Microsoft.DataFactory/factories/datasets"
}

