#---------------------------------------------------------------
# Jumphost
#---------------------------------------------------------------

resource "azurerm_network_interface" "jumphost_nic" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = local.jumphost_nic_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_windows_virtual_machine" "jumphost" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = local.jumphost_vm_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  size                = var.vm_size
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
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-21h2-ent-ltsc-g2"
    version   = "latest"
  }
  lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}

#---------------------------------------------------------------
# VM Executor
#---------------------------------------------------------------

resource "random_password" "cmd_executor_vm" {
  count       = var.deploy_cmd_executor_vm ? 1 : 0
  length      = 16
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  numeric     = true
  upper       = true
}


resource "azurerm_network_interface" "cmd_executor_vm_nic" {
  count               = var.is_vnet_isolated && var.deploy_cmd_executor_vm ? 1 : 0
  name                = local.cmd_executor_vm_nic_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = local.vm_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_linux_virtual_machine" "cmd_executor_vm_linux" {
  count                           = var.deploy_cmd_executor_vm ? 1 : 0
  name                            = local.cmd_executor_vm_name
  location                        = var.resource_location
  resource_group_name             = var.resource_group_name
  size                         = var.cmd_executor_vm_size
  admin_username                  = "adminuser"
  admin_password                  = random_password.cmd_executor_vm
  disable_password_authentication = false
  computer_name                   = "CMDExecutor"

  network_interface_ids = [
    azurerm_network_interface.cmd_executor_vm_nic[0].id,
  ]

  source_image_reference    {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  os_disk   {
    name              = "cmd_executor_vm_linux_disk"
    caching           = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb      = "30"    
  }

  identity {
    type              = "SystemAssigned" 
  }

  lifecycle {
    ignore_changes = [
      os_disk
    ]
  }
}

##TODO: Add vm extension for executing set up sh file (pwsh etc)

#---------------------------------------------------------------
# Self Hosted Sql Server
#---------------------------------------------------------------

resource "random_password" "selfhostedsql" {
  count       = var.deploy_selfhostedsql ? 1 : 0
  length      = 32
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  numeric      = true
  upper       = true
}

resource "azurerm_public_ip" "selfhostedsql" {
  count               = var.deploy_selfhostedsql ? 1 : 0
  name                = "selfhostedsqlip"
  location            = var.resource_location
  allocation_method   = "Dynamic"
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface" "selfhostedsql_nic" {
  count               = var.deploy_selfhostedsql ? 1 : 0
  name                = "selfhostedsql_nic"
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "external"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = local.vm_subnet_id
    public_ip_address_id          = azurerm_public_ip.selfhostedsql[0].id
  }
}




resource "azurerm_windows_virtual_machine" "selfhostedsqlvm" {
  count               = var.deploy_selfhostedsql ? 1 : 0
  name                = local.selfhostedsqlvm_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  size                = "Standard_D4_v3"
  admin_username      = "adminuser"
  admin_password      = random_password.selfhostedsql[0].result
  network_interface_ids = [
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

#---------------------------------------------------------------
# H2O - AI VM
#---------------------------------------------------------------
resource "random_password" "h2o-ai" {
  count       = var.deploy_h2o-ai ? 1 : 0
  length      = 32
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  numeric      = true
  upper       = true
}


#resource "azurerm_public_ip" "h2o-ai" {
#  count               = var.deploy_h2o-ai ? 1 : 0
#  name                = "h2oaiip"
#  location            = var.resource_location
#  allocation_method   = "Dynamic"
#  resource_group_name = var.resource_group_name
#}

resource "azurerm_network_interface" "h2o-ai_nic" {
  count               = var.deploy_h2o-ai ? 1 : 0
  name                = "h2o-ai_nic"
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = local.vm_subnet_id
  }
}


resource "azurerm_linux_virtual_machine" "h2o-ai" {
  count                           = var.deploy_h2o-ai ? 1 : 0
  name                            = local.h2o-ai_name
  location                        = var.resource_location
  resource_group_name             = var.resource_group_name
  size                            = "Standard_D4_v3"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  admin_password                  = random_password.h2o-ai[0].result
  network_interface_ids = [
    azurerm_network_interface.h2o-ai_nic[0].id,
  ]

  plan {
    name      = "h2o-dai-lts"
    publisher = "h2o-ai"
    product   = "h2o-driverles-ai"
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "h2o-ai"
    offer     = "h2o-driverles-ai"
    sku       = "h2o-dai-lts"
    version   = "latest"
  }
  lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}

#---------------------------------------------------------------
# Custom Image VM
#---------------------------------------------------------------
resource "random_password" "custom_vm" {
  count       = var.deploy_custom_vm ? 1 : 0
  length      = 32
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  numeric       = true
  upper       = true
}


resource "azurerm_network_interface" "custom_vm_nic" {
  count               = var.deploy_custom_vm ? 1 : 0
  name                = "custom_vm_nic"
  location            = var.resource_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = local.vm_subnet_id
  }
}


resource "azurerm_linux_virtual_machine" "custom_vm_linux" {
  count                           = var.deploy_custom_vm && var.custom_vm_os == "linux" ? 1 : 0
  name                            = local.custom_vm_name
  location                        = var.resource_location
  resource_group_name             = var.resource_group_name
  size                            = "Standard_D4_v3"
  admin_username                  = "adminuser"
  disable_password_authentication = false
  admin_password                  = random_password.custom_vm[0].result
  network_interface_ids = [
    azurerm_network_interface.custom_vm_nic[0].id,
  ]

  dynamic "plan" {
    for_each = ((var.custom_vm_plan_name != "" && var.custom_vm_plan_publisher != "" && var.custom_vm_plan_product != "") ? [true] : [])
    content {
      name      = var.custom_vm_plan_name
      publisher = var.custom_vm_plan_publisher
      product   = var.custom_vm_plan_product
    }
  }

  dynamic "source_image_reference" {
    for_each = ((var.custom_vm_image_publisher != "" && var.custom_vm_image_offer != "" && var.custom_vm_image_sku != "") ? [true] : [])
    content {
      publisher = var.custom_vm_image_publisher
      offer     = var.custom_vm_image_offer
      sku       = var.custom_vm_image_sku
      version   = var.custom_vm_image_version
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}


resource "azurerm_windows_virtual_machine" "custom_vm_windows" {
  count                           = var.deploy_custom_vm && var.custom_vm_os == "windows" ? 1 : 0
  name                            = local.custom_vm_name
  location                        = var.resource_location
  resource_group_name             = var.resource_group_name
  size                            = "Standard_D4_v3"
  admin_username                  = "adminuser"
  admin_password                  = random_password.custom_vm[0].result
  network_interface_ids = [
    azurerm_network_interface.custom_vm_nic[0].id,
  ]

  dynamic "plan" {
    for_each = ((var.custom_vm_plan_name != "" && var.custom_vm_plan_publisher != "" && var.custom_vm_plan_product != "") ? [true] : [])
    content {
      name      = var.custom_vm_plan_name
      publisher = var.custom_vm_plan_publisher
      product   = var.custom_vm_plan_product
    }
  }

  dynamic "source_image_reference" {
    for_each = ((var.custom_vm_image_publisher != "" && var.custom_vm_image_offer != "" && var.custom_vm_image_sku != "") ? [true] : [])
    content {
      publisher = var.custom_vm_image_publisher
      offer     = var.custom_vm_image_offer
      sku       = var.custom_vm_image_sku
      version   = var.custom_vm_image_version
    }
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  lifecycle {
    ignore_changes = [
      admin_password
    ]
  }
}