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
