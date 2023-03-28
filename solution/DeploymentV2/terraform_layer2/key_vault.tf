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
    ip_rules       = [var.ip_address, var.ip_address2] // This is required to allow us to set the secret values 
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

// Grant secret and key access to the current app to store the secret values --------------------------
// Allows the deployment service principal to compare / check state later
resource "azurerm_key_vault_access_policy" "cicd_and_admin_access" {
  for_each = {
    for ro in var.resource_owners : ro => ro
  }  
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = each.value

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


resource "azurerm_key_vault_access_policy" "cicd_access_layers1and3" {
  count        = (var.deployment_principal_layers1and3 == "" ? 0 : 1)
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.deployment_principal_layers1and3

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

resource "time_sleep" "cicd_access" {
  depends_on      = [azurerm_key_vault_access_policy.cicd_and_admin_access]
  create_duration = "10s"
}

// Allows the data factory to retrieve the azure function host key
resource "azurerm_key_vault_access_policy" "adf_access" {
  count        = var.deploy_data_factory ? 1 : 0
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_data_factory.data_factory[0].identity[0].principal_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "List", "Get"
  ]
  depends_on = [
    azurerm_key_vault.app_vault,
  ]
}


// Allows the Azure function to retrieve the Function App - AAD App Reg - Client Secret
resource "azurerm_key_vault_access_policy" "function_app" {
  count        = var.deploy_function_app ? 1 : 0
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_function_app.function_app[0].identity[0].principal_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "List", "Get"
  ]
  depends_on = [
    azurerm_key_vault.app_vault,
  ]
}

// Allows the synapse workspace to retrieve the azure function host key
resource "azurerm_key_vault_access_policy" "synapse_access" {
  count        = var.deploy_synapse ? 1 : 0
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_synapse_workspace.synapse[0].identity[0].principal_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "List", "Get"
  ]
  depends_on = [
    azurerm_key_vault.app_vault,
  ]
}

// Allows the executor vm to retrieve relevant encryption keys
resource "azurerm_key_vault_access_policy" "cmd_executor_vm_access" {
  count        = var.deploy_cmd_executor_vm ? 1 : 0
  key_vault_id = azurerm_key_vault.app_vault.id
  tenant_id    = var.tenant_id
  object_id    = azurerm_linux_virtual_machine.cmd_executor_vm_linux[0].identity[0].principal_id

  key_permissions = [
    "Get", "List"
  ]

  secret_permissions = [
    "List", "Get"
  ]
  depends_on = [
    azurerm_key_vault.app_vault,
    azurerm_linux_virtual_machine.cmd_executor_vm_linux[0].identity[0].principal_id
  ]
}



// private endpoints --------------------------
resource "azurerm_private_endpoint" "app_vault_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "${local.key_vault_name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id

  private_service_connection {
    name                           = "${local.key_vault_name}-plink-conn"
    private_connection_resource_id = azurerm_key_vault.app_vault.id
    is_manual_connection           = false
    subresource_names              = ["vault"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [local.private_dns_zone_kv_id]
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
  log_analytics_workspace_id = local.log_analytics_resource_id
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
  count               = var.deploy_function_app ? 1 : 0
  name                = azurerm_function_app.function_app[0].name
  resource_group_name = var.resource_group_name
  depends_on = [
    time_sleep.cicd_access,
    azurerm_app_service_virtual_network_swift_connection.vnet_integration_func
  ]
}


resource "azurerm_key_vault_secret" "function_app_key" {
  count        = var.deploy_function_app ? 1 : 0
  name         = "AdsGfCoreFunctionAppKey"
  value        = data.azurerm_function_app_host_keys.function_app_host_key[0].default_function_key
  key_vault_id = azurerm_key_vault.app_vault.id
  depends_on = [
    time_sleep.cicd_access,
    azurerm_app_service_virtual_network_swift_connection.vnet_integration_func
  ]
}


resource "azurerm_key_vault_secret" "selfhostedsql_password" {
  count        = var.deploy_selfhostedsql ? 1 : 0
  name         = "selfhostedsqlpw"
  value        = random_password.selfhostedsql[0].result
  key_vault_id = azurerm_key_vault.app_vault.id
  depends_on = [
    time_sleep.cicd_access,
  ]
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}

resource "azurerm_key_vault_secret" "cmdexecutorvm_password" {
  count        = var.deploy_cmd_executor_vm ? 1 : 0
  name         = "cmdexecutorvmpw"
  value        = random_password.cmd_executor_vm[0].result
  key_vault_id = azurerm_key_vault.app_vault.id
  depends_on = [
    time_sleep.cicd_access,
  ]
  lifecycle {
    ignore_changes = [
      value
    ]
  }
}


