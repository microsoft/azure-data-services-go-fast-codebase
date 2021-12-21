@description('Location for all resources.')
param location string = resourceGroup().location

@description('Resource Group.')
param resource_group_name string = ''

@description('The name of Web Application.')
param sites_AdsGoFastWebApp_name string = 'adsgofastWebApp'

@description('')
param appservice_name string = ''

resource sites_AdsGoFastWebApp_name_resource 'Microsoft.Web/sites@2018-11-01' = {
  name: sites_AdsGoFastWebApp_name
  location: location
  tags: {}
  properties: {
    name: sites_AdsGoFastWebApp_name
    siteConfig: {
      appSettings: [
        {
          name: 'XDT_MicrosoftApplicationInsights_Mode'
          value: 'default'
        }
        {
          name: 'ANCM_ADDITIONAL_ERROR_PAGE_LINK'
          value: 'https://${sites_AdsGoFastWebApp_name}.scm.azurewebsites.net/detectors?type=tools&name=eventviewer'
        }
      ]
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnetcore'
        }
      ]
      phpVersion: 'OFF'
      alwaysOn: true
    }
    serverFarmId: resourceId('Microsoft.Web/serverfarms', appservice_name)
    clientAffinityEnabled: true
  }
}