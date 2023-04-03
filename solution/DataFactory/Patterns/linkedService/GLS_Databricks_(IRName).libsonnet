function(shortIRName = "", fullIRName = "")
{
    "name": "GLS_AzureDatabricks_" + shortIRName,
    "type": "Microsoft.DataFactory/factories/linkedservices",
    "properties": {
        "connectVia": {
            "referenceName": fullIRName,
            "type": "IntegrationRuntimeReference"
        },
        "description": "Generic Azure Databricks Connection",
        "parameters": {
            "ClusterNodeType": {
                "type": "String",
                "defaultValue": "Standard_DS3_v2"
            },
            "ClusterVersion": {
                "type": "String",
                "defaultValue": "12.2.x-scala2.12"
            },
            "DatabricksWorkspaceURL": {
                "type": "String",
                "defaultValue": ""
            },
            "InstancePool": {
                "type": "String",
                "defaultValue": ""
            },
            "Workers": {
                "type": "String",
                "defaultValue": "3"
            },
            "WorkspaceResourceID": {
                "type": "String",
                "defaultValue": ""
            }
        },
        "type": "AzureDatabricks",
        "typeProperties": {
            "accessToken": null,
            "authentication": "MSI",
            "domain": "@linkedService().DatabricksWorkspaceURL",
            "instancePoolId": "@linkedService().InstancePool",
            "newClusterInitScripts": [],
            "newClusterNodeType": "@linkedService().ClusterNodeType",
            "newClusterNumOfWorker": "@linkedService().Workers",
            "newClusterSparkEnvVars": {
                "PYSPARK_PYTHON": "/databricks/python3/bin/python3"
            },
            "newClusterVersion": "@linkedService().ClusterVersion",
            "workspaceResourceId": "@linkedService().WorkspaceResourceID"
        },
        "annotations": []
    }
}