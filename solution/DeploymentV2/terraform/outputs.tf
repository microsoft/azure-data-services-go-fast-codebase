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
  value = azurerm_log_analytics_workspace.log_analytics_workspace.workspace_id
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
  value = azuread_application.web_reg[0].application_id
}
output "aad_funcreg_id" {
  value = azuread_application.function_app_reg[0].application_id
}
output "purview_sp_id" {
  value = var.deploy_purview ?   azuread_application.purview_ir[0].application_id : "0"
}
output "integration_runtimes" {
  value = local.integration_runtimes
}
output "is_onprem_datafactory_ir_registered" {
  value = var.is_onprem_datafactory_ir_registered
}
output "publish_web_app" {
  value = var.publish_web_app
}
output "publish_function_app" {
  value = var.publish_function_app
}
output "publish_sample_files" {
  value = var.publish_sample_files
}
output "publish_database" {
  value = var.publish_database
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
  value = var.deploy_synapse ?   azurerm_synapse_workspace.synapse[0].name : ""
}
output "synapse_sql_pool_name" {
  value = var.deploy_synapse && var.deploy_synapse_sqlpool ?   azurerm_synapse_sql_pool.synapse_sql_pool[0].name : ""
}
output "synapse_spark_pool_name" {
  value = var.deploy_synapse && var.deploy_synapse_sparkpool ?   azurerm_synapse_spark_pool.synapse_spark_pool[0].name : ""
}