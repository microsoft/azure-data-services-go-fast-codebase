resource "azurerm_public_ip" "bastion_pip" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = local.bastion_ip_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = local.bastion_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastion_subnet[0].id
    public_ip_address_id = azurerm_public_ip.bastion_pip[0].id
  }
}

# // Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "bastion_diagnostic_logs" {
  name = "diagnosticlogs"

  target_resource_id         = azurerm_bastion_host.bastion[0].id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  log {
    category = "BastionAuditLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = false
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = false
    retention_policy {
      days    = 0
      enabled = false
    }
  }
}

