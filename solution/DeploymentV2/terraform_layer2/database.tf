

resource "random_password" "database" {
  length      = 32
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  numeric      = true
  upper       = true
}

# Database Server
resource "azurerm_mssql_server" "sqlserver" {
  count                         = var.deploy_sql_server ? 1 : 0
  name                          = local.sql_server_name
  resource_group_name           = var.resource_group_name
  location                      = var.resource_location
  version                       = "12.0"
  administrator_login           = var.sql_admin_username
  administrator_login_password  = random_password.database.result
  public_network_access_enabled = var.azure_sql_server_public_access && (var.is_vnet_isolated == false || var.delay_private_access)
  minimum_tls_version           = "1.2"

  azuread_administrator {
    login_username = "sqladmin"
    object_id      = var.azure_sql_aad_administrators["sql_aad_admin"]
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

resource "azurerm_mssql_database" "web_db" {
  count     = var.deploy_sql_server && var.deploy_metadata_database ? 1 : 0
  name      = local.metadata_database_name
  server_id = azurerm_mssql_server.sqlserver[0].id
  sku_name  = var.db_size
  tags      = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_mssql_database" "sample_db" {
  count       = var.deploy_sql_server ? 1 : 0
  name        = local.sample_database_name
  server_id   = azurerm_mssql_server.sqlserver[0].id
  sku_name    = var.db_size
  sample_name = "AdventureWorksLT"
  tags        = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_mssql_database" "staging_db" {
  count     = var.deploy_sql_server ? 1 : 0
  name      = local.staging_database_name
  server_id = azurerm_mssql_server.sqlserver[0].id
  sku_name  = var.db_size
  tags      = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}

resource "azurerm_private_endpoint" "db_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "${local.sql_server_name}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = local.plink_subnet_id

  private_service_connection {
    name                           = "${local.sql_server_name}-plink-conn"
    private_connection_resource_id = azurerm_mssql_server.sqlserver[0].id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  dynamic "private_dns_zone_group" {
    for_each = (var.private_endpoint_register_private_dns_zone_groups ? [true] : [])
    content {
      name                 = "privatednszonegroup"
      private_dns_zone_ids = [local.private_dns_zone_db_id]
    }
  }

  depends_on = [
    azurerm_mssql_server.sqlserver[0]
  ]

  tags = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


/* resource "null_resource" "metadatadb_admins" {
  for_each = (var.azure_sql_aad_administrators)  
  provisioner "local-exec" {
    working_dir = path.module
    command = "pwsh -file database.ps1 -user ${each.key} -sqlserver_name ${local.sql_server_name} -database ${local.metadata_database_name}"    
  }
  
} */
