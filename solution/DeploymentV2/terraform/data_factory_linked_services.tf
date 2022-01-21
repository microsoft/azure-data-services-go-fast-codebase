locals {
  linkedservice_azure_function_name     = "SLS_AzureFunctionApp"
  linkedservice_keyvault_name           = "SLS_AzureKeyVault"
  linkedservice_generic_kv_prefix       = "GLS_AzureKeyVault_"
  linkedservice_generic_adls_prefix     = "GLS_AzureBlobFS_"
  linkedservice_generic_blob_prefix     = "GLS_AzureBlobStorage_"
  linkedservice_generic_azuresql_prefix = "GLS_AzureSqlDatabase_"
  linkedservice_generic_azuresynapse_prefix= "GLS_AzureSynapse_"
  linkedservice_generic_mssql_prefix    = "GLS_SqlServerDatabase_"
  linkedservice_generic_file_prefix     = "GLS_FileServer_"
}

#Azure KeyVault - Non Generic
resource "azurerm_data_factory_linked_service_key_vault" "key_vault_default" {
  name                = local.linkedservice_keyvault_name
  description         = "Default Key Vault (Non-Dynamic)"
  resource_group_name = var.resource_group_name
  data_factory_id     = azurerm_data_factory.data_factory.id
  key_vault_id        = azurerm_key_vault.app_vault.id
}

#Azure Function - Non Generic
resource "azurerm_data_factory_linked_service_azure_function" "function_app" {
  name                = local.linkedservice_azure_function_name
  resource_group_name = var.resource_group_name
  data_factory_id     = azurerm_data_factory.data_factory.id
  url                 = local.functionapp_url
  key_vault_key {
    linked_service_name = azurerm_data_factory_linked_service_key_vault.key_vault_default.name
    secret_name         = "AdsGfCoreFunctionAppKey"
  }
}


#------------------------------------------------------------------------------------------------------
# Generic Linked Services (1 per Integration Runtime)
#------------------------------------------------------------------------------------------------------
resource "azurerm_data_factory_linked_custom_service" "generic_kv" {
  for_each             = { 
    for ir in local.integration_runtimes : 
    ir.short_name => ir 
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
    }
  name                 = "${local.linkedservice_generic_kv_prefix}${each.value.short_name}"
  data_factory_id      = azurerm_data_factory.data_factory.id
  type                 = "AzureKeyVault"
  description          = "Generic Key Vault"
  type_properties_json = <<JSON
    {
			"baseUrl": "@{linkedService().KeyVaultBaseUrl}"
		}
JSON
  parameters = {
    KeyVaultBaseUrl = "https://${local.key_vault_name}.vault.azure.net/"
  }
  integration_runtime {
    name = each.value.name
  }
  depends_on = [
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}

resource "azurerm_data_factory_linked_custom_service" "data_lake" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
  }
  name                 = "${local.linkedservice_generic_adls_prefix}${each.value.short_name}"
  data_factory_id      = azurerm_data_factory.data_factory.id
  type                 = "AzureBlobFS"
  description          = "Generic Data Lake"
  type_properties_json = <<JSON
    {
			"url": "@{linkedService().StorageAccountEndpoint}"
		}
JSON
  parameters = {
    StorageAccountEndpoint = ""
  }
  integration_runtime {
    name = each.value.name
  }
  depends_on = [
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}

resource "azurerm_data_factory_linked_custom_service" "blob" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
  }
  name                 = "${local.linkedservice_generic_blob_prefix}${each.value.short_name}"
  data_factory_id      = azurerm_data_factory.data_factory.id
  type                 = "AzureBlobStorage"
  description          = "Generic Blob Storage"
  type_properties_json = <<JSON
    {
			"serviceEndpoint": "@{linkedService().StorageAccountEndpoint}"
		}
JSON
  parameters = {
    StorageAccountEndpoint = ""
  }
  integration_runtime {
    name = each.value.name
  }
  depends_on = [
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}

resource "azurerm_data_factory_linked_custom_service" "database" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
  }
  name            = "${local.linkedservice_generic_azuresql_prefix}${each.value.short_name}"
  description     = "Generic Azure SQL Server"
  type            = "AzureSqlDatabase"
  data_factory_id = azurerm_data_factory.data_factory.id
  integration_runtime {
    name = each.value.name
  }
  type_properties_json = <<JSON
    {
			"connectionString": "Integrated Security=False;Encrypt=True;Connection Timeout=30;Data Source=@{linkedService().Server};Initial Catalog=@{linkedService().Database}"
		}
