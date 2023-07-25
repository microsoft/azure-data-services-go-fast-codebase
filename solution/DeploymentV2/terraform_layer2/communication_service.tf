resource "azurerm_communication_service" "communication_service" {
  count               = var.deploy_communication_service ? 1 : 0
  name                = local.azure_communication_service_name
  resource_group_name = var.resource_group_name
  data_location       = "Australia"
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_email_communication_service" "email_communication_service" {
  count               = var.deploy_email_communication_service ? 1 : 0
  name                = local.azure_email_communication_service_name
  resource_group_name = var.resource_group_name
  data_location       = "Australia"
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}