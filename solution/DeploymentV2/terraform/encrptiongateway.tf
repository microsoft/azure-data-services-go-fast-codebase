#---------------------------------------------------------------
# ixup_egw
#---------------------------------------------------------------
resource "azurerm_network_interface" "ixup_egw_nic" {
  count               = var.deploy_ixup_encryption_gw ? 1 : 0
  name                = "ixup_egw_nic"
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.vm_subnet[0].id
    private_ip_address_allocation = "Dynamic"

  }
}
resource "azurerm_windows_virtual_machine" "ixup_egw" {
  count               = var.deploy_ixup_encryption_gw ? 1 : 0
  name                = local.ixup_egw_vm_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  size                = var.ixup_egw_vm_size
  admin_username      = "adminuser"
  admin_password      = var.ixup_egw_password
  network_interface_ids = [
    azurerm_network_interface.ixup_egw_nic[0].id,
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
  lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}

