resource "azurerm_public_ip" "bastion_pip" {
  count               = (var.is_vnet_isolated && var.deploy_bastion ? 1 : 0)
  name                = local.bastion_ip_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion" {
  count               = (var.is_vnet_isolated && var.deploy_bastion ? 1 : 0)
  name                = local.bastion_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = local.bastion_subnet_id
    public_ip_address_id = azurerm_public_ip.bastion_pip[0].id
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


