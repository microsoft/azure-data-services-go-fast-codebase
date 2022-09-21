locals {
  adls_state_deployment_agents_ros = var.deploy_state_storage_account ?  var.resource_owners : []
}

#note: Swapped from native tf due to https://github.com/hashicorp/terraform-provider-azurerm/issues/16335
resource "azapi_resource" "adls_state" {
  count     = var.deploy_state_storage_account ? 1 : 0
  type      = "Microsoft.Storage/storageAccounts@2022-05-01"
  name      = var.state_storage_account_name
  parent_id = "/subscriptions/${var.subscription_id}/resourceGroups/${var.resource_group_name}"
  location  = var.resource_location
  
  body = jsonencode({
    kind = "StorageV2"
    sku  = {
      name = "Standard_GRS"
    }    
    properties = {
      isHnsEnabled = true,
      minimumTlsVersion = "TLS1_2"
      publicNetworkAccess = (var.is_vnet_isolated == false || var.delay_private_access == true)  ? "Enabled" : "Disabled"
    networkAcls = {
      defaultAction = "Deny",
      bypass = "AzureServices,Metrics"
      ipRules = var.is_vnet_isolated ? [{value = var.ip_address, action = "Allow"}] : [] 
    }      
    }
  })
}

resource "azurerm_storage_container" "tstate" {
  count     = var.deploy_state_storage_account ? 1 : 0
  name                  = "tstate"
  storage_account_name  = var.state_storage_account_name
  container_access_type = "private"
}

resource "azurerm_role_assignment" "adls_state_deployment_agents" {
  for_each = {
    for ro in local.adls_state_deployment_agents_ros : ro => ro
  }    
  scope                = azapi_resource.adls_state[0].id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = each.value
  depends_on = [
    azapi_resource.adls_state
  ]
}

resource "azurerm_private_endpoint" "adls_state_storage_private_endpoint_with_dns" {
  count               = var.deploy_state_storage_account ? 1 : 0
  name                = "${var.state_storage_account_name}-blob-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id

  private_service_connection {
    name                           = "${var.state_storage_account_name}-blob-plink-conn"
    private_connection_resource_id = azapi_resource.adls_state[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupstorageblob"
    private_dns_zone_ids = [local.private_dns_zone_blob_id]
  }

  depends_on = [
    azapi_resource.adls_state
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "adls_dfs_state_storage_private_endpoint_with_dns" {
  count               = var.deploy_state_storage_account ? 1 : 0
  name                = "${var.state_storage_account_name}-dfs-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id

  private_service_connection {
    name                           = "${var.state_storage_account_name}-dfs-plink-conn"
    private_connection_resource_id = azapi_resource.adls_state[0].id
    is_manual_connection           = false
    subresource_names              = ["dfs"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroupstoragedfs"
    private_dns_zone_ids = [local.private_dns_zone_dfs_id]
  }

  depends_on = [
    azapi_resource.adls_state
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