JSON
  parameters = {
    Server   = ""
    Database = ""
  }
  depends_on = [
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}

resource "azurerm_data_factory_linked_custom_service" "synapse" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if ir.is_azure == true
  }
  name            = "${local.linkedservice_generic_azuresynapse_prefix}${each.value.short_name}"
  description     = "Generic Azure Synapse"
  type            = "AzureSqlDW"
  data_factory_id = azurerm_data_factory.data_factory.id
  integration_runtime {
    name = each.value.name
  }
  type_properties_json = <<JSON
    {
			"connectionString": "Integrated Security=False;Encrypt=True;Connection Timeout=30;Data Source=@{linkedService().Server};Initial Catalog=@{linkedService().Database}"
		}
JSON
  parameters = {
    Server   = ""
    Database = ""
  }
  depends_on = [
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}

resource "azurerm_data_factory_linked_custom_service" "mssqldatabase" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
  }
  name            = "${local.linkedservice_generic_mssql_prefix}${each.value.short_name}"
  data_factory_id = azurerm_data_factory.data_factory.id
  type            = "SqlServer"
  description     = "Generic SqlServer"
  integration_runtime {
    name = each.value.name
  }
  type_properties_json = <<JSON
{
			"connectionString": "Integrated Security=False;Data Source=@{linkedService().Server};Initial Catalog=@{linkedService().Database};User ID=@{linkedService().UserName}",
			"password": {
				"type": "AzureKeyVaultSecret",
				"store": {
					"referenceName": "${local.linkedservice_generic_kv_prefix}${each.value.short_name}",
					"type": "LinkedServiceReference",
					"parameters": {
						"KeyVaultBaseUrl": {
							"value": "@linkedService().KeyVaultBaseUrl",
							"type": "Expression"
						}
					}
				},
				"secretName": {
					"value": "@linkedService().PasswordSecret",
					"type": "Expression"
				}
			}
		}
JSON
  parameters = {
    Server          = ""
    Database        = ""
    KeyVaultBaseUrl = ""
    PasswordSecret  = ""
    UserName        = ""
  }
  depends_on = [
    azurerm_data_factory_linked_custom_service.generic_kv,
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}


resource "azurerm_data_factory_linked_custom_service" "file" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
  }
  name            = "${local.linkedservice_generic_file_prefix}${each.value.short_name}"
  data_factory_id = azurerm_data_factory.data_factory.id
  type            = "FileServer"
  description     = "Generic File Server"
  integration_runtime {
    name = each.value.name
  }
  type_properties_json = <<JSON
{
			"host": "@{linkedService().Host}",
			"userId": "@{linkedService().UserId}",
			"password": {
				"type": "AzureKeyVaultSecret",
				"store": {
					"referenceName": "${local.linkedservice_generic_kv_prefix}${each.value.short_name}",
					"type": "LinkedServiceReference",
					"parameters": {
						"KeyVaultBaseUrl": {
							"value": "@linkedService().KeyVaultBaseUrl",
							"type": "Expression"
						}
					}
				},
				"secretName": {
					"value": "@linkedService().Secret",
					"type": "Expression"
				}
			}
		}
JSON
  parameters = {
    "Host" : ""
    "UserId" : ""
    "Secret" : ""
    "KeyVaultBaseUrl" : ""
  }
  depends_on = [
    azurerm_data_factory_linked_custom_service.generic_kv,
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}

resource "azurerm_data_factory_linked_custom_service" "synapse" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if (ir.is_azure == true) || (ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
  }
  name            = "${local.linkedservice_generic_synapse_prefix}${each.value.short_name}"
  data_factory_id = azurerm_data_factory.data_factory.id
  type            = "AzureSqlDW"
  description     = "Generic Azure Synapse Connection"
  integration_runtime {
    name = each.value.name
  }
type_properties_json = <<JSON
    {
			"connectionString": "Integrated Security=False;Encrypt=True;Connection Timeout=30;Data Source=@{linkedService().Server};Initial Catalog=@{linkedService().Database}"
		}
JSON
  parameters = {
    Server   = ""
    Database = ""
  }
  depends_on = [
    azurerm_data_factory_linked_custom_service.generic_kv,
    azurerm_data_factory_integration_runtime_azure.azure_ir,
    azurerm_data_factory_integration_runtime_self_hosted.self_hosted_ir
  ]
}
