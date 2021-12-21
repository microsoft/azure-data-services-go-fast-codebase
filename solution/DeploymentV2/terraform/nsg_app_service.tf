resource "azurerm_network_security_group" "app_service_nsg" {
  count               = (var.is_vnet_isolated ? 1 : 0)
  name                = local.app_service_nsg_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# start inbound rules
resource "azurerm_network_security_rule" "app_service_in_deny_all" {
  count     = (var.is_vnet_isolated ? 1 : 0)
  name      = "app_service_in_deny_all"
  priority  = 110
  direction = "Inbound"
  access    = "Deny"
  protocol  = "*"

  source_port_range     = "*"
  source_address_prefix = "*"

  destination_port_range     = "*"
  destination_address_prefix = "*"

  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.app_service_nsg[0].name

  depends_on = [
    azurerm_network_security_group.app_service_nsg[0],
  ]
}
# end Inbound rules

# start outbound rules

# association
resource "azurerm_subnet_network_security_group_association" "app_service_nsg" {
  count                     = (var.is_vnet_isolated ? 1 : 0)
  subnet_id                 = azurerm_subnet.app_service_subnet[0].id
  network_security_group_id = azurerm_network_security_group.app_service_nsg[0].id
  timeouts {}
  # The subnet will refuse to accept the NSG if it's not this exact
  # list so we need to ensure the rules are deployed before the association
  depends_on = [
    azurerm_network_security_rule.app_service_in_deny_all[0],
    azurerm_subnet.app_service_subnet[0],
  ]
}
