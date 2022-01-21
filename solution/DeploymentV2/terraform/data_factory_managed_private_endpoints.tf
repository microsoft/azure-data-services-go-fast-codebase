resource "azurerm_data_factory_managed_private_endpoint" "blob" {
  count              = var.deploy_storage_account && var.is_vnet_isolated ? 1 : 0
  name               = "AzureStorage_PrivateEndpoint"
  data_factory_id    = azurerm_data_factory.data_factory.id
  target_resource_id = azurerm_storage_account.blob[0].id
  subresource_name   = "blob"
  lifecycle {
    ignore_changes = [
      fqdns
    ]
  }
}

resource "azurerm_data_factory_managed_private_endpoint" "adls" {
  count              = var.deploy_adls && var.is_vnet_isolated ? 1 : 0
  name               = "AzureDataLake_PrivateEndpoint"
  data_factory_id    = azurerm_data_factory.data_factory.id
  target_resource_id = azurerm_storage_account.adls[0].id
  subresource_name   = "dfs"
  lifecycle {
    ignore_changes = [
      fqdns
    ]
  }
}

resource "azurerm_data_factory_managed_private_endpoint" "keyvault" {
  count              = var.is_vnet_isolated ? 1 : 0
  name               = "AzureKeyVault_PrivateEndpoint"
  data_factory_id    = azurerm_data_factory.data_factory.id
  target_resource_id = azurerm_key_vault.app_vault.id
  subresource_name   = "vault"
  lifecycle {
    ignore_changes = [
      fqdns
    ]
  }
}

resource "azurerm_data_factory_managed_private_endpoint" "sqlserver" {
  count              = var.deploy_sql_server && var.is_vnet_isolated ? 1 : 0
  name               = "AzureSqlServer_PrivateEndpoint"
  data_factory_id    = azurerm_data_factory.data_factory.id
  target_resource_id = azurerm_mssql_server.sqlserver[0].id
  subresource_name   = "sqlServer"
  lifecycle {
    ignore_changes = [
      fqdns
    ]
  }
}


// Synapse
# resource "azurerm_data_factory_managed_private_endpoint" "synapse" {
#   count              = var.deploy_synapse ? 1 : 0
#   name               = "AzureSqlServer_PrivateEndpoint"
#   data_factory_id    = azurerm_data_factory.data_factory.id
#   target_resource_id = azurerm_mssql_server.sqlserver[0].id
#   subresource_name   = "Sql, SqlOnDemand, Dev"
# }