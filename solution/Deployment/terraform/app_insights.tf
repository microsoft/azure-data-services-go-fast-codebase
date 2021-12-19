resource "azurerm_application_insights" "app_insights" {
  count               = (var.deploy_app_insights ? 1 : 0)
  name                = local.app_insights_name
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  workspace_id        = azurerm_log_analytics_workspace.log_analytics_workspace.id
  application_type    = "web"
  tags                = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_role_assignment" "app_insights_web_app" {
  count                = (var.deploy_app_insights ? 1 : 0)
  scope                = azurerm_application_insights.app_insights[0].id
  role_definition_name = "Contributor"
  principal_id         = azurerm_app_service.web[0].identity[0].principal_id
}