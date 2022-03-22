resource "azurerm_purview_account" "purview" {
  count                       = var.deploy_purview ? 1 : 0
  name                        = local.purview_name
  resource_group_name         = var.resource_group_name
  location                    = var.resource_location
  managed_resource_group_name = local.purview_resource_group_name
  public_network_enabled      = var.is_vnet_isolated == false || var.delay_private_access
  tags                        = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_private_endpoint" "purview_account_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated && var.deploy_purview ? 1 : 0
  name                = "${var.prefix}-${var.environment_tag}-pura-${lower(var.app_name)}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${var.prefix}-${var.environment_tag}-pura-${lower(var.app_name)}-plink-conn"
    private_connection_resource_id = azurerm_purview_account.purview[0].id
    is_manual_connection           = false
    subresource_names              = ["account"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_purview[0].id]
  }

  depends_on = [
    azurerm_purview_account.purview[0]
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "purview_portal_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated && var.deploy_purview ? 1 : 0
  name                = "${var.prefix}-${var.environment_tag}-purp-${lower(var.app_name)}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${var.prefix}-${var.environment_tag}-purp-${lower(var.app_name)}-plink-conn"
    private_connection_resource_id = azurerm_purview_account.purview[0].id
    is_manual_connection           = false
    subresource_names              = ["portal"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_purview_studio[0].id]
  }

  depends_on = [
    azurerm_purview_account.purview[0]
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Azure private endpoints
module "purview_ingestion_private_endpoints" {
  source                      = "./modules/purview_ingestion_private_endpoints"
  count                       = var.is_vnet_isolated && var.deploy_purview ? 1 : 0
  resource_group_name         = var.resource_group_name
  purview_account_name        = azurerm_purview_account.purview[0].name
  resource_location           = var.resource_location
  queue_privatelink_name      = "${local.purview_name}-queue-plink"
  storage_privatelink_name    = "${local.purview_name}-storage-plink"
  eventhub_privatelink_name   = "${local.purview_name}-event-plink"
  blob_private_dns_id         = azurerm_private_dns_zone.private_dns_zone_blob[0].id
  queue_private_dns_id        = azurerm_private_dns_zone.private_dns_zone_queue[0].id
  servicebus_private_dns_id   = azurerm_private_dns_zone.private_dns_zone_servicebus[0].id
  subnet_id                   = azurerm_subnet.plink_subnet[0].id
  managed_resource_group_name = local.purview_resource_group_name
  name_suffix                 = random_id.rg_deployment_unique.id
  subscription_id             = var.subscription_id
}

// Create an IR service principal (private linked resources can't use the azure hosted IRs)
resource "azuread_application" "purview_ir" {
  count        = var.deploy_purview && var.is_vnet_isolated ? 1 : 0
  display_name = local.purview_ir_app_reg_name
  owners       = [data.azurerm_client_config.current.object_id]
}

resource "azuread_service_principal" "purview_ir" {
  count          = var.deploy_purview && var.is_vnet_isolated ? 1 : 0
  application_id = azuread_application.purview_ir[0].application_id
}


resource "azuread_application_password" "purview_ir" {
  count                 = var.deploy_purview && var.is_vnet_isolated ? 1 : 0
  application_object_id = azuread_application.purview_ir[0].object_id
}
