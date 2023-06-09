output "tenant_id" {
  value = var.tenant_id
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "random_uuid_function_app_reg_role_id" {
  value = random_uuid.function_app_reg_role_id.result
}


/*Variables for Naming Module*/
output "naming_unique_seed" {
  value = module.naming.unique-seed
}

output "naming_unique_suffix" {
  value = substr(module.naming.unique-seed, 0, 4)
}

/*Service Names*/
output "aad_funcreg_id" {
  value = var.deploy_function_app && var.deploy_azure_ad_function_app_registration ? azuread_application.function_app_reg[0].application_id : var.existing_aad_func_appreg_app_id != "" ? var.existing_aad_func_appreg_app_id :  ""
}

output "azuread_service_principal_function_app_object_id" {
  value = var.deploy_function_app && var.deploy_azure_ad_function_app_registration ? azuread_service_principal.function_app[0].object_id : var.existing_aad_func_sp_obj_id != "" ? var.existing_aad_func_sp_obj_id :  ""
}

output "azuread_application_function_app_reg_object_id" {
  value = var.deploy_function_app && var.deploy_azure_ad_function_app_registration ? azuread_application.function_app_reg[0].object_id : var.existing_aad_func_appreg_obj_id != "" ? var.existing_aad_func_appreg_obj_id :  ""
}

output "aad_webreg_id" {
  value = var.deploy_web_app && var.deploy_azure_ad_web_app_registration ? azuread_application.web_reg[0].application_id : var.existing_aad_web_appreg_app_id != "" ? var.existing_aad_web_appreg_app_id :  ""
}

output "webapp_name" {
  value = local.webapp_name
}

output "functionapp_name" {
  value = local.functionapp_name
}

output "aad_webapp_name" {
  value = local.aad_webapp_name
}

output "aad_functionapp_name" {
  value = local.aad_functionapp_name
}

output "purview_name" {
  value = local.purview_name
}
output "purview_sp_name" {
  value = local.purview_ir_app_reg_name
}
output "purview_sp_id" {
  value = var.deploy_purview && var.is_vnet_isolated && var.deploy_purview_sp ? azuread_application.purview_ir[0].application_id : "0"
}

output "azuread_application_purview_ir_object_id" {
  value = var.deploy_purview && var.is_vnet_isolated && var.deploy_purview_sp ? azuread_application.purview_ir[0].object_id : "0"
}


output "purview_sp_object_id" {
  value = var.deploy_purview && var.is_vnet_isolated && var.deploy_purview_sp ? azuread_service_principal.purview_ir[0].object_id : "0"
}

output "delay_private_access" {
  value = var.delay_private_access
}
output "is_vnet_isolated" {
  value = var.is_vnet_isolated
}

