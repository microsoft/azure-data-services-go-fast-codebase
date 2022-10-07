resource "azurerm_network_security_group" "plink_nsg" {
  count               = (var.is_vnet_isolated && var.existing_plink_subnet_id == "" ? 1 : 0)
  name                = local.plink_nsg_name
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

# Outbound Rules
resource "azurerm_network_security_rule" "plink_out_deny_all" {
  count     = (var.is_vnet_isolated && var.existing_plink_subnet_id == "" ? 1 : 0)
  name      = "plink_out_deny_all"
  priority  = 110
  direction = "Outbound"
  access    = "Deny"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "*"

  destination_port_range     = "*"
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.plink_nsg[0].name

  depends_on = [
    azurerm_network_security_group.plink_nsg[0],
  ]
}

# Associate NSG with subnet

resource "azurerm_subnet_network_security_group_association" "plink_nsg" {
  count                     = (var.is_vnet_isolated && var.existing_plink_subnet_id == "" ? 1 : 0)
  subnet_id                 = local.plink_subnet_id
  network_security_group_id = azurerm_network_security_group.plink_nsg[0].id

  # The subnet will refuse to accept the NSG if it's not this exact
  # list so we need to ensure the rules are deployed before the association
  depends_on = [
    azurerm_network_security_rule.plink_out_deny_all[0],
    azurerm_subnet.plink_subnet[0],
  ]
  timeouts {}
}
