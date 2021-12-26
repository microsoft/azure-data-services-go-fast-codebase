resource "azurerm_resource_group_template_deployment" "pipeline_generic_function" {
  name                = "AZ_Function_Generic_${var.name_suffix}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "dataFactoryName" = {
      value = var.data_factory_name
    },
    "functionLinkedServiceName" = {
      value = var.linkedservice_azure_function_name
    }
  })
  template_content = file("${path.module}/arm/SPL_AzureFunction.json")
}
