@description('Location for all resources.')
param location string = resourceGroup().location

@description('')
param asp_name string = 'test'

resource asp_name_resource 'Microsoft.Web/serverfarms@2018-02-01' = {
  name: asp_name
  location: location
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
    name: 'S1'
    tier: 'Standard'
    size: 'S1'
    family: 'S'
    capacity: 1
  }
}