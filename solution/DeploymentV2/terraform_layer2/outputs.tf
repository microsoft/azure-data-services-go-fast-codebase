output "tenant_id" {
  value = var.tenant_id
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "webapp_name" {
  value = local.webapp_name
}

output "functionapp_name" {
  value = local.functionapp_name
}

output "sqlserver_name" {
  value = local.sql_server_name
}

output "blobstorage_name" {
  value = local.blob_storage_account_name
}

output "adlsstorage_name" {
  value = local.adls_storage_account_name
}

output "datafactory_name" {
  value = local.data_factory_name
}

output "datafactory_principal_id" {
  value = var.deploy_data_factory ? azurerm_data_factory.data_factory[0].identity[0].principal_id : ""
}

output "function_app_principal_id" {
  value = var.deploy_function_app ? azurerm_function_app.function_app[0].identity[0].principal_id : ""
}

output "aad_webapp_name" {
  value = local.aad_webapp_name
}

output "aad_functionapp_name" {
  value = local.aad_functionapp_name
}

output "azurerm_key_vault_app_vault_id" {
  value = azurerm_key_vault.app_vault.id
}

output "keyvault_name" {
  value = local.key_vault_name
}

output "stagingdb_name" {
  value = local.staging_database_name
}

output "sampledb_name" {
  value = local.sample_database_name
}

output "metadatadb_name" {
  value = local.metadata_database_name
}
output "loganalyticsworkspace_id" {
  value = local.log_analytics_workspace_id
}
output "subscription_id" {
  value = var.subscription_id
}
output "purview_name" {
  value = local.purview_name
}
output "purview_sp_name" {
  value = local.purview_ir_app_reg_name
}
output "azurerm_purview_account_purview_id" {
  value =   var.deploy_purview ? azurerm_purview_account.purview[0].id : ""
}
output "is_vnet_isolated" {
  value = var.is_vnet_isolated
}
output "aad_webreg_id" {
  value = data.terraform_remote_state.layer1.outputs.aad_webreg_id 
}
output "aad_funcreg_id" {
  value = data.terraform_remote_state.layer1.outputs.aad_funcreg_id 
}
output "purview_sp_id" {
  value = data.terraform_remote_state.layer1.outputs.purview_sp_id 
}
output "integration_runtimes" {
  value = local.integration_runtimes
}
output "synapse_integration_runtimes" {
  value = local.synapse_integration_runtimes
}
output "virtual_machine_integration_runtimes" {
  value = local.virtual_machine_integration_runtimes
}
output "is_onprem_datafactory_ir_registered" {
  value = var.is_onprem_datafactory_ir_registered
}

output "jumphost_vm_name" {
  value = local.jumphost_vm_name
}

output "deploy_web_app" {
  value = var.deploy_web_app
}
output "deploy_function_app" {
  value = var.deploy_function_app
}
  
output "publish_web_app" {
  value = var.publish_web_app
}
output "publish_function_app" {
  value = var.publish_function_app
}
output "deploy_custom_terraform" {
  value = var.deploy_custom_terraform
}
output "publish_sample_files" {
  value = var.publish_sample_files
}
output "publish_metadata_database" {
  value = var.publish_metadata_database
}
output "publish_sql_logins" {
  value = var.publish_sql_logins
}
output "publish_functional_tests" {
  value = var.publish_functional_tests
}
output "publish_purview_configuration" {
  value = var.publish_purview_configuration
}
output "deploy_sql_server" {
  value = var.deploy_sql_server
}
output "deploy_synapse" {
  value = var.deploy_synapse
}
output "deploy_metadata_database" {
  value = var.deploy_metadata_database
}
output "configure_networking" {
  value = var.configure_networking
}
output "publish_datafactory_pipelines" {
  value = var.publish_datafactory_pipelines
}
output "publish_web_app_addcurrentuserasadmin" {
  value = var.publish_web_app_addcurrentuserasadmin
}
output "azure_sql_aad_administrators" {
  value = var.azure_sql_aad_administrators
}
output "azure_purview_data_curators" {
  value = var.azure_purview_data_curators
}
output "synapse_workspace_name" {
  value = var.deploy_synapse ? azurerm_synapse_workspace.synapse[0].name : ""
}
output "synapse_sql_pool_name" {
  value = var.deploy_synapse && var.deploy_synapse_sqlpool ? azurerm_synapse_sql_pool.synapse_sql_pool[0].name : ""
}
output "synapse_spark_pool_name" {
  value = var.deploy_synapse && var.deploy_synapse_sparkpool ? azurerm_synapse_spark_pool.synapse_spark_pool[0].name : ""
}
output "selfhostedsqlvm_name" {
  value = local.selfhostedsqlvm_name
}

output "synapse_git_toggle_integration" {
  value = var.synapse_git_toggle_integration
}
output "update_execution_engine_jsons" {
  value = var.update_execution_engine_jsons
}

output "synapse_git_integration_type" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_integration_type : ""
}
output "synapse_git_repository_root_folder" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_repository_root_folder : ""
}
output "synapse_git_repository_owner" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_repository_owner : ""
}
output "synapse_git_repository_name" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_repository_name : ""
}
output "synapse_git_repository_branch_name" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_repository_branch_name : ""
}
output "functionapp_url" {
  value = var.synapse_git_toggle_integration ? local.functionapp_url : ""
}
output "keyvault_url" {
  value = var.synapse_git_toggle_integration ? azurerm_key_vault.app_vault.vault_uri : ""
}
output "synapse_git_devops_project_name" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_devops_project_name : ""
}
/* NOT CURRENTLY USED
output "synapse_git_repository_base_url" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_repository_base_url : ""
} */
output "synapse_git_use_pat" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_use_pat : false
}
output "synapse_git_pat" {
  value = var.synapse_git_use_pat ? var.synapse_git_pat : ""
}
output "synapse_git_user_name" {
  value = var.synapse_git_user_name
}
output "synapse_git_email_address" {
  value = var.synapse_git_email_address
}
output "synapse_git_github_host_url" {
  value = var.synapse_git_toggle_integration ? var.synapse_git_github_host_url : ""
}
output "synapse_git_devops_tenant_id" {
  value = var.synapse_git_devops_tenant_id != "" ? var.synapse_git_devops_tenant_id : var.tenant_id
}
output "adf_git_toggle_integration" {
  value = var.adf_git_toggle_integration
}
output "adf_git_repository_root_folder" {
  value = var.adf_git_toggle_integration ? var.adf_git_repository_root_folder : ""
}
output "adf_git_repository_owner" {
  value = var.adf_git_toggle_integration ? var.adf_git_repository_owner : ""
}
output "adf_git_repository_name" {
  value = var.adf_git_toggle_integration ? var.adf_git_repository_name : ""
}
output "adf_git_repository_branch_name" {
  value = var.adf_git_toggle_integration ? var.adf_git_repository_branch_name : ""
}
output "adf_git_use_pat" {
  value = var.adf_git_toggle_integration ? var.adf_git_use_pat : false
}
output "adf_git_pat" {
  value = var.adf_git_use_pat ? var.adf_git_pat : ""
}
output "adf_git_user_name" {
  value = var.adf_git_user_name
}
output "adf_git_email_address" {
  value = var.adf_git_email_address
}
output "adf_git_host_url" {
  value = var.adf_git_toggle_integration ? var.adf_git_host_url : ""
}
output "synapse_lakedatabase_container_name" {
  value = var.deploy_synapse ? azurerm_storage_data_lake_gen2_filesystem.dlfs[0].name : ""
}
output "publish_sif_database" {
  value = var.publish_sif_database
}
output "sif_database_name" {
  value = var.sif_database_name
}

