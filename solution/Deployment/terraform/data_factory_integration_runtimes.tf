# Azure Integration runtime
resource "azurerm_data_factory_integration_runtime_azure" "azure_ir" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if ir.is_azure == true
  }
  name                    = each.value.name
  data_factory_id         = azurerm_data_factory.data_factory.id
  location                = var.resource_location
  resource_group_name     = var.resource_group_name
  time_to_live_min        = 10
  virtual_network_enabled = var.is_vnet_isolated && each.value.is_managed_vnet
}

resource "azurerm_data_factory_integration_runtime_self_hosted" "self_hosted_ir" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if ir.is_azure == false
  }
  name                = each.value.name
  data_factory_id     = azurerm_data_factory.data_factory.id
  resource_group_name = var.resource_group_name
}