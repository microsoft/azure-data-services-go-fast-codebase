@description('Location for all resources.')
param location string = ''

@description('kv')
param keyvault_name string = 'kv'

@description('kv')
param tenant_id string = 'kv'

resource keyvault_name_resource 'Microsoft.KeyVault/vaults@2018-02-14' = {
  name: keyvault_name
  location: location
  properties: {
    enabledForDeployment: true
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true
    tenantId: tenant_id
    accessPolicies: []
    sku: {
      name: 'standard'
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}