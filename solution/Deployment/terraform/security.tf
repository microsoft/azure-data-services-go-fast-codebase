
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = local.log_analytics_workspace_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  sku                 = "PerGB2018"
  tags                = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "loganalytics_function_app" {
  scope                = azurerm_log_analytics_workspace.log_analytics_workspace.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_function_app.function_app.identity[0].principal_id
}

resource "azurerm_role_assignment" "loganalytics_web_app" {
  scope                = azurerm_log_analytics_workspace.log_analytics_workspace.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_app_service.web[0].identity[0].principal_id
}

resource "azurerm_storage_account" "storage_acccount_security_logs" {
  name                     = local.logs_storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.resource_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
  min_tls_version          = "TLS1_2"
  allow_blob_public_access = "false"

  identity {
    type = "SystemAssigned"
  }
  network_rules {
    default_action = "Deny"
    bypass         = ["Metrics", "AzureServices"]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_private_endpoint" "storage_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "${azurerm_storage_account.storage_acccount_security_logs.name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${azurerm_storage_account.storage_acccount_security_logs.name}-plink-conn"
    private_connection_resource_id = azurerm_storage_account.storage_acccount_security_logs.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupstorage"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_blob[0].id]
  }

  depends_on = [
    azurerm_storage_account.storage_acccount_security_logs
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
