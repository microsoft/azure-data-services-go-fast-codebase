
/*DNS Zone*/
output "private_dns_zone_servicebus_id" {
  value = local.private_dns_zone_servicebus_id
}

output "private_dns_zone_queue_id" {
  value = local.private_dns_zone_queue_id
}

output "private_dns_zone_blob_id" {
  value = local.private_dns_zone_blob_id
}

output "private_dns_zone_dfs_id" {
  value = local.private_dns_zone_dfs_id
}


output "private_dns_zone_purview_id" {
  value = local.private_dns_zone_purview_id
}

output "private_dns_zone_purview_studio_id" {
  value = local.private_dns_zone_purview_studio_id
}


output "private_dns_zone_synapse_sql_id" {
  value = local.private_dns_zone_synapse_sql_id
}

output "private_dns_zone_synapse_gateway_id" {
  value = local.private_dns_zone_synapse_gateway_id
}


output "private_dns_zone_synapse_studio_id" {
  value = local.private_dns_zone_synapse_studio_id
}

output "plink_subnet_id" {
  value = local.plink_subnet_id
}

output "azurerm_virtual_network_vnet_name" {
  value = var.is_vnet_isolated ? azurerm_virtual_network.vnet[0].name : ""
}

output "private_dns_zone_db_id" {
  value = local.private_dns_zone_db_id
}

output "app_service_subnet_id" {
  value = local.app_service_subnet_id
}

output "vm_subnet_id" {
  value = local.vm_subnet_id
}

output "private_dns_zone_kv_id" {
  value = local.private_dns_zone_kv_id
}

/*Variables for Naming Module*/
output "naming_unique_seed" {
  value = module.naming.unique-seed
}

output "naming_unique_suffix" {
  value = substr(module.naming.unique-seed, 0, 4)
}