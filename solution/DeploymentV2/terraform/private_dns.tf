resource "azurerm_private_dns_zone" "private_dns_zone_db" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "database" {
  count                 = (var.is_vnet_isolated ? 1 : 0)
  name                  = "${local.vnet_name}-database"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_db[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}


resource "azurerm_private_dns_zone" "private_dns_zone_kv" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "vaultcore" {
  count                 = (var.is_vnet_isolated ? 1 : 0)
  name                  = "${local.vnet_name}-vaultcore"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_kv[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
  tags                  = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_dns_zone" "private_dns_zone_blob" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "blob" {
  count                 = (var.is_vnet_isolated ? 1 : 0)
  name                  = "${local.vnet_name}-blob"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_blob[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}

resource "azurerm_private_dns_zone" "private_dns_zone_queue" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = "privatelink.queue.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "queue" {
  count                 = (var.is_vnet_isolated ? 1 : 0)
  name                  = "${local.vnet_name}-queue"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_queue[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}

resource "azurerm_private_dns_zone" "private_dns_zone_dfs" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = "privatelink.dfs.core.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dfs" {
  count                 = (var.is_vnet_isolated ? 1 : 0)
  name                  = "${local.vnet_name}-dfs"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_dfs[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}

resource "azurerm_private_dns_zone" "private_dns_zone_purview" {
  count               = (var.is_vnet_isolated && var.deploy_purview ? 1 : 0)
  name                = "privatelink.purview.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "purview" {
  count                 = (var.is_vnet_isolated && var.deploy_purview ? 1 : 0)
  name                  = "${local.vnet_name}-purview"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_purview[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}

resource "azurerm_private_dns_zone" "private_dns_zone_purview_studio" {
  count               = (var.is_vnet_isolated && var.deploy_purview ? 1 : 0)
  name                = "privatelink.purviewstudio.azure.com"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "purview_studio" {
  count                 = (var.is_vnet_isolated && var.deploy_purview ? 1 : 0)
  name                  = "${local.vnet_name}-purviewstudio"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_purview_studio[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}

resource "azurerm_private_dns_zone" "private_dns_zone_servicebus" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "servicebus" {
  count                 = (var.is_vnet_isolated ? 1 : 0)
  name                  = "${local.vnet_name}-servicebus"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone_servicebus[0].name
  virtual_network_id    = azurerm_virtual_network.vnet[0].id
}

