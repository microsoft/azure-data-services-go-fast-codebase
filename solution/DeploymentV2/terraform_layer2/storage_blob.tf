

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
  #allow_blob_public_access = "false"
  network_rules {
    default_action = var.is_vnet_isolated ? "Deny" : "Allow"
    bypass         = ["Metrics", "AzureServices"]
    ip_rules       = var.is_vnet_isolated ? [var.ip_address] : [] // This is required to allow us to create the initial Synapse Managed Private endpoint
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "blob_deployment_agents" {
  for_each = {
    for ro in var.resource_owners : 
    ro => ro
    if(var.deploy_rbac_roles == true)
  }
  scope                = azurerm_storage_account.blob[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
}

resource "azurerm_role_assignment" "blob_function_app" {
  count                = var.deploy_storage_account && var.deploy_function_app && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_storage_account.blob[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.function_app[0].identity[0].principal_id
}

resource "azurerm_role_assignment" "blob_data_factory" {
  count                = var.deploy_storage_account && var.deploy_data_factory && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_storage_account.blob[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_data_factory.data_factory[0].identity[0].principal_id
}

resource "azurerm_role_assignment" "blob_purview_sp" {
  count                = var.deploy_purview && var.is_vnet_isolated && var.deploy_purview_sp && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_storage_account.blob[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.terraform_remote_state.layer1.outputs.purview_sp_object_id 
}


resource "azurerm_private_endpoint" "blob_storage_private_endpoint_with_dns" {
  count               = var.deploy_storage_account && var.is_vnet_isolated ? 1 : 0
  name                = "${local.blob_storage_account_name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id

  private_service_connection {
    name                           = "${local.blob_storage_account_name}-plink-conn"
    private_connection_resource_id = azurerm_storage_account.blob[0].id
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
  log_analytics_workspace_id = local.log_analytics_resource_id
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
