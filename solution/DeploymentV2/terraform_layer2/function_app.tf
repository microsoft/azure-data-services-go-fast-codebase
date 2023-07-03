resource "azurerm_function_app" "function_app" {
  name                       = local.functionapp_name
  count                      = var.deploy_function_app && var.deploy_app_service_plan ? 1 : 0
  location                   = var.resource_location
  resource_group_name        = var.resource_group_name
  app_service_plan_id        = azurerm_app_service_plan.app_service_plan[0].id
  storage_account_name       = azurerm_storage_account.storage_acccount_security_logs.name
  storage_account_access_key = azurerm_storage_account.storage_acccount_security_logs.primary_access_key
  version                    = "~4"

  https_only = true

  site_config {
    always_on                = true
    dotnet_framework_version = "v6.0"
    ftps_state               = "Disabled"
    vnet_route_all_enabled   = var.is_vnet_isolated
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority                  = 100
        name                      = "Allow Private Link Subnet"
        action                    = "Allow"
        virtual_network_subnet_id = local.plink_subnet_id
      }
    }
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority                  = 110
        name                      = "Allow App Service Subnet"
        action                    = "Allow"
        virtual_network_subnet_id = local.app_service_subnet_id
      }
    }
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority    = 120
        name        = "Allow Azure Service Tag"
        action      = "Allow"
        service_tag = "AzureCloud"
      }
    }
    dynamic "ip_restriction" {
      for_each = var.is_vnet_isolated ? [1] : []
      content {
        priority    = 130
        name        = "Allow Data Factory Service Tag"
        action      = "Allow"
        service_tag = "DataFactory"
      }
    }
  }

  app_settings = {

    WEBSITE_RUN_FROM_PACKAGE = 0

    FUNCTIONS_WORKER_RUNTIME                                                    = "dotnet"
    FUNCTIONS_EXTENSION_VERSION                                                 = "~4"
    AzureWebJobsStorage                                                         = azurerm_storage_account.storage_acccount_security_logs.primary_connection_string
    APPINSIGHTS_INSTRUMENTATIONKEY                                              = azurerm_application_insights.app_insights[0].instrumentation_key
    ApplicationOptions__UseMSI                                                  = true
    ApplicationOptions__ServiceConnections__AdsGoFastTaskMetaDataDatabaseServer = var.deploy_metadata_database ? "${azurerm_mssql_server.sqlserver[0].name}.database.windows.net" : null
    ApplicationOptions__ServiceConnections__AdsGoFastTaskMetaDataDatabaseName   = var.deploy_metadata_database ? azurerm_mssql_database.web_db[0].name : null
    ApplicationOptions__ServiceConnections__CoreFunctionsURL                    = local.functionapp_url
    ApplicationOptions__ServiceConnections__AppInsightsWorkspaceId              = azurerm_application_insights.app_insights[0].app_id

    AzureAdAzureServicesViaAppReg__Domain       = var.domain
    AzureAdAzureServicesViaAppReg__TenantId     = var.tenant_id
    AzureAdAzureServicesViaAppReg__Audience     = "api://${local.functionapp_name}"
    AzureAdAzureServicesViaAppReg__ClientSecret = "@Microsoft.KeyVault(VaultName=${azurerm_key_vault.app_vault.name};SecretName=AzureFunctionClientSecret)"
    AzureAdAzureServicesViaAppReg__ClientId     =  data.terraform_remote_state.layer1.outputs.aad_funcreg_id 

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
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
      app_settings["SCM_DO_BUILD_DURING_DEPLOYMENT"]
    ]
  }
  depends_on = [
    azurerm_private_endpoint.storage_private_endpoint_with_dns
  ]
}

resource "azurerm_app_service_virtual_network_swift_connection" "vnet_integration_func" {
  count          = var.is_vnet_isolated && var.deploy_function_app ? 1 : 0
  app_service_id = azurerm_function_app.function_app[0].id
  subnet_id      = local.app_service_subnet_id
}

# Diagnostic logs--------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "function_diagnostic_logs" {
  count = var.deploy_function_app ? 1 : 0
  name  = "diagnosticlogs"
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  target_resource_id         = azurerm_function_app.function_app[0].id
  log_analytics_workspace_id = local.log_analytics_resource_id

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


