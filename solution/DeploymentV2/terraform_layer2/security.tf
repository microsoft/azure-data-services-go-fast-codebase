
resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  count               = (var.existing_log_analytics_workspace_id == "" ? 1 : 0)
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

locals {
  log_analytics_resource_id = (var.existing_log_analytics_resource_id == "" ? azurerm_log_analytics_workspace.log_analytics_workspace[0].id : var.existing_log_analytics_resource_id)
  log_analytics_workspace_id = (var.existing_log_analytics_workspace_id == "" ? azurerm_log_analytics_workspace.log_analytics_workspace[0].workspace_id : var.existing_log_analytics_workspace_id)

}

resource "azurerm_log_analytics_solution" "sentinel" {
  count                 = var.deploy_sentinel ? 1 : 0
  solution_name         = "SecurityInsights"
  location              = var.resource_location
  resource_group_name   = var.resource_group_name
  workspace_resource_id = local.log_analytics_resource_id
  workspace_name        = local.log_analytics_workspace_name
  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/SecurityInsights"
  }
}

resource "azurerm_role_assignment" "loganalytics_function_app" {
  count                = var.deploy_function_app && var.deploy_rbac_roles ? 1 : 0
  scope                = local.log_analytics_resource_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_function_app.function_app[0].identity[0].principal_id
}

resource "azurerm_role_assignment" "loganalytics_web_app" {
  count                = var.deploy_web_app && var.deploy_rbac_roles ? 1 : 0
  scope                = local.log_analytics_resource_id
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
  #allow_blob_public_access = "false"

  identity {
    type = "SystemAssigned"
  }
  network_rules {
    default_action = var.is_vnet_isolated ? "Deny" : "Allow"
    bypass         = ["Metrics", "AzureServices"]
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "blob_function_app_sec" {
  count                = var.deploy_function_app && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_storage_account.storage_acccount_security_logs.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.function_app[0].identity[0].principal_id
}

resource "azurerm_private_endpoint" "storage_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "${azurerm_storage_account.storage_acccount_security_logs.name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id

  private_service_connection {
    name                           = "${azurerm_storage_account.storage_acccount_security_logs.name}-plink-conn"
    private_connection_resource_id = azurerm_storage_account.storage_acccount_security_logs.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name                 = "privatednszonegroupstorage"
      private_dns_zone_ids = [local.private_dns_zone_blob_id]
    }
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