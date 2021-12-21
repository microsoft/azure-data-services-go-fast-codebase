resource "azurerm_app_service_plan" "app_service_plan" {
  count               = (var.deploy_app_service_plan ? 1 : 0)
  name                = local.app_service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  kind                = "Windows"
  reserved            = false

  sku {
    tier     = var.app_service_sku.tier
    size     = var.app_service_sku.size
    capacity = var.app_service_sku.capacity
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
