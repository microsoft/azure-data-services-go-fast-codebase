locals {
  data_factory_name            = (var.data_factory_name != "" ? var.data_factory_name : module.naming.data_factory.name_unique)
  key_vault_name               = (var.key_vault_name != "" ? var.key_vault_name : module.naming.key_vault.name_unique)
  app_insights_name            = (var.app_insights_name != "" ? var.app_insights_name : module.naming.application_insights.name_unique)
  app_service_plan_name        = (var.app_service_plan_name != "" ? var.app_service_plan_name : module.naming.app_service_plan.name_unique)
  sql_server_name              = (var.sql_server_name != "" ? var.sql_server_name : module.naming.sql_server.name_unique)
  webapp_name                  = (var.webapp_name != "" ? var.webapp_name : module.naming.app_service.name_unique)
  webapp_url                   = "https://${local.webapp_name}.azurewebsites.net"
  functionapp_name             = (var.functionapp_name != "" ? var.functionapp_name : module.naming.function_app.name_unique)
  functionapp_url              = "https://${local.functionapp_name}.azurewebsites.net"
  aad_webapp_name              = (var.aad_webapp_name != "" ? var.aad_webapp_name : "ADS GoFast Web Portal (${var.environment_tag})")
  aad_functionapp_name         = (var.aad_functionapp_name != "" ? var.aad_functionapp_name : "ADS GoFast Orchestration App (${var.environment_tag})")
  vnet_name                    = (var.vnet_name != "" ? var.vnet_name : module.naming.virtual_network.name)
  plink_subnet_name            = (var.plink_subnet_name != "" ? var.plink_subnet_name : "${module.naming.subnet.name}-plink")
  app_service_subnet_name      = (var.app_service_subnet_name != "" ? var.plink_subnet_name : "${module.naming.subnet.name}-appservice")
  vm_subnet_name               = (var.vm_subnet_name != "" ? var.vm_subnet_name : "${module.naming.subnet.name}-vm")
  logs_storage_account_name    = (var.logs_storage_account_name != "" ? var.logs_storage_account_name : "${module.naming.storage_account.name_unique}log")
  app_service_nsg_name         = (var.app_service_nsg_name != "" ? var.app_service_nsg_name : "${module.naming.network_security_group.name}-appservice")
  plink_nsg_name               = (var.plink_nsg_name != "" ? var.plink_nsg_name : "${module.naming.network_security_group.name_unique}-plink")
  bastion_nsg_name             = (var.bastion_nsg_name != "" ? var.bastion_nsg_name : "${module.naming.network_security_group.name_unique}-bastion")
  vm_nsg_name                  = (var.vm_nsg_name != "" ? var.vm_nsg_name : "${module.naming.network_security_group.name_unique}-vm")
  log_analytics_workspace_name = (var.log_analytics_workspace_name != "" ? var.log_analytics_workspace_name : module.naming.log_analytics_workspace.name_unique)
  metadata_database_name       = "MetadataDb"
  sample_database_name         = "Samples"
  staging_database_name        = "Staging"
  adls_storage_account_name    = (var.adls_storage_account_name != "" ? var.adls_storage_account_name : "${module.naming.data_lake_store.name_unique}adsl")
  blob_storage_account_name    = (var.blob_storage_account_name != "" ? var.blob_storage_account_name : "${module.naming.data_lake_store.name_unique}blob")
  bastion_name                 = (var.bastion_name != "" ? var.bastion_name : module.naming.bastion_host.name_unique)
  bastion_ip_name              = (var.bastion_ip_name != "" ? var.bastion_ip_name : module.naming.public_ip.name_unique)
  purview_name                 = (var.purview_name != "" ? var.purview_name : "${var.prefix}${var.environment_tag}pur${var.app_name}${element(split("-", module.naming.data_factory.name_unique),length(split("-", module.naming.data_factory.name_unique))-1)}")
  purview_account_plink        = (var.purview_name != "" ? var.purview_name : "${var.prefix}-${var.environment_tag}-pura-${lower(var.app_name)}-plink-${element(split("-", module.naming.data_factory.name_unique),length(split("-", module.naming.data_factory.name_unique))-1)}")
  purview_portal_plink        = (var.purview_name != "" ? var.purview_name : "${var.prefix}-${var.environment_tag}-purp-${lower(var.app_name)}-plink-${element(split("-", module.naming.data_factory.name_unique),length(split("-", module.naming.data_factory.name_unique))-1)}")
  purview_resource_group_name  = "managed-${module.naming.resource_group.name_unique}-purview"
  purview_ir_app_reg_name      = (var.purview_ir_app_reg_name != "" ? var.purview_ir_app_reg_name : "ADS GoFast Purview Integration Runtime (${var.environment_tag})")
  jumphost_vm_name             = module.naming.virtual_machine.name
  jumphost_nic_name            = "${module.naming.virtual_machine.name}-jumphost_nic"
  jumphost_password            = ((var.is_vnet_isolated && var.jumphost_password == null) ? "" : var.jumphost_password)
  synapse_data_lake_name       = (var.synapse_data_lake_name != "" ? var.synapse_data_lake_name : module.naming.data_lake_store.name_unique)
  synapse_workspace_name       = (var.synapse_workspace_name != "" ? var.synapse_workspace_name : "${var.prefix}${var.environment_tag}synw${var.app_name}${element(split("-", module.naming.data_factory.name_unique), length(split("-", module.naming.data_factory.name_unique)) - 1)}")
  synapse_dwpool_name          = (var.synapse_dwpool_name != "" ? var.synapse_dwpool_name : "${var.prefix}${var.environment_tag}syndp${var.app_name}")
  synapse_sppool_name          = (var.synapse_sppool_name != "" ? var.synapse_sppool_name : "${var.prefix}${var.environment_tag}synsp${var.app_name}")
  synapse_resource_group_name  = "managed-${module.naming.resource_group.name_unique}-synapse"
  synapse_sql_password         = ((var.deploy_synapse && var.synapse_sql_password == null) ? "" : var.synapse_sql_password)
  selfhostedsqlvm_name         = replace(module.naming.virtual_machine.name,"-vm-ads","-vm-sql")
  h2o-ai_name                  = replace(module.naming.virtual_machine.name,"-vm-ads","-vm-h2o")
  custom_vm_name               = replace(module.naming.virtual_machine.name,"-vm-ads","-vm-custom")
  ixup_egw_vm_name            = "ixup-egw"
  ixup_egw_password           = ((var.is_vnet_isolated && var.ixup_egw_password == null) ? "" : var.ixup_egw_password)


  tags = {
    Environment = var.environment_tag
    Owner       = var.owner_tag
    Author      = var.author_tag
    Application = var.app_name
    CreatedDate = timestamp()
  }

  integration_runtimes = [
    {
      name                 = "Azure-Integration-Runtime"
      short_name           = "Azure"
      is_azure             = true
      is_managed_vnet      = true
      valid_source_systems = ["*"]
      valid_pipeline_patterns = [
        {
          Folder       = "*"
          SourceFormat = "*"
          SourceType   = "*"
          TargetFormat = "*"
          TargetType   = "*"
          TaskTypeId   = "*"
        }
      ]
    },
    {
      name                 = "Onprem-Integration-Runtime"
      short_name           = "OnPrem"
      is_azure             = false
      is_managed_vnet      = false
      valid_source_systems = ["-14", "-15", "-9", "-3", "-4"]
      valid_pipeline_patterns = [
        {
          Folder       = "Azure-Storage-to-Azure-Storage"
          SourceFormat = "*"
          SourceType   = "*"
          TargetFormat = "*"
          TargetType   = "*"
          TaskTypeId   = "*"
        },
        {
          Folder       = "Execute-SQL-Statement"
          SourceFormat = "*"
          SourceType   = "*"
          TargetFormat = "*"
          TargetType   = "*"
          TaskTypeId   = "*"
        },
        {
          Folder       = "SQL-Database-to-Azure-Storage"
          SourceFormat = "*"
          SourceType   = "*"
          TargetFormat = "*"
          TargetType   = "*"
          TaskTypeId   = "*"
        },
        {
          Folder       = "SQL-Database-to-Azure-Storage-CDC"
          SourceFormat = "*"
          SourceType   = "*"
          TargetFormat = "*"
          TargetType   = "*"
          TaskTypeId   = "*"
        }

      ]
    }
  ]
}


