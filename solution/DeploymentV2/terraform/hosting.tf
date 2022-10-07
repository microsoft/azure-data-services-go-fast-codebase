# Hosting environment including app service plan and App Insights instance.

#in app_insights  <-- appinsights
#resource "azurerm_application_insights" "appinsights" {
#    name = local.app_insights_name
#    location = var.resource_location
#    resource_group_name = var.resource_group_name
#    application_type = "web"
#    tags = var.azure_tags
#}