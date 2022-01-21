
resource "random_uuid" "app_reg_role_id" {}

resource "azuread_application" "web_reg" {
  count        = var.deploy_azure_ad_web_app_registration ? 1 : 0
  display_name = local.aad_webapp_name
  owners       = [data.azurerm_client_config.current.object_id]
  web {
    homepage_url  = local.webapp_url
    redirect_uris = ["${local.webapp_url}/signin-oidc", "https://localhost:44385/signin-oidc"]
    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = true
    }
  }
  app_role {
    allowed_member_types = ["User"]
    id                   = random_uuid.app_reg_role_id.result
    description          = "Administer features of the application"
    display_name         = "Administrator"
    enabled              = true
    value                = "Administrator"
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"

    resource_access {
      id   = "b340eb25-3456-403f-be2f-af7a0d370277"
      type = "Scope"
    }
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [azuread_application.web_reg]
  create_duration = "30s"
}

resource "azuread_service_principal" "web_sp" {
  count          = var.deploy_azure_ad_web_app_registration ? 1 : 0
  application_id = azuread_application.web_reg[0].application_id
  owners         = [data.azurerm_client_config.current.object_id]
  depends_on = [time_sleep.wait_30_seconds]
}


resource "azurerm_app_service" "web" {
  count               = var.deploy_web_app ? 1 : 0
  name                = local.webapp_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.app_service_plan[0].id
  https_only          = true
  client_cert_enabled = false
  app_settings = {
    WEBSITE_RUN_FROM_PACKAGE = 1

    ApplicationOptions__UseMSI                              = true
    ApplicationOptions__AdsGoFastTaskMetaDataDatabaseServer = "${azurerm_mssql_server.sqlserver[0].name}.database.windows.net"
    ApplicationOptions__AdsGoFastTaskMetaDataDatabaseName   = azurerm_mssql_database.web_db[0].name

    ApplicationOptions__AppInsightsWorkspaceId  = azurerm_application_insights.app_insights[0].app_id
    ApplicationOptions__LogAnalyticsWorkspaceId = azurerm_log_analytics_workspace.log_analytics_workspace.id

    AzureAdAuth__Domain   = var.domain
    AzureAdAuth__TenantId = var.tenant_id
    AzureAdAuth__ClientId = azuread_application.web_reg[0].application_id
  }

  site_config {
    always_on                = true
    dotnet_framework_version = "v5.0"
    min_tls_version          = "1.2"
    ftps_state               = "Disabled"
    http2_enabled            = true
    vnet_route_all_enabled   = var.is_vnet_isolated
  }
  auth_settings {
    enabled = false
  }

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

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration" {
  count          = var.is_vnet_isolated ? 1 : 0
  app_service_id = azurerm_app_service.web[0].id
  subnet_id      = azurerm_subnet.app_service_subnet[0].id
}


# // Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "app_service_diagnostic_logs" {
  name = "diagnosticlogs"

  target_resource_id         = azurerm_app_service.web[0].id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AppServiceHTTPLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AppServiceConsoleLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AppServiceAppLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AppServiceAuditLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AppServiceIPSecAuditLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "AppServicePlatformLogs"
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

