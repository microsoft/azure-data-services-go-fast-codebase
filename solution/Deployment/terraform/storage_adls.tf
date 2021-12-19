resource "azurerm_storage_account" "adls" {
  count                    = var.deploy_adls ? 1 : 0
  name                     = local.adls_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = "false"
  network_rules {
    default_action = "Deny"
    bypass         = ["Metrics", "AzureServices"]
    ip_rules       = [var.ip_address] // This is required to allow us to create the initial containers
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "adls_function_app" {
  count                = var.deploy_adls ? 1 : 0
  scope                = azurerm_storage_account.adls[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.function_app.identity[0].principal_id
}

resource "azurerm_role_assignment" "adls_data_factory" {
  count                = var.deploy_adls ? 1 : 0
  scope                = azurerm_storage_account.adls[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_factory.data_factory.identity[0].principal_id
}




# Add the current deployment SP to be allowed to create the containers
# currently disabled waiting on containers to be accessible via control plane
#   https://github.com/hashicorp/terraform-provider-azurerm/pull/14220
#   https://github.com/hashicorp/terraform-provider-azurerm/issues/2977
# resource "azurerm_role_assignment" "adls_cicd" {
#   scope                = azurerm_storage_account.blob[0].id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = data.azurerm_client_config.current.object_id
# }


# resource "azurerm_storage_container" "adls_landing" {
#   name                  = "datalakelanding"
#   storage_account_name  = azurerm_storage_account.adls[0].name
#   container_access_type = "private"
#   depends_on = [
#     azurerm_role_assignment.adls_cicd
#   ]
# }
# resource "azurerm_storage_container" "adls_raw" {
#   name                  = "transient"
#   storage_account_name  = azurerm_storage_account.adls[0].name
#   container_access_type = "private"
#   depends_on = [
#     azurerm_role_assignment.adls_cicd
#   ]
# }

resource "azurerm_private_endpoint" "adls_storage_private_endpoint_with_dns" {
  count               = var.deploy_adls && var.is_vnet_isolated ? 1 : 0
  name                = "${local.adls_storage_account_name}-blob-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.adls_storage_account_name}-blob-plink-conn"
    private_connection_resource_id = azurerm_storage_account.adls[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupstorageblob"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_blob[0].id]
  }

  depends_on = [
    azurerm_storage_account.adls
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "adls_dfs_storage_private_endpoint_with_dns" {
  count               = var.deploy_adls && var.is_vnet_isolated ? 1 : 0
  name                = "${local.adls_storage_account_name}-dfs-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.adls_storage_account_name}-dfs-plink-conn"
    private_connection_resource_id = azurerm_storage_account.adls[0].id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupstoragedfs"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_blob[0].id]
  }

  depends_on = [
    azurerm_storage_account.adls
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# // Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "adls_storage_diagnostic_logs" {
  count                      = var.deploy_adls ? 1 : 0
  name                       = "diagnosticlogs"
  target_resource_id         = "${azurerm_storage_account.adls[0].id}/blobServices/default/"
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  log {
    category = "StorageRead"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "StorageWrite"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "StorageDelete"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }

  metric {
    category = "Transaction"
    enabled  = false
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  metric {
    category = "Capacity"
    enabled  = false
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
