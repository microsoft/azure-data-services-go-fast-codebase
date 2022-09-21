resource "azurerm_network_security_group" "bastion_nsg" {
  count               = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name                = local.bastion_nsg_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  tags                = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# Inbound Rules
resource "azurerm_network_security_rule" "bastion_inbound_internet" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "inbound_internet_allow"
  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "Internet"

  destination_port_range     = "443"
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
resource "azurerm_network_security_rule" "bastion_inbound_control_plane" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "inbound_control_plane_allow"
  priority  = 110
  direction = "Inbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "GatewayManager"

  destination_port_range     = "443"
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
resource "azurerm_network_security_rule" "bastion_inbound_data_plane" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "inbound_data_plane_allow"
  priority  = 120
  direction = "Inbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "VirtualNetwork"

  destination_port_ranges    = ["8080", "5701"]
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
resource "azurerm_network_security_rule" "bastion_inbound_load_balancer" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "inbound_load_balancer_allow"
  priority  = 130
  direction = "Inbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "AzureLoadBalancer"

  destination_port_range     = "443"
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
#--------------------------------------------------------------------------------------------------------
# Outbound Rules
resource "azurerm_network_security_rule" "bastion_outbound_bastion_vms" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "outbound_bastion_vnet_allow"
  priority  = 110
  direction = "Outbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "*"

  destination_port_ranges    = ["3389", "22"]
  destination_address_prefix = "VirtualNetwork"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
resource "azurerm_network_security_rule" "bastion_outbound_dataplane" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "bastion_outbound_dataplane_allow"
  priority  = 120
  direction = "Outbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "*"

  destination_port_ranges    = ["8080", "5701"]
  destination_address_prefix = "VirtualNetwork"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
resource "azurerm_network_security_rule" "bastion_outbound_azure" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "bastion_outbound_azure_allow"
  priority  = 130
  direction = "Outbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "*"

  destination_port_range     = "443"
  destination_address_prefix = "AzureCloud"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}
resource "azurerm_network_security_rule" "bastion_outbound_internet" {
  count     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  name      = "bastion_outbound_internet_allow"
  priority  = 140
  direction = "Outbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "*"

  destination_port_range     = "80"
  destination_address_prefix = "Internet"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.bastion_nsg[0].name

  depends_on = [
    azurerm_network_security_group.bastion_nsg[0],
  ]
}

# Associate NSG with subnet

resource "azurerm_subnet_network_security_group_association" "bastion_nsg" {
  count                     = (var.is_vnet_isolated && var.existing_bastion_subnet_id == "" ? 1 : 0)
  subnet_id                 = local.bastion_subnet_id
  network_security_group_id = azurerm_network_security_group.bastion_nsg[0].id

  # The subnet will refuse to accept the NSG if it's not this exact
  # list so we need to ensure the rules are deployed before the association
  depends_on = [
    azurerm_network_security_rule.bastion_inbound_internet[0],
    azurerm_network_security_rule.bastion_inbound_control_plane[0],
    azurerm_network_security_rule.bastion_inbound_data_plane[0],
    azurerm_network_security_rule.bastion_inbound_load_balancer[0],
    azurerm_network_security_rule.bastion_outbound_bastion_vms[0],
    azurerm_network_security_rule.bastion_outbound_dataplane[0],
    azurerm_network_security_rule.bastion_outbound_azure[0],
    azurerm_network_security_rule.bastion_outbound_internet[0],
    azurerm_subnet.bastion_subnet[0],
  ]
  timeouts {}
}
