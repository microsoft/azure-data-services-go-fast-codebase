
locals {
  vnet_id = (var.existing_vnet_id == "" && (var.is_vnet_isolated) ? azurerm_virtual_network.vnet[0].id : var.existing_vnet_id)
}

resource "azurerm_virtual_network" "vnet" {
  count               = (var.is_vnet_isolated && var.existing_vnet_id == "" ? 1 : 0)
  name                = local.vnet_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  address_space       = [var.vnet_cidr]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
