

resource "azurerm_storage_account" "blob" {
  name                     = local.blob_storage_account_name
  count                    = var.deploy_storage_account ? 1 : 0
  resource_group_name      = var.resource_group_name
  location                 = var.resource_location
  account_tier             = "Standard"
  account_replication_type = "GRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "false"
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

resource "azurerm_role_assignment" "blob_function_app" {
  count                = var.deploy_storage_account ? 1 : 0
  scope                = azurerm_storage_account.blob[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.function_app.identity[0].principal_id
}

resource "azurerm_role_assignment" "blob_data_factory" {
  count                = var.deploy_storage_account ? 1 : 0
  scope                = azurerm_storage_account.blob[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_factory.data_factory.identity[0].principal_id
}


# currently disabled waiting on containers to be accessible via control plane
#   https://github.com/hashicorp/terraform-provider-azurerm/pull/14220
#   https://github.com/hashicorp/terraform-provider-azurerm/issues/2977
#  resource "azurerm_role_assignment" "blob_cicd" {
#   scope                = azurerm_storage_account.blob[0].id
#   role_definition_name = "Storage Blob Data Contributor"
#   principal_id         = data.azurerm_client_config.current.object_id
# }


#  resource "azurerm_storage_container" "blob_landing" {
#   name                  = "datalakelanding"
#   storage_account_name  = azurerm_storage_account.blob[0].name
#   container_access_type = "private"
#   depends_on = [
#     azurerm_role_assignment.blob_cicd
#   ]
# }

#  resource "azurerm_storage_container" "blob_raw" {
#   name                  = "datalakeraw"
#   storage_account_name  = azurerm_storage_account.blob[0].name
#   container_access_type = "private"
#   depends_on = [
#     azurerm_role_assignment.blob_cicd
#   ]
# }

resource "azurerm_private_endpoint" "blob_storage_private_endpoint_with_dns" {
  count               = var.deploy_storage_account && var.is_vnet_isolated ? 1 : 0
  name                = "${local.blob_storage_account_name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.blob_storage_account_name}-plink-conn"
    private_connection_resource_id = azurerm_storage_account.blob[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupstorage"
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
resource "azurerm_monitor_diagnostic_setting" "blob_storage_diagnostic_logs" {
  name                       = "diagnosticlogs"
  count                      = var.deploy_storage_account ? 1 : 0
  target_resource_id         = "${azurerm_storage_account.blob[0].id}/blobServices/default/"
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
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  metric {
    category = "Capacity"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}
