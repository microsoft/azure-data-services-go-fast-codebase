resource "azurerm_subnet" "plink_subnet" {
  count                                          = (var.is_vnet_isolated ? 1 : 0)
  name                                           = local.plink_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet[0].name
  address_prefixes                               = [var.plink_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "bastion_subnet" {
  count                                          = (var.is_vnet_isolated ? 1 : 0)
  name                                           = "AzureBastionSubnet"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet[0].name
  address_prefixes                               = [var.bastion_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
}

resource "azurerm_subnet" "vm_subnet" {
  count                                          = (var.is_vnet_isolated ? 1 : 0)
  name                                           = local.vm_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet[0].name
  address_prefixes                               = [var.vm_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
}



resource "azurerm_subnet" "app_service_subnet" {
  count                                          = (var.is_vnet_isolated ? 1 : 0)
  name                                           = local.app_service_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet[0].name
  address_prefixes                               = [var.app_service_subnet_cidr]
  enforce_private_link_endpoint_network_policies = false


  # required for VNet integration with app services (functions)
  # https://docs.microsoft.com/en-us/azure/app-service/web-sites-integrate-with-vnet#regional-vnet-integration
  delegation {
    name = "app-service-delegation"

    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
