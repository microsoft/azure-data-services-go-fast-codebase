module "data_factory_datasets" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
  }
  source                         = "./modules/data_factory_datasets"
  resource_group_name            = var.resource_group_name
  data_factory_name              = local.data_factory_name
  is_azure                       = each.value.is_azure
  integration_runtime_name       = each.value.name
  integration_runtime_short_name = each.value.short_name
  azure_sql_linkedservice_name   = "${local.linkedservice_generic_azuresql_prefix}${each.value.short_name}"
  data_lake_linkedservice_name   = "${local.linkedservice_generic_adls_prefix}${each.value.short_name}"
  blob_linkedservice_name        = "${local.linkedservice_generic_blob_prefix}${each.value.short_name}"
  mssql_linkedservice_name       = "${local.linkedservice_generic_mssql_prefix}${each.value.short_name}"
  fileserver_linkedservice_name  = "${local.linkedservice_generic_file_prefix}${each.value.short_name}"
  name_suffix                    = random_id.rg_deployment_unique.id
  depends_on = [
    azurerm_data_factory_linked_custom_service.generic_kv,
    azurerm_data_factory_linked_custom_service.data_lake,
    azurerm_data_factory_linked_custom_service.blob,
    azurerm_data_factory_linked_custom_service.mssqldatabase,
    azurerm_data_factory_linked_custom_service.database,
    azurerm_data_factory_linked_custom_service.file
  ]
}

