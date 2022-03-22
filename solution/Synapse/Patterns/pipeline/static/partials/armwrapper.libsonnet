

{        
    local armwrapper = self,
    pipeline:: error 'Must override pipeline',
    "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "EngineName": {
            "metadata": "The name of the data factory",
            "type": "String"
        },
        "integrationRuntimeShortName": {
            "metadata": "The short name of the integration runtime this pipeline uses",
            "type": "String"
        },
        "integrationRuntimeName": {
            "metadata": "The name of the integration runtime this pipeline uses",
            "type": "String"
        },
        "sharedKeyVaultUri": {
            "metadata": "The uri of the shared KeyVault",
            "type": "String"
        }
    },
    "resources": [
        {"apiVersion": "2018-06-01"}  + armwrapper.pipeline   
    ]
}