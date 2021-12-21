@description('Location for all resources.')
param location string = ''

@description('The name of the Log Store account to create.')
param storage_log_account_name string = 'logstg'

resource storage_log_account_name_resource 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storage_log_account_name
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    accessTier: 'Hot'
  }
}

output stringSubcriptionId string = subscription().id
output stringLogStorageAccount string = storage_log_account_name