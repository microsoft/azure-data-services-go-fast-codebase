resource "azurerm_databricks_workspace" "workspace" {
  count               = var.deploy_databricks ? 1:0
  name                = local.databricks_workspace_name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  sku                 = "premium"
  managed_resource_group_name = local.databricks_resource_group_name

  public_network_access_enabled = true
  network_security_group_rules_required = var.is_vnet_isolated ? "NoAzureDatabricksRules" : null
  
  dynamic "custom_parameters" {
    for_each = var.is_vnet_isolated ? [1] : []
    content {
        no_public_ip        = true
        public_subnet_name  = local.databricks_host_subnet_name
        private_subnet_name = local.databricks_container_subnet_name
        virtual_network_id  = local.vnet_id

        public_subnet_network_security_group_association_id  = local.databricks_host_nsg_association
        private_subnet_network_security_group_association_id = local.databricks_host_nsg_association
    }
  }
}


resource "azurerm_private_endpoint" "databricks_workspace_pe" {
  count               = var.deploy_adls && var.deploy_databricks && var.is_vnet_isolated ? 1 : 0
  name                = "${local.databricks_workspace_name}-workspace-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id
  
  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name = "privatednszonegroupworkspace"
      private_dns_zone_ids = [local.private_dns_zone_databricks_workspace_id]
    }
  }

  private_service_connection {
    name                           = "${local.databricks_workspace_name}-workspace-plink-conn"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.workspace[0].id
    subresource_names              = ["databricks_ui_api"]
  }
}

resource "azurerm_private_endpoint" "databricks_auth_pe" {
  count               = var.deploy_adls && var.deploy_databricks && var.is_vnet_isolated ? 1 : 0
  name                = "${local.databricks_workspace_name}-auth-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id
  
  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name = "privatednszonegroupworkspace"
      private_dns_zone_ids = [local.private_dns_zone_databricks_workspace_id]
    }
  }

  private_service_connection {
    name                           = "${local.databricks_workspace_name}-auth-plink-conn"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.workspace[0].id
    subresource_names              = ["browser_authentication"]
  }
}

resource "azurerm_role_assignment" "databricks_data_factory" {
  count                = var.deploy_databricks && var.deploy_data_factory && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_databricks_workspace.workspace[0].id
  role_definition_name = "Contributor"
  principal_id         = azurerm_data_factory.data_factory[0].identity[0].principal_id
}

resource "azurerm_role_assignment" "databricks_synapse" {
  count                = var.deploy_databricks && var.deploy_synapse && var.deploy_rbac_roles ? 1 : 0
  scope                = azurerm_databricks_workspace.workspace[0].id
  role_definition_name = "Contributor"
  principal_id         = azurerm_synapse_workspace.synapse[0].identity[0].principal_id
}

//may get issues if deployer is not contributor -> as they may need to otherwise manually auth against the workspace first to prevent deploy errors for db resources related to db api
resource "azurerm_role_assignment" "databricks_deployment_agents" {
  for_each = {
    for ro in var.resource_owners : 
    ro => ro
    if(var.deploy_databricks == true && var.deploy_rbac_roles == true) 
  }    
  scope                = azurerm_databricks_workspace.workspace[0].id
  role_definition_name = "Contributor"
  principal_id         = each.value
}


/* commented out until actively using
 resource "databricks_repo" "ads_repo" {
  count      = var.deploy_databricks ? 1 : 0
  provider  = databricks.created_workspace
  url       = "https://github.com/microsoft/azure-data-services-go-fast-codebase.git"
  path      = "/Repos/shared/azure-data-services-go-fast-codebase"
} 
*/

//required as sometimes workspace has not completely set up auth will fail for workspace access immediately after creation
resource "time_sleep" "databricks_post_deployment" {
  count           = var.deploy_databricks ? 1 : 0
  depends_on      = [
  azurerm_databricks_workspace.workspace,
  azurerm_private_endpoint.databricks_auth_pe,
  azurerm_private_endpoint.databricks_workspace_pe 
]
  create_duration = "60s"
}


#ToAdd (maybe) -> Databricks notebooks upload auto via databricks  notebook resource
