#---------------------------------------------------------------
# Jumphost
#---------------------------------------------------------------

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
  admin_password      = local.jumphost_password
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
   lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}

#---------------------------------------------------------------
# Self Hosted Sql Server
#---------------------------------------------------------------

resource "random_password" "selfhostedsql" {
  count               = var.deploy_selfhostedsql ? 1 : 0
  length      = 32
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  number      = true
  upper       = true
}

resource "azurerm_public_ip" "selfhostedsql" {
  count               = var.deploy_selfhostedsql ? 1 : 0
  name                = "selfhostedsqlip"
  location            = var.resource_location
  allocation_method = "Dynamic"
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "selfhostedsql_nic" {
  count               = var.deploy_selfhostedsql ? 1 : 0
  name                = "selfhostedsql_nic"
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "external"    
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.vm_subnet[0].id
    public_ip_address_id = azurerm_public_ip.selfhostedsql[0].id
  }
}


resource "azurerm_windows_virtual_machine" "selfhostedsqlvm" {
  count                              = var.deploy_selfhostedsql ? 1 : 0
  name                               = local.selfhostedsqlvm_name
  location                           = var.resource_location
  resource_group_name                = var.resource_group_name
  size                               = "Standard_D4_v3"
  admin_username                     = "adminuser"
  admin_password                     = random_password.selfhostedsql[0].result
  network_interface_ids              = [
    azurerm_network_interface.selfhostedsql_nic[0].id,
  ]


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2019-ws2019"
    sku       = "sqldev"
    version   = "latest"
  }
   lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}