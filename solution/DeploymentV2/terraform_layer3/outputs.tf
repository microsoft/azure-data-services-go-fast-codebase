output "tenant_id" {
  value = var.tenant_id
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "sqlserver_name" {
  value = data.terraform_remote_state.layer2.outputs.sqlserver_name
}
output "stagingdb_name" {
  value = data.terraform_remote_state.layer2.outputs.stagingdb_name
}
output "sampledb_name" {
  value = data.terraform_remote_state.layer2.outputs.sampledb_name
}
output "metadatadb_name" {
  value = data.terraform_remote_state.layer2.outputs.metadatadb_name
}
output "datafactory_name" {
  value = data.terraform_remote_state.layer2.outputs.datafactory_name
}
output "synapse_workspace_name" {
  value = data.terraform_remote_state.layer2.outputs.synapse_workspace_name
}
output "synapse_sql_pool_name" {
  value = data.terraform_remote_state.layer2.outputs.synapse_sql_pool_name
}


/*Variables for Naming Module*/
output "naming_unique_seed" {
  value = data.terraform_remote_state.layer2.outputs.naming_unique_seed
}

output "naming_unique_suffix" {
  value = data.terraform_remote_state.layer2.outputs.naming_unique_suffix
}

output "aad_funcreg_id" {
  value = data.terraform_remote_state.layer2.outputs.aad_funcreg_id
}

output "aad_webreg_id" {
  value = data.terraform_remote_state.layer2.outputs.aad_webreg_id
}

output "webapp_name" {
  value = data.terraform_remote_state.layer2.outputs.webapp_name
}

output "functionapp_name" {
  value = data.terraform_remote_state.layer2.outputs.functionapp_name
}
output "delay_private_access" {
  value = var.delay_private_access
}
output "is_vnet_isolated" {
  value = var.is_vnet_isolated
}
