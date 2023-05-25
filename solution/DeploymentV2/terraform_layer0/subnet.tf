resource "azurerm_subnet" "plink_subnet" {
  count                                          = (var.is_vnet_isolated && var.existing_plink_subnet_id == "") ? 1 : 0
  name                                           = local.plink_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = local.vnet_name
  address_prefixes                               = [var.plink_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

locals {
  plink_subnet_id = (var.existing_plink_subnet_id == "" && (var.is_vnet_isolated)) ? azurerm_subnet.plink_subnet[0].id : var.existing_plink_subnet_id
}

resource "azurerm_subnet" "bastion_subnet" {
  count                                          = (var.is_vnet_isolated && var.deploy_bastion && var.existing_bastion_subnet_id == "") ? 1 : 0
  name                                           = local.bastion_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = local.vnet_name
  address_prefixes                               = [var.bastion_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

resource "azurerm_subnet" "vpn_subnet" {
  count                                          = (var.is_vnet_isolated && var.deploy_vpn && var.existing_vpn_subnet_id == "") ? 1 : 0
  name                                           = local.vpn_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = local.vnet_name
  address_prefixes                               = [var.vpn_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}


locals {
  bastion_subnet_id = (var.existing_bastion_subnet_id == "" && (var.is_vnet_isolated) && var.deploy_bastion) ? azurerm_subnet.bastion_subnet[0].id : var.existing_bastion_subnet_id
}

resource "azurerm_subnet" "vm_subnet" {
  count                                          = (var.is_vnet_isolated && (var.deploy_jumphost || var.deploy_selfhostedsql || var.deploy_h2o-ai) && var.existing_vm_subnet_id == "") ? 1 : 0
  name                                           = local.vm_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = local.vnet_name
  address_prefixes                               = [var.vm_subnet_cidr]
  enforce_private_link_endpoint_network_policies = true
  depends_on = [
    azurerm_virtual_network.vnet
  ]
}

locals {
  vm_subnet_id = (var.existing_vm_subnet_id == "" && (var.is_vnet_isolated && (var.deploy_jumphost || var.deploy_selfhostedsql || var.deploy_h2o-ai))) ? azurerm_subnet.vm_subnet[0].id : var.existing_vm_subnet_id
}


resource "azurerm_subnet" "app_service_subnet" {
  count                                          = (var.is_vnet_isolated && var.deploy_app_service_plan && var.existing_app_service_subnet_id == "") ? 1 : 0
  name                                           = local.app_service_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = local.vnet_name
  address_prefixes                               = [var.app_service_subnet_cidr]
  enforce_private_link_endpoint_network_policies = false
  depends_on = [
    azurerm_virtual_network.vnet
  ]


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


locals {
  app_service_subnet_id = (var.existing_app_service_subnet_id == "" && (var.is_vnet_isolated) && var.deploy_app_service_plan) ? azurerm_subnet.app_service_subnet[0].id : var.existing_app_service_subnet_id
}

resource "azurerm_subnet" "databricks_container_subnet" {
  count                                          = (var.is_vnet_isolated && var.deploy_databricks && var.existing_databricks_container_subnet_id == "") ? 1 : 0
  name                                           = local.databricks_container_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet[0].name
  address_prefixes                               = [var.databricks_container_subnet_cidr]
  depends_on = [
    azurerm_virtual_network.vnet
  ]

  delegation {
    name = "databricks-delegation"

    service_delegation {
      actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      name = "Microsoft.Databricks/workspaces"
    }
  }

  lifecycle {  
    ignore_changes = [
        delegation,
    ]
  }
}

locals {
  databricks_container_subnet_id = (var.existing_databricks_container_subnet_id == "" && var.deploy_databricks && (var.is_vnet_isolated)) ? azurerm_subnet.databricks_container_subnet[0].id : var.existing_databricks_container_subnet_id
}

resource "azurerm_subnet" "databricks_host_subnet" {
  count                                          = (var.is_vnet_isolated && var.deploy_databricks && var.existing_databricks_host_subnet_id == "") ? 1 : 0
  name                                           = local.databricks_host_subnet_name
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.vnet[0].name
  address_prefixes                               = [var.databricks_host_subnet_cidr]
  depends_on = [
    azurerm_virtual_network.vnet
  ]

  delegation {
    name = "databricks-delegation"

    service_delegation {
      actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
      name = "Microsoft.Databricks/workspaces"
    }
  }

  lifecycle {  
    ignore_changes = [
        delegation,
    ]
  }
}

locals {
  databricks_host_subnet_id = (var.existing_databricks_host_subnet_id == "" && var.deploy_databricks && (var.is_vnet_isolated)) ? azurerm_subnet.databricks_host_subnet[0].id : var.existing_databricks_host_subnet_id
}