resource "azurerm_network_interface" "cicd_vm_nic" {
  count               = var.is_vnet_isolated && var.deploy_cicd_vm ? 1 : 0
  name                = local.cicdagent_nic_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_virtual_machine" "cicd_vm_linux" {
  count                           = var.deploy_cicd_vm ? 1 : 0
  name                            = "CICDAgent"
  location                        = var.resource_location
  resource_group_name             = var.resource_group_name
  vm_size                            = "Standard_D2s_v3"      
  network_interface_ids = [
    azurerm_network_interface.cicd_vm_nic[0].id,
  ]
  
  os_profile {
    computer_name  = "CICDAgent"
    admin_username = "adminuser"
    admin_password = var.jumphost_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }

  storage_image_reference    {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  storage_os_disk   {
    name              = "cicd_vm_linux_disk"
    caching           = "ReadWrite"
    create_option     = "FromImage"    
    managed_disk_type = "Premium_LRS"
    disk_size_gb      = "30"    
  }

  lifecycle {
    ignore_changes = [
      os_profile
    ]
  }
}

