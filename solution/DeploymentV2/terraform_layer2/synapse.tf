# --------------------------------------------------------------------------------------------------------------------
# Workspace
# --------------------------------------------------------------------------------------------------------------------




resource "azurerm_storage_data_lake_gen2_filesystem" "dlfs" {
  count              = var.deploy_adls && var.deploy_synapse ? 1 : 0
  name               = local.synapse_data_lake_name
  storage_account_id = azurerm_storage_account.adls[0].id
}

resource "azurerm_synapse_workspace" "synapse" {
  count                                = var.deploy_adls && var.deploy_synapse ? 1 : 0
  name                                 = local.synapse_workspace_name
  resource_group_name                  = var.resource_group_name
  location                             = var.resource_location
  storage_data_lake_gen2_filesystem_id = azurerm_storage_data_lake_gen2_filesystem.dlfs[0].id
  sql_administrator_login              = var.synapse_sql_login
  sql_administrator_login_password     = local.synapse_sql_password
  sql_identity_control_enabled         = true
  public_network_access_enabled        = ((var.is_vnet_isolated == false) || (var.delay_private_access == true))
  managed_virtual_network_enabled      = true
  managed_resource_group_name          = local.synapse_resource_group_name
  purview_id                           = var.deploy_purview ? azurerm_purview_account.purview[0].id : null

  #github_repo {
  #  account_name = var.synapse_git_account_name
  #  branch_name = var.synapse_git_repository_branch_name
  #  repository_name = var.synapse_git_repository_name
  #  root_folder = var.synapse_git_repository_root_folder
  # git_url = (Optional) Specifies the GitHub Enterprise host name. For example: https://github.mydomain.com.

  #}

  dynamic "github_repo" {
    for_each = ((var.synapse_git_toggle_integration && var.synapse_git_integration_type == "github") ? [true] : [])
    content {
      account_name    = var.synapse_git_repository_owner
      branch_name     = var.synapse_git_repository_branch_name
      repository_name = var.synapse_git_repository_name
      root_folder     = var.synapse_git_repository_root_folder
      git_url         = var.synapse_git_github_host_url
    }
  }

  dynamic "azure_devops_repo" {
    for_each = ((var.synapse_git_toggle_integration && var.synapse_git_integration_type == "devops") ? [true] : [])
    content {
      account_name    = var.synapse_git_repository_owner
      branch_name     = var.synapse_git_repository_branch_name
      repository_name = var.synapse_git_repository_name
      root_folder     = var.synapse_git_repository_root_folder
      project_name    = var.synapse_git_devops_project_name
      #if a custom tenant id isnt assigned, will use the terraform tenant_id
      tenant_id = var.synapse_git_devops_tenant_id != "" ? var.synapse_git_devops_tenant_id : var.tenant_id
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}




# --------------------------------------------------------------------------------------------------------------------
# SQL Dedicated Pool
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_sql_pool" "synapse_sql_pool" {
  count                = var.deploy_adls && var.deploy_synapse && var.deploy_synapse_sqlpool ? 1 : 0
  name                 = local.synapse_dwpool_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  sku_name             = var.synapse_sku
  create_mode          = "Default"
  tags                 = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# --------------------------------------------------------------------------------------------------------------------
# Spark Pool
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_spark_pool" "synapse_spark_pool" {
  count                = var.deploy_adls && var.deploy_synapse && var.deploy_synapse_sparkpool ? 1 : 0
  name                 = local.synapse_sppool_name
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  node_size_family     = "MemoryOptimized"
  node_size            = "Small"
  cache_size           = 100

  auto_scale {
    max_node_count = var.synapse_spark_max_node_count
    min_node_count = var.synapse_spark_min_node_count
  }

  auto_pause {
    delay_in_minutes = 15
  }
  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace Firewall Rules (Allow Public Access)
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_firewall_rule" "cicd" {
  count                = ((var.deploy_adls && var.deploy_synapse) && (var.is_vnet_isolated == false || var.delay_private_access)) ? 1 : 0
  name                 = "CICDAgent"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  start_ip_address     = var.ip_address
  end_ip_address       = var.ip_address
}

resource "azurerm_synapse_firewall_rule" "cicd_user" {
  count                = ((var.deploy_adls && var.deploy_synapse) && (var.is_vnet_isolated == false || var.delay_private_access)) ? 1 : 0
  name                 = "CICDUser"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  start_ip_address     = var.ip_address2
  end_ip_address       = var.ip_address2
}

# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace Firewall Rules (Allow Public Access)
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_firewall_rule" "public_access" {
  count                = var.deploy_adls && var.deploy_synapse && var.allow_public_access_to_synapse_studio && (var.is_vnet_isolated == false || var.delay_private_access) ? 1 : 0
  name                 = "AllowAll"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  start_ip_address     = "0.0.0.0"
  end_ip_address       = "255.255.255.255"
}

