@description('Location for all resources.')
param location string = resourceGroup().location

@description('The name of you Web Site.')
param azure_function_site_name string = 'FuncApp-${uniqueString(resourceGroup().id)}'

@description('The name of Azure Application Insights.')
param app_insights_name string = 'appinsights-adsgofast'

@description('The name of storage account used for logging')
param storage_log_account_name string = 'adsgofastlog'

@description('A key to the storage account')
param storage_log_account_key string = ''

@description('')
param appservice_name string = ''

resource azure_function_site_name_resource 'Microsoft.Web/sites@2020-06-01' = {
  name: azure_function_site_name
  kind: 'functionapp'
  location: location
  properties: {
    name: azure_function_site_name
    siteConfig: {
      appSettings: [
        {
          name: 'FUNCTIONS_WORKER_RUNTIME'
          value: 'dotnet'
        }
        {
          name: 'FUNCTIONS_EXTENSION_VERSION'
          value: '~3'
        }
        {
          name: 'AzureWebJobsStorage'
          value: 'DefaultEndpointsProtocol=https;AccountName=${storage_log_account_name};AccountKey=${storage_log_account_key}'
        }
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: reference(resourceId('microsoft.insights/components/', app_insights_name), '2015-05-01').InstrumentationKey
        }
      ]
    }
    serverFarmId: resourceId('Microsoft.Web/serverfarms', appservice_name)
    clientAffinityEnabled: false
  }
}