@description('Location for all resources.')
param location string = resourceGroup().location

@description('Name of Azure Bastion resource')
param vnet_name string = 'adsgofast-vnet'

@description('Bastion subnet IP prefix MUST be within vnet IP prefix address space')
param vnet_address_prefix string = '10.1.0.0/16'

@description('Bastion subnet IP prefix MUST be within vnet IP prefix address space')
param bastion_subnet_ip_prefix string = '10.1.1.0/27'

@description('Bastion subnet IP prefix MUST be within vnet IP prefix address space')
param data_subnet_ip_prefix string = '10.1.2.0/27'

@description('Name of Azure Bastion resource')
param bastion_host_name string = 'azure-bastion-ads-go-fast'

var bastion_subnet_name = 'AzureBastionSubnet'
var data_subnet_name = 'Data'
var public_ip_address_name_bastion_var = '${bastion_host_name}-pip'

resource public_ip_address_name_bastion 'Microsoft.Network/publicIpAddresses@2019-02-01' = {
  name: public_ip_address_name_bastion_var
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource vnet_name_resource 'Microsoft.Network/virtualNetworks@2019-02-01' = {
  name: vnet_name
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnet_address_prefix
      ]
    }
    subnets: [
      {
        name: bastion_subnet_name
        properties: {
          addressPrefix: bastion_subnet_ip_prefix
        }
      }
      {
        name: data_subnet_name
        properties: {
          addressPrefix: data_subnet_ip_prefix
        }
      }
    ]
  }
}

resource vnet_name_bastion_subnet_name 'Microsoft.Network/virtualNetworks/subnets@2019-02-01' = {
  parent: vnet_name_resource
  name: '${bastion_subnet_name}'
  location: location
  properties: {
    addressPrefix: bastion_subnet_ip_prefix
  }
  dependsOn: [
    vnet_name_data_subnet_name
  ]
}

resource vnet_name_data_subnet_name 'Microsoft.Network/virtualNetworks/subnets@2019-02-01' = {
  parent: vnet_name_resource
  name: '${data_subnet_name}'
  location: location
  properties: {
    addressPrefix: data_subnet_ip_prefix
    serviceEndpoints: [
      {
        service: 'Microsoft.Sql'
      }
    ]
  }
}

resource bastion_host_name_resource 'Microsoft.Network/bastionHosts@2019-04-01' = {
  name: bastion_host_name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet: {
            id: vnet_name_bastion_subnet_name.id
          }
          publicIPAddress: {
            id: public_ip_address_name_bastion.id
          }
        }
      }
    ]
  }
  dependsOn: [
    vnet_name_resource
  ]
}