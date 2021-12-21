@description('Location for all resources.')
param location string = ''

@description('')
param storage_account_name string = 'adsgfadls'

@description('datalakelanding')
param storage_landing_container_name string = 'datalakelanding'

@description('datalakeraw')
param storage_raw_container_name string = 'datalakeraw'

@description('')
param storage_account_sku string = 'Standard_GRS'

resource storage_account_name_resource 'Microsoft.Storage/storageAccounts@2019-04-01' = {
  location: location
  name: storage_account_name
  kind: 'StorageV2'
  sku: {
    name: storage_account_sku
  }
  properties: {
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
    }
    isHnsEnabled: true
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
  }
}

resource storage_account_name_default_storage_landing_container_name 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${storage_account_name}/default/${storage_landing_container_name}'
  dependsOn: [
    storage_account_name_resource
  ]
}

resource storage_account_name_default_storage_raw_container_name 'Microsoft.Storage/storageAccounts/blobServices/containers@2019-06-01' = {
  name: '${storage_account_name}/default/${storage_raw_container_name}'
  dependsOn: [
    storage_account_name_resource
  ]
}