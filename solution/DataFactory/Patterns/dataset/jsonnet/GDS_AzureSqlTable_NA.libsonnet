function(GFPIR="IRA") {
	"name": "GDS_AzureSqlTable_NA_" + GFIR,
	"properties": {
		"linkedServiceName": {
			"referenceName": "GLS_AzureSqlDatabase_" + GFIR,
			"type": "LinkedServiceReference",
			"parameters": {
				"Server": {
					"value": "@dataset().Server",
					"type": "Expression"
				},
				"Database": {
					"value": "@dataset().Database",
					"type": "Expression"
				}
			}
		},
		"parameters": {
			"Schema": {
				"type": "string"
			},
			"Table": {
				"type": "string"
			},
			"Server": {
				"type": "string"
			},
			"Database": {
				"type": "string"
			}
		},
		"folder": {
			"name": "ADS Go Fast/Generic/" + GFIR
		},
		"annotations": [],
		"type": "AzureSqlTable",
		"schema": [],
		"typeProperties": {
			"schema": {
				"value": "@dataset().Schema",
				"type": "Expression"
			},
			"table": {
				"value": "@dataset().Table",
				"type": "Expression"
			}
		}
	},
	"type": "Microsoft.DataFactory/factories/datasets"
}

