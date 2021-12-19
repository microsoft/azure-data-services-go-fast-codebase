resource "azurerm_resource_group_template_deployment" "ingestion_private_endpoints" {
  name                = "purview_ingestion_private_endpoints_${var.name_suffix}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "purviewAccountName" = {
      value = var.purview_account_name
    },    
    "location" = {
      value = var.resource_location
    },
    "queuePrivateLinkName" = {
      value = var.queue_privatelink_name
    },
    "storagePrivateLinkName" = {
      value = var.storage_privatelink_name
    },
    "eventHubPrivateLinkName" = {
      value = var.eventhub_privatelink_name
    },
    "subnetId" = {
      value = var.subnet_id
    },
    "managedResourceGroupName" = {
      value = var.managed_resource_group_name
    }
  })
  template_content = file("${path.module}/arm/privatelinks.json")
}
