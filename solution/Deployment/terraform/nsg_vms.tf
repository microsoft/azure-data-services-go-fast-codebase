resource "azurerm_network_security_group" "vm_nsg" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = local.vm_nsg_name
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
resource "azurerm_network_security_rule" "vm_inbound_bastion" {
  count     = (var.is_vnet_isolated ? 1 : 0)
  name      = "inbound_bastion_allow"
  priority  = 110
  direction = "Inbound"
  access    = "Allow"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = var.bastion_subnet_cidr

  destination_port_ranges    = ["22", "3389"]
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.vm_nsg[0].name

  depends_on = [
    azurerm_network_security_group.vm_nsg[0],
  ]
}
# Outbound Rules

# Associate NSG with subnet

resource "azurerm_subnet_network_security_group_association" "vm_nsg" {
  count                     = (var.is_vnet_isolated ? 1 : 0)
  subnet_id                 = azurerm_subnet.vm_subnet[0].id
  network_security_group_id = azurerm_network_security_group.vm_nsg[0].id

  # The subnet will refuse to accept the NSG if it's not this exact
  # list so we need to ensure the rules are deployed before the association
  depends_on = [
    azurerm_subnet.vm_subnet[0],
  ]
  timeouts {}
}
