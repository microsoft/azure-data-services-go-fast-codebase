@description('Location for all resources.')
param location string = resourceGroup().location
param workspaces_adsgofastloganalytics_name string = 'adsloganalytics'

@description('Pricing tier: PerGB2018 or legacy tiers (Free, Standalone, PerNode, Standard or Premium) which are not available to all customers.')
@allowed([
  'pergb2018'
  'Free'
  'Standalone'
  'PerNode'
  'Standard'
  'Premium'
])
param log_analytics_sku string = 'pergb2018'

@description('Number of days to retain data.')
param log_analytics_retentionInDays int = 30

@description('true to use resource or workspace permissions. false to require workspace permissions.')
param log_analytics_resourcePermissions bool = false

resource workspaces_adsgofastloganalytics_name_resource 'microsoft.operationalinsights/workspaces@2020-08-01' = {
  name: workspaces_adsgofastloganalytics_name
  location: location
  properties: {
    sku: {
      name: log_analytics_sku
    }
    retentionInDays: log_analytics_retentionInDays
    features: {
      searchVersion: 1
      legacy: 0
      enableLogAccessUsingOnlyResourcePermissions: log_analytics_resourcePermissions
    }
  }
}