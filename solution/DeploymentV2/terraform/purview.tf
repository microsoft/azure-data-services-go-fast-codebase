resource "azurerm_purview_account" "purview" {
  count                       = var.deploy_purview ? 1 : 0
  name                        = local.purview_name
  resource_group_name         = var.resource_group_name
  location                    = var.resource_location
  managed_resource_group_name = local.purview_resource_group_name
  public_network_enabled      = var.is_vnet_isolated == false
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
    name                           = "${var.prefix}-${var.environment_tag}-sql-${lower(var.app_name)}-plink-conn"
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
  name                = "${var.prefix}-${var.environment_tag}-pura-${lower(var.app_name)}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${var.prefix}-${var.environment_tag}-sql-${lower(var.app_name)}-plink-conn"
    private_connection_resource_id = azurerm_purview_account.purview[0].id
    is_manual_connection           = false
    subresource_names              = ["portal"]
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

# Azure pipelines
module "purview_ingestion_private_endpoints" {
  source                      = "./modules/purview_ingestion_private_endpoints"
  count                       = var.is_vnet_isolated && var.deploy_purview ? 1 : 0
  resource_group_name         = var.resource_group_name
  purview_account_name        = azurerm_purview_account.purview[0].name
  resource_location           = var.resource_location
  queue_privatelink_name      = "${local.purview_name}-queue-plink"
  storage_privatelink_name    = "${local.purview_name}-storage-plink"
  eventhub_privatelink_name   = "${local.purview_name}-event-plink"
  subnet_id                   = azurerm_subnet.plink_subnet[0].id
  managed_resource_group_name = local.purview_resource_group_name
  name_suffix                 = random_id.rg_deployment_unique.id

}

resource "azurerm_role_assignment" "purview_curator_adf" {
  count                = var.deploy_purview ? 1 : 0
  scope                = azurerm_purview_account.purview[0].id
  role_definition_name = "Purview Data Curator (Legacy)"
  principal_id         = azurerm_data_factory.data_factory.identity[0].principal_id
}