resource "time_sleep" "azurerm_synapse_firewall_rule_wait_30_seconds_cicd" {
  depends_on      = [azurerm_synapse_firewall_rule.cicd, azurerm_synapse_firewall_rule.cicd_user]
  create_duration = "30s"
}

# --------------------------------------------------------------------------------------------------------------------
# Synapse Integration Runtimes
# --------------------------------------------------------------------------------------------------------------------

resource "azurerm_synapse_integration_runtime_azure" "azure" {
    for_each = {
    for ir in local.synapse_integration_runtimes :
    ir.short_name => ir
    if ir.is_azure && var.deploy_synapse == true
  }
  name                 = each.value.name
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  location             = var.resource_location
  time_to_live_min        = 10
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]      
}


# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace Roles and Linked Services
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_synapse_role_assignment" "synapse_function_app_assignment" {
  count                = var.deploy_synapse && var.deploy_function_app ? 1 : 0
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  role_name            = "Synapse Administrator"
  principal_id         = azurerm_function_app.function_app[0].identity[0].principal_id
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]

}


resource "azurerm_synapse_role_assignment" "synapse_admin_assignments" {  
  for_each = var.deploy_synapse ? toset(var.synapse_administrators) : []
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  role_name            = "Synapse Administrator"
  principal_id         = each.key
  lifecycle {
    ignore_changes = all
  }
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]      
}

resource "azurerm_synapse_role_assignment" "synapse_contributor_assignments" {  
  for_each = var.deploy_synapse ? toset(var.synapse_contributors) : []
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  role_name            = "Synapse Contributor"
  principal_id         = each.key
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]      
}

resource "azurerm_synapse_role_assignment" "synapse_publisher_assignments" {  
  for_each = var.deploy_synapse ? toset(var.synapse_publishers) : []
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  role_name            = "Synapse Artifact Publisher"
  principal_id         = each.key
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]      
}




resource "azurerm_synapse_linked_service" "synapse_keyvault_linkedservice" {
  count                = var.deploy_synapse ? 1 : 0
  name                 = "SLS_AzureKeyVault"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  type                 = "AzureKeyVault"
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
  type_properties_json = <<JSON
{
  "baseUrl": "${azurerm_key_vault.app_vault.vault_uri}"
}
JSON

}

resource "azurerm_synapse_linked_service" "synapse_functionapp_linkedservice" {
  count                = var.deploy_synapse ? 1 : 0
  name                 = "SLS_AzureFunctionApp"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  type                 = "AzureFunction"
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
  type_properties_json = <<JSON
{
  "functionAppUrl": "${local.functionapp_url}",
  "functionKey": {
    "type": "AzureKeyVaultSecret",
    "store": {
      "referenceName": "${azurerm_synapse_linked_service.synapse_keyvault_linkedservice[count.index].name}",
      "type": "LinkedServiceReference"
    },
    "secretName": "AdsGfCoreFunctionAppKey"
  },
  "authentication": "Anonymous"
}
JSON
}

