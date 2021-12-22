resource "azurerm_resource_group_template_deployment" "azure_pipelines_level_0" {
  for_each            = {
    for pipeline in fileset(path.module, "arm/GPL0_Azure*.json"):  
    pipeline => pipeline 
  }
  name                = "${replace(replace(each.value, ".json", ""), "arm/", "")}_${var.integration_runtime_short_name}_${var.name_suffix}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "dataFactoryName" = {
      value = var.data_factory_name
    },    
    "integrationRuntimeName" = {
      value = var.integration_runtime_name
    },
    "integrationRuntimeShortName" = {
      value = var.integration_runtime_short_name
    },
    "sharedKeyVaultUri" = {
      value = var.shared_keyvault_uri
    },
  })
  template_content = file("${path.module}/${each.value}")
}

resource "azurerm_resource_group_template_deployment" "azure_pipelines" {
  for_each            = {
    for pipeline in fileset(path.module, "arm/GPL_Azure*.json"):  
    pipeline => pipeline 
  }
  name                = "${replace(replace(each.value, ".json", ""), "arm/", "")}_${var.integration_runtime_short_name}_${var.name_suffix}"
  resource_group_name = var.resource_group_name
  deployment_mode     = "Incremental"
  parameters_content = jsonencode({
    "dataFactoryName" = {
      value = var.data_factory_name
    },    
    "integrationRuntimeName" = {
      value = var.integration_runtime_name
    },
    "integrationRuntimeShortName" = {
      value = var.integration_runtime_short_name
    },
    "sharedKeyVaultUri" = {
      value = var.shared_keyvault_uri
    },
  })
  template_content = file("${path.module}/${each.value}")
  depends_on = [
    azurerm_resource_group_template_deployment.azure_pipelines_level_0
  ]
}
