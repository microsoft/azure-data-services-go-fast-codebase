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
output "is_vnet_isolated" {
  value = var.is_vnet_isolated
}
output "aad_webreg_id" {
  value = var.deploy_web_app ? azuread_application.web_reg[0].application_id : ""
}
output "aad_funcreg_id" {
  value = var.deploy_function_app ? azuread_application.function_app_reg[0].application_id : ""
}
output "purview_sp_id" {
  value = var.deploy_purview && var.is_vnet_isolated ? azuread_application.purview_ir[0].application_id : "0"
}
output "integration_runtimes" {
  value = local.integration_runtimes
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

output "ixup_encryption_gateway_id" {
  value = azurerm_windows_virtual_machine.ixup_egw[*].id
}

output "ixup_encryption_gateway_ip" {
  value = azurerm_windows_virtual_machine.ixup_egw[*].private_ip_address
}

