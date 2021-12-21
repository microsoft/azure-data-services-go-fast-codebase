resource "azurerm_key_vault" "app_vault" {
  name                        = local.key_vault_name
  location                    = var.resource_location
  resource_group_name         = var.resource_group_name
  enabled_for_disk_encryption = true
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false
  tenant_id                   = var.tenant_id
  sku_name                    = "standard"

  network_acls {
    default_action = "Deny"
    bypass         = "AzureServices"
    ip_rules       = [var.ip_address] // This is required to allow us to set the secret values 
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

// Grant secret and key access to the current app to store the secret values --------------------------
resource "azurerm_key_vault_access_policy" "cicd_access" {
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Delete", "List", "Get", "Create", "Update", "Purge"
  ]

  secret_permissions = [
    "Delete", "List", "Get", "Set", "Purge"
  ]
  depends_on = [
    azurerm_key_vault.app_vault,
  ]
}

resource "azurerm_key_vault_access_policy" "adf_access" {
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_data_factory.data_factory.identity[0].principal_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "list", "get"
  ]
  depends_on = [
    azurerm_key_vault.app_vault,
  ]
}

// private endpoints --------------------------
resource "azurerm_private_endpoint" "app_vault_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "${local.key_vault_name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${local.key_vault_name}-plink-conn"
    private_connection_resource_id = azurerm_key_vault.app_vault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_kv[0].id]
  }

  depends_on = [
    azurerm_key_vault.app_vault
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

// Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "app_vault_diagnostic_logs" {
  name = "diagnosticlogs"

  target_resource_id         = azurerm_key_vault.app_vault.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  log {
    category = "AuditEvent"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AzurePolicyEvaluationDetails"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
}



// Actual secrets ----------------------------------------------------------------------
data "azurerm_function_app_host_keys" "function_app_host_key" {
  name                = azurerm_function_app.function_app.name
  resource_group_name = var.resource_group_name
}


resource "azurerm_key_vault_secret" "function_app_key" {
  name         = "AdsGfCoreFunctionAppKey"
  value        = data.azurerm_function_app_host_keys.function_app_host_key.default_function_key
  key_vault_id = azurerm_key_vault.app_vault.id
  depends_on = [
    azurerm_key_vault_access_policy.cicd_access
  ]
}