output "azurerm_function_app_identity_principal_id" {
  value = var.deploy_function_app ? azurerm_function_app.function_app[0].identity[0].principal_id : ""
}

output "databricks_workspace_name" {
  value = local.databricks_workspace_name
}

output "deploy_databricks"{
  value = var.deploy_databricks
}

output "databricks_workspace_url" {
  value = var.deploy_databricks ? azurerm_databricks_workspace.workspace[0].workspace_url : ""
}

output "databricks_workspace_id" {
  value = var.deploy_databricks ? azurerm_databricks_workspace.workspace[0].id : ""
}

output "databricks_instance_pool_id" {
  value = var.deploy_databricks && var.deploy_databricks_resources ? databricks_instance_pool.default_node[0].id: ""
}


/*Variables from Previous Layer*/
output "random_uuid_function_app_reg_role_id" {
  value = data.terraform_remote_state.layer1.outputs.random_uuid_function_app_reg_role_id
}

output "azuread_service_principal_function_app_object_id" {
  value = data.terraform_remote_state.layer1.outputs.azuread_service_principal_function_app_object_id
}

output "azuread_application_function_app_reg_object_id" {
  value = data.terraform_remote_state.layer1.outputs.azuread_application_function_app_reg_object_id
}

output "purview_sp_object_id" {
  value = data.terraform_remote_state.layer1.outputs.purview_sp_object_id
}

output "purview_account_principal_id" {
  value = var.deploy_purview && var.is_vnet_isolated ? azurerm_purview_account.purview[0].identity[0].principal_id : "0"
}


output "azuread_application_purview_ir_object_id" {
  value = data.terraform_remote_state.layer1.outputs.azuread_application_purview_ir_object_id
}


/*Variables for Naming Module*/
output "naming_unique_seed" {
  value = data.terraform_remote_state.layer1.outputs.naming_unique_seed
}

output "naming_unique_suffix" {
  value = data.terraform_remote_state.layer1.outputs.naming_unique_suffix
}

/*DNS Zone*/
output "private_dns_zone_servicebus_id" {
  value = data.terraform_remote_state.layer0.outputs.private_dns_zone_servicebus_id 
}

output "private_dns_zone_queue_id" {
  value = data.terraform_remote_state.layer0.outputs.private_dns_zone_queue_id 
}

output "private_dns_zone_blob_id" {
  value = data.terraform_remote_state.layer0.outputs.private_dns_zone_blob_id 
}

output "private_dns_zone_dfs_id" {
  value = data.terraform_remote_state.layer0.outputs.private_dns_zone_dfs_id 
}


output "private_dns_zone_purview_id" {
  value = data.terraform_remote_state.layer0.outputs.private_dns_zone_purview_id 
}

output "private_dns_zone_purview_studio_id" {
  value = data.terraform_remote_state.layer0.outputs.private_dns_zone_purview_studio_id 
}

output "plink_subnet_id" {
  value = data.terraform_remote_state.layer0.outputs.plink_subnet_id 
}

output "azurerm_virtual_network_vnet_name" {
  value = data.terraform_remote_state.layer0.outputs.azurerm_virtual_network_vnet_name 
}

output "adls_vm_cmd_executor_name" {
  value = local.adls_vm_cmd_executor_name
}
output "cmd_executor_vm_name" {
  value = local.cmd_executor_vm_name
}
output "deploy_cmd_executor_vm" {
  value = var.deploy_cmd_executor_vm
}