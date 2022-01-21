# module "data_factory_pipelines_common" {
#   source                            = "./modules/data_factory_pipelines_common"
#   resource_group_name               = var.resource_group_name
#   data_factory_name                 = local.data_factory_name
#   linkedservice_azure_function_name = local.linkedservice_azure_function_name
#   name_suffix                       = random_id.rg_deployment_unique.id
#   depends_on = [
#     module.data_factory_datasets,
#     azurerm_data_factory_linked_service_azure_function.function_app
#   ]
# }

# # Azure pipelines
# module "data_factory_pipelines_azure" {
#   source = "./modules/data_factory_pipelines_azure"
#   for_each = {
#     for ir in local.integration_runtimes :
#     ir.short_name => ir
#     if ir.is_azure == true 
#   }
#   resource_group_name            = var.resource_group_name
#   data_factory_name              = local.data_factory_name
#   shared_keyvault_uri            = "https://${local.key_vault_name}.vault.azure.net/"
#   integration_runtime_name       = each.value.name
#   integration_runtime_short_name = each.value.short_name
#   name_suffix                    = random_id.rg_deployment_unique.id
#   depends_on = [
#     module.data_factory_datasets,
#     module.data_factory_pipelines_common
#   ]
# }

# module "data_factory_pipelines_selfhosted" {
#   source = "./modules/data_factory_pipelines_selfhosted"
#   for_each = {
#     for ir in local.integration_runtimes :
#     ir.short_name => ir
#     if(ir.is_azure == false && var.is_onprem_datafactory_ir_registered == true)
#   }
#   resource_group_name            = var.resource_group_name
#   data_factory_name              = local.data_factory_name
#   shared_keyvault_uri            = "https://${local.key_vault_name}.vault.azure.net/"
#   integration_runtime_name       = each.value.name
#   integration_runtime_short_name = each.value.short_name
#   name_suffix                    = random_id.rg_deployment_unique.id
#   depends_on = [
#     module.data_factory_datasets,
#     module.data_factory_pipelines_common
#   ]
# }