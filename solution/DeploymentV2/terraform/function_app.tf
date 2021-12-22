resource "azuread_application" "function_app" {
  count           = var.deploy_azure_ad_function_app_registration ? 1 : 0
  owners           = [data.azurerm_client_config.current.object_id]
  display_name    = local.aad_functionapp_name
  identifier_uris = [local.functionapp_identifier_uri]
  web {
    homepage_url = local.functionapp_url
    implicit_grant {
      access_token_issuance_enabled = false
    }
  }
  app_role {
    allowed_member_types = ["Application"]
    id                   = "99d0326c-8cb6-4ff6-a147-95ee311a31cb"
    description          = "Used to applications to call the ADS Go Fast functions"
    display_name         = "FunctionAPICaller"
    enabled              = true
    value                = "FunctionAPICaller"
  }
  required_resource_access {
    resource_app_id = "00000003-0000-0000-c000-000000000000"
    resource_access {
      id   = "b340eb25-3456-403f-be2f-af7a0d370277"
      type = "Scope"
    }
  }
}

resource "azurerm_function_app" "function_app" {
  name                       = local.functionapp_name
  location                   = var.resource_location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.app_service_plan[0].id
  storage_account_name       = azurerm_storage_account.storage_acccount_security_logs.name
  storage_account_access_key = azurerm_storage_account.storage_acccount_security_logs.primary_access_key
  version                    = "~3"

  https_only = true

  site_config {
    always_on              = true
    ftps_state             = "Disabled"
    vnet_route_all_enabled = var.is_vnet_isolated
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority                  = 100
        name                      = "Allow Private Link Subnet"
        action                    = "Allow"
        virtual_network_subnet_id = azurerm_subnet.plink_subnet[0].id
      }
    }
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority                  = 110
        name                      = "Allow Private Link App Service"
        action                    = "Allow"
        virtual_network_subnet_id = azurerm_subnet.app_service_subnet[0].id
      }
    }
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority    = 120
        name        = "Allow Azure Service Tag"
        action      = "Allow"
        service_tag = "AzurePortal"
      }
    }
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority    = 130
        name        = "Allow Private Link Subnet"
        action      = "Allow"
        service_tag = "DataFactory"
      }
    }
  }

  app_settings = {

    WEBSITE_RUN_FROM_PACKAGE = 0

    FUNCTIONS_WORKER_RUNTIME                                                    = "dotnet"
    FUNCTIONS_EXTENSION_VERSION                                                 = "~3"
    AzureWebJobsStorage                                                         = azurerm_storage_account.storage_acccount_security_logs.primary_connection_string
    APPINSIGHTS_INSTRUMENTATIONKEY                                              = azurerm_application_insights.app_insights[0].instrumentation_key
    ApplicationOptions__UseMSI                                                  = true
    ApplicationOptions__ServiceConnections__AdsGoFastTaskMetaDataDatabaseServer = "${azurerm_mssql_server.sqlserver[0].name}.database.windows.net"
    ApplicationOptions__ServiceConnections__AdsGoFastTaskMetaDataDatabaseName   = azurerm_mssql_database.web_db[0].name
    ApplicationOptions__ServiceConnections__CoreFunctionsURL                    = local.functionapp_url
    ApplicationOptions__ServiceConnections__AppInsightsWorkspaceId              = azurerm_log_analytics_workspace.log_analytics_workspace.id

    AzureAdAzureServicesViaAppReg__Domain       = var.domain
    AzureAdAzureServicesViaAppReg__TenantId     = var.tenant_id
    AzureAdAzureServicesViaAppReg__Audience     = local.functionapp_identifier_uri
    AzureAdAzureServicesViaAppReg__ClientSecret = null
    AzureAdAzureServicesViaAppReg__ClientId     = azuread_application.function_app[0].application_id

    #Setting to null as we are using MSI
    AzureAdAzureServicesDirect__ClientId = null
    AzureAdAzureServicesDirect__ClientId = null
  }
  identity {
    type = "SystemAssigned"
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags,
      app_settings["WEBSITE_RUN_FROM_PACKAGE"]
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration_func" {
  count          = var.is_vnet_isolated ? 1 : 0
  app_service_id = azurerm_function_app.function_app.id
  subnet_id      = azurerm_subnet.app_service_subnet[0].id
}

# Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "function_diagnostic_logs" {
  name = "diagnosticlogs"
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  target_resource_id         = azurerm_function_app.function_app.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  log {
    category = "FunctionAppLogs"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  metric {
    category = "AllMetrics"
    enabled  = false
  }
}

