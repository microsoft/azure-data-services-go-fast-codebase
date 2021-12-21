@description('Location for all resources.')
param location string = resourceGroup().location

@description('')
param adf_name string = 'test'

resource adf_name_resource 'Microsoft.DataFactory/factories@2018-06-01' = {
  name: adf_name
  location: location
  identity: {
    type: 'SystemAssigned'
  }
  properties: {}
}