resource "azurerm_synapse_linked_service" "synapse_databricks_linkedservice" {
  for_each = {
    for ir in local.integration_runtimes :
    ir.short_name => ir
    if(var.deploy_synapse == true) && (ir.is_azure == true)
  }
  name            = "GLS_AzureDatabricks_${each.value.short_name}"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  type            = "AzureDatabricks"
  description     = "Generic Azure Databricks Connection"
  integration_runtime {
    name = each.value.name
  }
  type_properties_json = <<JSON
    {
      "domain": "@linkedService().DatabricksWorkspaceURL",
      "authentication": "MSI",
      "workspaceResourceId": "@linkedService().WorkspaceResourceID",
      "instancePoolId": "@linkedService().InstancePool",
      "newClusterNodeType": "@linkedService().ClusterNodeType",
      "newClusterNumOfWorker": "@linkedService().Workers",
      "newClusterSparkEnvVars": {
          "PYSPARK_PYTHON": "/databricks/python3/bin/python3"
      },
      "newClusterVersion": "@linkedService().ClusterVersion",
      "newClusterInitScripts": [],
      "clusterOption": "Fixed"
    }
JSON
  parameters = {
    DatabricksWorkspaceURL = var.deploy_databricks == true ? "https://${azurerm_databricks_workspace.workspace[0].workspace_url}" : ""
    WorkspaceResourceID = var.deploy_databricks == true ? azurerm_databricks_workspace.workspace[0].id : ""
    ClusterVersion = "12.2.x-scala2.12"
    Workers = 3
    ClusterNodeType = "Standard_DS3_v2"
    InstancePool = local.databricks_instance_pool_id
  }
  depends_on = [
    azurerm_synapse_firewall_rule.public_access,
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd,
    azurerm_synapse_integration_runtime_azure.azure
  ]
}

# --------------------------------------------------------------------------------------------------------------------
# User Access requirements
# --------------------------------------------------------------------------------------------------------------------
# https://docs.microsoft.com/en-us/azure/synapse-analytics/security/how-to-set-up-access-control
# - Access to synapse workspace:
#       - Synapse Contributo
#       - Synapse User
# - Synapse Compute Operator on the selected Apache Spark pool
# - Storage Data Contributor on the ADLS store for Synapse 
# - SQL Pool access

# --------------------------------------------------------------------------------------------------------------------
# Synapse Workspace - Managed Private Endpoints
# --------------------------------------------------------------------------------------------------------------------
# This managed private endpoint lets synapse read from the underlying data lake. The SQL endpoints are autocreated
# We depend on the cicd rule incase we are deploying publicly and cant access the private endpoints from GitHub
resource "azurerm_synapse_managed_private_endpoint" "adls" {
  count                = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                 = "AzureDataLake_PrivateEndpoint"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  target_resource_id   = azurerm_storage_account.adls[0].id
  subresource_name     = "dfs"
  // Because we deploy synapse in private (no public access) we only propose to create/destroy but never update
  lifecycle {
    ignore_changes = all
  }
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
}

resource "azurerm_synapse_managed_private_endpoint" "databricks" {
  count              = var.deploy_databricks && var.is_vnet_isolated && var.deploy_synapse ? 1 : 0
  name               = "Databricks_PrivateEndpoint"
  synapse_workspace_id = azurerm_synapse_workspace.synapse[0].id
  target_resource_id = azurerm_databricks_workspace.workspace[0].id
  subresource_name   = "databricks_ui_api"
  lifecycle {
    ignore_changes = all
  }
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
}

# --------------------------------------------------------------------------------------------------------------------
# Network Settings to allow inbound private link traffic to the Synapse studio
# https://docs.microsoft.com/en-us/azure/synapse-analytics/security/how-to-connect-to-workspace-from-restricted-network
locals {
  synapse_private_link_hub_id = (var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated && var.existing_synapse_private_link_hub_id ==  "" ? azurerm_synapse_private_link_hub.hub[0].id : var.existing_synapse_private_link_hub_id)
}

