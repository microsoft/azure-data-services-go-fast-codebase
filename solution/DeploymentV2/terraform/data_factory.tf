resource "azurerm_data_factory" "data_factory" {
  name                            = local.data_factory_name
  location                        = var.resource_location
  resource_group_name             = var.resource_group_name
  public_network_enabled          = (var.is_vnet_isolated == false)
  managed_virtual_network_enabled = true
  identity {
    type = "SystemAssigned"
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_role_assignment" "datafactory_function_app" {
  scope                = azurerm_data_factory.data_factory.id
  role_definition_name = "Contributor"
  principal_id         = azurerm_function_app.function_app.identity[0].principal_id
}


# // Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "data_factory_diagnostic_logs" {
  name                           = "diagnosticlogs"
  log_analytics_destination_type = "AzureDiagnostics"
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  target_resource_id         = azurerm_data_factory.data_factory.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  log {
    category = "ActivityRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "PipelineRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "TriggerRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISIntegrationRuntimeLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SandboxPipelineRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SandboxActivityRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISPackageExecutionDataStatistics"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISPackageExecutionComponentPhases"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISPackageExecutableStatistics"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISPackageEventMessages"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISPackageEventMessageContext"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "SSISIntegrationRuntimeLogs"
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

