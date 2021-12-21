@description('Location for all resources.')
param location string = resourceGroup().location

@description('Azure SQL Server Name (Logical Server).')
param sql_server_name string = 'adsgofast-srv-${uniqueString(resourceGroup().id)}'

@description('The administrator username of the SQL logical server')
param sql_admin_login string = 'adsgofastadmin'

@description('The administrator password of the SQL logical server.')
@secure()
param sql_admin_password string
param sample_db_name string = 'AdventureWorksLT'
param ads_go_fast_db_name string = 'adsgofast'
param staging_db_name string = 'staging'

@description('Name of Azure Bastion resource')
param vnet_name string = 'adsgofast-vnet'

var data_subnet_name = 'Data'
var sample_database_name_var = '${sql_server_name}/${sample_db_name}'
var ads_go_fast_database_name_var = '${sql_server_name}/${ads_go_fast_db_name}'
var staging_database_name_var = '${sql_server_name}/${staging_db_name}'
var vnet_data_subnet_resource_id = resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_name, data_subnet_name)

resource sql_server_name_resource 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: sql_server_name
  location: location
  tags: {
    displayName: sql_server_name
  }
  properties: {
    administratorLogin: sql_admin_login
    administratorLoginPassword: sql_admin_password
    version: '12.0'
    publicNetworkAccess: 'Enabled'
  }
}

resource sql_server_name_data_subnet_name 'Microsoft.Sql/servers/virtualNetworkRules@2015-05-01-preview' = {
  parent: sql_server_name_resource
  name: '${data_subnet_name}'
  properties: {
    virtualNetworkSubnetId: vnet_data_subnet_resource_id
    ignoreMissingVnetServiceEndpoint: false
  }
}

resource sample_database_name 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  name: sample_database_name_var
  location: location
  tags: {
    displayName: sample_database_name_var
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 50
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 32212254720
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    storageAccountType: 'GRS'
    sampleName: 'AdventureWorksLT'
  }
  dependsOn: [
    sql_server_name_resource
  ]
}

resource ads_go_fast_database_name 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  name: ads_go_fast_database_name_var
  location: location
  tags: {
    displayName: ads_go_fast_database_name_var
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 50
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 32212254720
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    storageAccountType: 'GRS'
  }
  dependsOn: [
    sql_server_name_resource
  ]
}

resource staging_database_name 'Microsoft.Sql/servers/databases@2019-06-01-preview' = {
  name: staging_database_name_var
  location: location
  tags: {
    displayName: staging_database_name_var
  }
  sku: {
    name: 'Standard'
    tier: 'Standard'
    capacity: 100
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 32212254720
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    storageAccountType: 'GRS'
  }
  dependsOn: [
    sql_server_name_resource
  ]
}