resource "azurerm_synapse_private_link_hub" "hub" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated && var.existing_synapse_private_link_hub_id ==  ""  ? 1 : 0
  name                = "${local.synapse_workspace_name}plink"
  resource_group_name = var.resource_group_name
  location            = var.resource_location
}


resource "azurerm_private_endpoint" "synapse_web" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-web-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id 

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-web-plink-conn"
    private_connection_resource_id = local.synapse_private_link_hub_id
    is_manual_connection           = false
    subresource_names              = ["Web"]
  }

  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name                 = "privatednszonegroupweb"
      private_dns_zone_ids = [local.private_dns_zone_synapse_gateway_id]
    }
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "synapse_dev" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-dev-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id 

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-dev-plink-conn"
    private_connection_resource_id = azurerm_synapse_workspace.synapse[0].id
    is_manual_connection           = false
    subresource_names              = ["Dev"]
  }

  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name                 = "privatednszonegroupdev"
      private_dns_zone_ids = [local.private_dns_zone_synapse_studio_id]
    }
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
}

resource "azurerm_private_endpoint" "synapse_sql" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-sql-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id 

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-sql-plink-conn"
    private_connection_resource_id = azurerm_synapse_workspace.synapse[0].id
    is_manual_connection           = false
    subresource_names              = ["Sql"]
  }

  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name                 = "privatednszonegroupsql"
      private_dns_zone_ids = [local.private_dns_zone_synapse_sql_id]
    }
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
}

resource "azurerm_private_endpoint" "synapse_sqlondemand" {
  count               = var.deploy_adls && var.deploy_synapse && var.is_vnet_isolated ? 1 : 0
  name                = "${local.synapse_workspace_name}-sqld-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id 

  private_service_connection {
    name                           = "${local.synapse_workspace_name}-sqld-plink-conn"
    private_connection_resource_id = azurerm_synapse_workspace.synapse[0].id
    is_manual_connection           = false
    subresource_names              = ["SqlOnDemand"]
  }

  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name                 = "privatednszonegroupsqld"
      private_dns_zone_ids = [local.private_dns_zone_synapse_sql_id]
    }
  }

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
}

# --------------------------------------------------------------------------------------------------------------------
# // IAM role assignment
# --------------------------------------------------------------------------------------------------------------------

resource "azurerm_role_assignment" "synapse_function_app" {
  count                = var.deploy_synapse && var.deploy_function_app && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_synapse_workspace.synapse[0].id
  role_definition_name = "Contributor"
  principal_id         = azurerm_function_app.function_app[0].identity[0].principal_id
  depends_on = [
    time_sleep.azurerm_synapse_firewall_rule_wait_30_seconds_cicd
  ]
}


# --------------------------------------------------------------------------------------------------------------------
# // Diagnostic logs
# --------------------------------------------------------------------------------------------------------------------
resource "azurerm_monitor_diagnostic_setting" "synapse_diagnostic_logs" {
  count = var.deploy_adls && var.deploy_synapse ? 1 : 0
  name  = "diagnosticlogs"
  # ignore_changes is here given the bug  https://github.com/terraform-providers/terraform-provider-azurerm/issues/10388
  lifecycle {
    ignore_changes = [log, metric]
  }
  target_resource_id         = azurerm_synapse_workspace.synapse[0].id
  log_analytics_workspace_id = local.log_analytics_resource_id

  log {
    category = "SynapseRbacOperations"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "GatewayApiRequests"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "BuiltinSqlReqsEnded"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "IntegrationPipelineRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "IntegrationActivityRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }
  log {
    category = "IntegrationTriggerRuns"
    enabled  = true
    retention_policy {
      days    = 0
      enabled = true
    }
  }

  metric {
    category = "AllMetrics"
    enabled  = false
    retention_policy {
      days    = 0
      enabled = true
    }
  }


}


