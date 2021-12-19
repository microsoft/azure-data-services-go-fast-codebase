
resource "azurerm_network_interface" "jumphost_nic" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "jumphost_nic"
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet[0].id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "jumphost" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = local.jumphost_vm_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2s"
  admin_username      = "adminuser"
  admin_password      = var.jumphost_password
  network_interface_ids = [
    azurerm_network_interface.jumphost_nic[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}