

resource "random_password" "database" {
  length      = 32
  min_numeric = 1
  min_upper   = 1
  min_lower   = 1
  min_special = 1
  special     = true
  lower       = true
  number      = true
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
  public_network_access_enabled = var.is_vnet_isolated == false || var.delay_private_access
  minimum_tls_version           = "1.2"

  azuread_administrator {
    login_username = "sqladmin"
    object_id      = data.azurerm_client_config.current.object_id
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

  depends_on = [
    azuread_service_principal.web_sp
  ]
}

resource "azurerm_mssql_database" "web_db" {
  count     = var.deploy_sql_server ? 1 : 0
  name      = local.metadata_database_name
  server_id = azurerm_mssql_server.sqlserver[0].id
  sku_name  = "S0"
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
  sku_name    = "S0"
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
  sku_name  = "S0"
  tags      = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}
resource "azurerm_mssql_database" "SIFDM" {
  count       = var.deploy_sql_server ? 1 : 0
  name        = local.sif_database_name
  server_id   = azurerm_mssql_server.sqlserver[0].id
  sku_name    = "S0"
  tags        = local.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}


resource "azurerm_private_endpoint" "db_private_endpoint_with_dns" {
  count               = var.is_vnet_isolated ? 1 : 0
  name                = "${var.prefix}-${var.environment_tag}-sql-${lower(var.app_name)}-plink"
  location            = var.resource_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.plink_subnet[0].id

  private_service_connection {
    name                           = "${var.prefix}-${var.environment_tag}-sql-${lower(var.app_name)}-plink-conn"
    private_connection_resource_id = azurerm_mssql_server.sqlserver[0].id
    is_manual_connection           = false
    subresource_names              = ["sqlServer"]
  }

  private_dns_zone_group {
    name                 = "privatednszonegroup"
    private_dns_zone_ids = [azurerm_private_dns_zone.private_dns_zone_db[0].id]
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
