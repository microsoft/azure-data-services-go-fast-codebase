@description('Location for all resources.')
param location string = resourceGroup().location

@description('')
param asp_name string = 'test'

resource asp_name_resource 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: asp_name
  location: location
  kind: 'functionapp'
  properties: {
    perSiteScaling: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
  sku: {
    name: 'Y1'
    tier: 'Dynamic'
    size: 'Y1'
    family: 'Y'
    capacity: 0
  }
}