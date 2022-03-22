# --------------------------------------------------------------------------------------------------------------------
# Workspace
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_storage_data_lake_gen2_filesystem" "dlfs" {
  count              = var.deploy_adls && var.deploy_synapse ? 1 : 0
  name               = local.synapse_data_lake_name
  storage_account_id = azurerm_storage_account.adls[0].id
}

resource "azurerm_synapse_workspace" "synapse" {
  count                                = var.deploy_adls && var.deploy_synapse ? 1 : 0
  name                                 = local.synapse_workspace_name
  resource_group_name                  = var.resource_group_name
  location                             = var.resource_location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.dlfs[0].id
  sql_administrator_login              = var.synapse_sql_login
  sql_administrator_login_password     = local.synapse_sql_password
  sql_identity_control_enabled         = true
  public_network_access_enabled        = ((var.is_vnet_isolated == false) || (var.delay_private_access == true))
  managed_virtual_network_enabled      = true
  managed_resource_group_name          = local.synapse_resource_group_name
  purview_id                           = var.deploy_purview ? azurerm_purview_account.purview[0].id : null

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}




# --------------------------------------------------------------------------------------------------------------------
# SQL Dedicated Pool
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_sql_pool" "synapse_sql_pool" {
  count                = var.deploy_adls && var.deploy_synapse && var.deploy_synapse_sqlpool ? 1 : 0
  name                 = local.synapse_dwpool_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  sku_name             = var.synapse_sku
  create_mode          = "Default"
  tags                 = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# --------------------------------------------------------------------------------------------------------------------
# Spark Pool
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_spark_pool" "synapse_spark_pool" {
  count                = var.deploy_adls && var.deploy_synapse && var.deploy_synapse_sparkpool ? 1 : 0
  name                 = local.synapse_sppool_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  node_size_family     = "MemoryOptimized"
  node_size            = "Small"
  cache_size           = 100

  auto_scale {
    max_node_count = var.synapse_spark_max_node_count
    min_node_count = var.synapse_spark_min_node_count
  }

  auto_pause {
    delay_in_minutes = 15
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace Firewall Rules (Allow Public Access)
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_firewall_rule" "cicd" {
  count                = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                 = "AllowGitHub"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  start_ip_address     = var.ip_address
  end_ip_address       = var.ip_address
}

# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace Firewall Rules (Allow Public Access)
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_firewall_rule" "public_access" {
  count                = var.deploy_adls && var.deploy_synapse && var.allow_public_access_to_synapse_studio ? 1 : 0
  name                 = "AllowAll"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"
}

# --------------------------------------------------------------------------------------------------------------------
# User Access requirements
# --------------------------------------------------------------------------------------------------------------------
# https://docs.microsoft.com/en-us/azure/synapse-analytics/security/how-to-set-up-access-control
# - Access to synapse workspace:
#       - Synapse Contributo
#       - Synapse User
# - Synapse Compute Operator on the selected Apache Spark pool
# - Storage Data Contributor on the ADLS store for Synapse 
# - SQL Pool access

# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace - Managed Private Endpoints
# --------------------------------------------------------------------------------------------------------------------
# This managed private endpoint lets synapse read from the underlying data lake. The SQL endpoints are autocreated
# We depend on the cicd rule incase we are deploying publicly and cant access the private endpoints from GitHub
resource "azurerm_synapse_managed_private_endpoint" "adls" {
  count                = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                 = "AzureDataLake_PrivateEndpoint"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  target_resource_id   = azurerm_storage_account.adls[0].id
  subresource_name     = "dfs"
  // Because we deploy synapse in private (no public access) we only propose to create/destroy but never update
  lifecycle {
    ignore_changes = all
  }
  depends_on = [
    azurerm_synapse_firewall_rule.cicd
  ]
}

# --------------------------------------------------------------------------------------------------------------------
# Network Settings to allow inbound private link traffic to the Synapse studio
# https://docs.microsoft.com/en-us/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network
resource "azurerm_synapse_private_link_hub" "hub" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}plinkhub"
  resource_group_name = var.resource_group_name
  location            = var.resource_location
}


resource "azurerm_private_endpoint" "synapse_web" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-web-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-web-plink-conn"
    private_connection_resource_id = azurerm_synapse_private_link_hub.hub[0].id
    is_manual_connection           = false
    subresource_names              = ["Web"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupweb"
    private_dns_zone_ids = [azurerm_private_dns_zone.synapse_gateway[0].id]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "synapse_dev" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-dev-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-dev-plink-conn"
    private_connection_resource_id = azurerm_synapse_workspace.synapse[0].id
    is_manual_connection           = false
    subresource_names              = ["Dev"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupdev"
    private_dns_zone_ids = [azurerm_private_dns_zone.synapse_studio[0].id]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_synapse_firewall_rule.cicd
  ]
}

resource "azurerm_private_endpoint" "synapse_sql" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-sql-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-sql-plink-conn"
    private_connection_resource_id = azurerm_synapse_workspace.synapse[0].id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupsql"
    private_dns_zone_ids = [azurerm_private_dns_zone.synapse_sql[0].id]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_synapse_firewall_rule.cicd
  ]
}

resource "azurerm_private_endpoint" "synapse_sqlondemand" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-sqld-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-sqld-plink-conn"
    private_connection_resource_id = azurerm_synapse_workspace.synapse[0].id
    is_manual_connection           = false
    subresource_names              = ["SqlOnDemand"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupsqld"
    private_dns_zone_ids = [azurerm_private_dns_zone.synapse_sql[0].id]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    azurerm_synapse_firewall_rule.cicd
  ]
}




# --------------------------------------------------------------------------------------------------------------------
# // Diagnostic logs
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "synapse_diagnostic_logs" {
  count = var.deploy_adls && var.deploy_synapse ? 1 : 0
  name  = "diagnosticlogs"
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  target_resource_id         = azurerm_synapse_workspace.synapse[0].id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  log {
    category = "SynapseRbacOperations"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "GatewayApiRequests"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "BuiltinSqlReqsEnded"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "IntegrationPipelineRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "IntegrationActivityRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "IntegrationTriggerRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false
    retention_policy {
      days    = 0
      enabled = true
    }
  }


}

// Commenting out because not deploying synapse at this stage
// resource "azurerm_synapse_role_assignment" "synapse_function_app_assignment" {
//   synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
//   role_name            = "Synapse Administrator"
//   principal_id         = azurerm_function_app.function_app.identity[0].principal_id
// 
// }
// 
// resource "azurerm_synapse_linked_service" "synapse_keyvault_linkedservice" {
//   name                 = "SLS_AzureKeyVault"
//   synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
//   type                 = "AzureKeyVault"
//   type_properties_json = <<JSON
// {
//   "baseUrl": "${azurerm_key_vault.app_vault.vault_uri}"
// }
// JSON
// }
// 
// resource "azurerm_synapse_linked_service" "synapse_functionapp_linkedservice" {
//   name                 = "SLS_AzureFunctionApp"
//   synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
//   type                 = "AzureFunction"
//   type_properties_json = <<JSON
// {
//   "functionAppUrl": "${azurerm_key_vault.app_vault.vault_uri}",
//   "functionKey": {
//     "type": "AzureKeyVaultSecret",
//     "store": {
//       "referenceName": "${azurerm_synapse_linked_service.synapse_keyvault_linkedservice.name}",
//       "type": "LinkedServiceReference"
//     },
//     "secretName": "AzureFunctionClientSecret"
//   },
//   "authentication": "Anonymous"
// }
// JSON
// }
