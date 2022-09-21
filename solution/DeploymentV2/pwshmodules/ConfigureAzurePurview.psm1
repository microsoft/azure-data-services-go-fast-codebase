
#-------------------------------------------------------------------------------------------------------------------------------------
# This script will configure Azure purview using purview APIs.
# When this script was written, purview had no Terraform, ARM or Azure Rest support. The only method of configuring
# Purview programatically was through purview APIs.
#
# Requirements:
#   - You must be authenticated using the Azure CLI
#   - Ensure you set your environment name below
#-------------------------------------------------------------------------------------------------------------------------------------
function ConfigureAzurePurview (
    [Parameter(Mandatory = $true)]
    [pscustomobject]$tout = $false
) {



  $environmentName = $env:TFenvironmentName
  $data_curators = $tout.azure_purview_data_curators
  $subscription_id =$tout.subscription_id
  $resource_group_name =$tout.resource_group_name
  $purview_name=$tout.purview_name
  $sqlserver_name=$tout.sqlserver_name
  $blobstorage_name=$tout.blobstorage_name
  $adlsstorage_name=$tout.adlsstorage_name
  $datafactory_name=$tout.datafactory_name
  $datafactory_principal_id = $tout.datafactory_principal_id
  $function_app_principal_id = $tout.function_app_principal_id
  $keyvault_name=$tout.keyvault_name
  $stagingdb_name=$tout.stagingdb_name
  $sampledb_name=$tout.sampledb_name
  $metadatadb_name=$tout.metadatadb_name
  $purview_sp_id=$tout.purview_sp_id
  $is_vnet_isolated=$tout.is_vnet_isolated

  #$  = Read-Host -Prompt "Enter a friendly name for your purview environment"
  
  #setting this to n for now - doesn't seem to cause issues with purview api but will review after further testing
  $isFirstRun = 'n'
  $lockboxName = $resource_group_name + " Default Purview Setup"

  # Ensure we are on the right sub
  #az account set --subscription $subscription_id
  #$tenantId = (az account show  | ConvertFrom-Json).tenantId
  $token = az account get-access-token --resource=https://purview.azure.net --query accessToken --output tsv 

  # Purview IR Name
  $integrationRuntimeName = "AzureIntegrationRuntime"
  $purviewEndpoint = "https://$purview_name.purview.azure.com"

  #Set-Location $deploymentFolderPath
  function CallPurviewApi (
      [string] $Method,
      [string] $Url,
      [string] $Body
  ) {

      $Headers = @{}
      $Headers.Add("Accept","*/*")
      $Headers.Add("User-Agent","Windows PowerShell 7.x Purview API PS")
      $Headers.Add("Authorization","Bearer $token")
      $Headers.Add("Content-Type","application/json")
      Write-Host "Invoking API : Sending Request ... " -ForegroundColor DarkCyan -NoNewLine
      Write-Host "  $Method   $Url"

      Try {
          $result = Invoke-RestMethod -Method $Method -Uri $Url -Headers $Headers -Body $Body
      } Catch {
          Write-Host $_ :-> $_.Exception
      }

      Write-Host "API Response Received :-> " -ForegroundColor Green
      Write-Output $result
  }

  #----------------------------------------------------------------------------------------------------------------
  # Create a friendly name for the purview account
  #----------------------------------------------------------------------------------------------------------------
  $body = '{
      "friendlyName": "'+$lockboxName+'"
    }'
  $uri = "$purviewEndpoint/?api-version=2019-11-01-preview"
  CallPurviewApi -Method "PATCH" -Url $uri -Body $body

  #----------------------------------------------------------------------------------------------------------------
  # Create the self hosted IR
  #----------------------------------------------------------------------------------------------------------------
  if($is_vnet_isolated)
  {
    $body = '{"name":"AzureIntegrationRuntime","properties":{"type":"SelfHosted"}}'
    $uri = "https://$purview_name.purview.azure.com/proxy/integrationRuntimes/AzureIntegrationRuntime?api-version=2020-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
  }
  #----------------------------------------------------------------------------------------------------------------
  # Create a shared credential source 
  #----------------------------------------------------------------------------------------------------------------
  # Link the keyvault so we can get secrets to access the data sources
  $body = '{
      "properties": {
        "baseUrl": "https://'+$keyvault_name+'.vault.azure.net/",
        "description": "Lockbox KeyVault"
      }
    }'
  $uri = "$purviewEndpoint/scan/azureKeyVaults/$keyvault_name"+"?api-version=2018-12-01-preview"
  CallPurviewApi -Method "PUT" -Url $uri  -Body $body

  # Configure the credentials for the source
  $body = '{"name":"SPCredentials","properties":{"type":"ServicePrincipal","typeProperties":{"tenant":"'+$tenantId+'","servicePrincipalId":"'+$purview_sp_id+'","servicePrincipalKey":{"type":"AzureKeyVaultSecret","secretName":"AzurePurviewIr","secretVersion":"","store":{"referenceName":"'+$keyvault_name+'","type":"LinkedServiceReference"}}}}}'
  $uri = "$purviewEndpoint/proxy/credentials/SPCredentials?api-version=2020-12-01-preview"
  CallPurviewApi -Method "PUT" -Url $uri  -Body $body

  #----------------------------------------------------------------------------------------------------------------
  # Create the azure sql database - data source
  #----------------------------------------------------------------------------------------------------------------
  $body = '{"kind":"AzureSqlDatabase","name":"'+$sqlserver_name+'","properties":{"serverEndpoint":"'+$sqlserver_name+'.database.windows.net","subscriptionId":"'+$subscription_id+'","resourceGroup":"'+$resource_group_name+'","location":"australiaeast","resourceName":"'+$sqlserver_name+'","resourceId":"/subscriptions/'+$subscription_id+'/resourceGroups/'+$resource_group_name+'/providers/Microsoft.Sql/servers/'+$sqlserver_name+'","collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"}}}'
  $uri = "$purviewEndpoint/scan/datasources/$sqlserver_name"+"?api-version=2018-12-01-preview"
  CallPurviewApi -Method "PUT" -Url $uri  -Body $body

  $irref = $is_vnet_isolated ? ''+$irref+'' : ''

  # Configure the scan for the source (x3 databases)
  #----------------------------------------------------------------------------------------------------------------
  if($isFirstRun -eq "n") {
    $body = '{"name":"SqlScanWeeklyMeta","kind":"AzureSqlDatabaseCredential","properties":{'+$irref+'"serverEndpoint":"'+$sqlserver_name+'.database.windows.net","databaseName":"'+$metadatadb_name+'","credential":{"referenceName":"SPCredentials","credentialType":"ServicePrincipal"},"collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"scanRulesetType":"System","scanRulesetName":"AzureSqlDatabase"}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklyMeta?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    # Schedule
    $body = '{"name":"default","properties":{"scanLevel":"Incremental","recurrence":{"startTime":"2021-12-30T18:37:00Z","interval":1,"frequency":"Week","timezone":"UTC","schedule":{"hours":[3],"minutes":[0],"weekDays":["Sunday"]}}}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklyMeta/triggers/default?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    # Filter
    $body = '{"properties":{"excludeUriPrefixes":[],"includeUriPrefixes":["mssql://'+$sqlserver_name+'.windows.net/MetadataDb/"]}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklyMeta/filters/custom?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body

    #----------------------------------------------------------------------------------------------------------------
    $body = '{"name":"SqlScanWeeklyStaging","kind":"AzureSqlDatabaseCredential","properties":{'+$irref+'"serverEndpoint":"'+$sqlserver_name+'.database.windows.net","databaseName":"'+$stagingdb_name+'","credential":{"referenceName":"SPCredentials","credentialType":"ServicePrincipal"},"collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"scanRulesetType":"System","scanRulesetName":"AzureSqlDatabase"}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklyStaging?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    # Schedule
    $body = '{"name":"default","properties":{"scanLevel":"Incremental","recurrence":{"startTime":"2021-12-30T18:37:00Z","interval":1,"frequency":"Week","timezone":"UTC","schedule":{"hours":[3],"minutes":[0],"weekDays":["Sunday"]}}}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklyStaging/triggers/default?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    # Filter
    $body = '{"properties":{"excludeUriPrefixes":[],"includeUriPrefixes":["mssql://'+$sqlserver_name+'.windows.net/Staging/"]}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklyStaging/filters/custom?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    #----------------------------------------------------------------------------------------------------------------
    $body = '{"name":"SqlScanWeeklySamples","kind":"AzureSqlDatabaseCredential","properties":{'+$irref+'"serverEndpoint":"'+$sqlserver_name+'.database.windows.net","databaseName":"'+$sampledb_name+'","credential":{"referenceName":"SPCredentials","credentialType":"ServicePrincipal"},"collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"scanRulesetType":"System","scanRulesetName":"AzureSqlDatabase"}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklySamples?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    # Schedule
    $body = '{"name":"default","properties":{"scanLevel":"Incremental","recurrence":{"startTime":"2021-12-30T18:37:00Z","interval":1,"frequency":"Week","timezone":"UTC","schedule":{"hours":[3],"minutes":[0],"weekDays":["Sunday"]}}}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklySamples/triggers/default?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
    # Filter
    $body = '{"properties":{"excludeUriPrefixes":[],"includeUriPrefixes":["mssql://'+$sqlserver_name+'.windows.net/Samples/"]}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$sqlserver_name+"/scans/SqlScanWeeklySamples/filters/custom?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
  }

  #----------------------------------------------------------------------------------------------------------------
  # Create the Azure Blob storage - data source
  #----------------------------------------------------------------------------------------------------------------
  $body = '{"kind":"AzureStorage","name":"'+$blobstorage_name+'","properties":{"endpoint":"https://'+$blobstorage_name+'.blob.core.windows.net/","subscriptionId":"'+$subscription_id+'","resourceGroup":"'+$resource_group_name+'","location":"australiaeast","resourceName":"'+$blobstorage_name+'","resourceId":"/subscriptions/'+$subscription_id+'/resourceGroups/'+$resource_group_name+'/providers/Microsoft.Storage/storageAccounts/'+$blobstorage_name+'","collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"dataUseGovernance":"Disabled"}}'
  $uri = "$purviewEndpoint/scan/datasources/"+$blobstorage_name+"?api-version=2018-12-01-preview"
  CallPurviewApi -Method "PUT" -Url $uri  -Body $body

  if($isFirstRun -eq "n") {
    # Configure the scan
    $body = '{"name":"BlobScanWeekly","kind":"AzureStorageCredential","properties":{'+$irref+'"credential":{"referenceName":"SPCredentials","credentialType":"ServicePrincipal"},"collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"scanRulesetType":"System","scanRulesetName":"AzureStorage"}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$blobstorage_name+"/scans/BlobScanWeekly?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body

    # Schedule
    $body = '{"name":"default","properties":{"scanLevel":"Incremental","recurrence":{"startTime":"2021-12-30T18:37:00Z","interval":1,"frequency":"Week","timezone":"UTC","schedule":{"hours":[3],"minutes":[0],"weekDays":["Sunday"]}}}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$blobstorage_name+"/scans/BlobScanWeekly/triggers/default?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body

    # Filter
    $body = '{"properties":{"excludeUriPrefixes":[],"includeUriPrefixes":["https://'+$blobstorage_name+'.blob.core.windows.net/"]}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$blobstorage_name+"/scans/BlobScanWeekly/filters/custom?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
  }
  #----------------------------------------------------------------------------------------------------------------
  # Create the Data Lake storage - data source
  #----------------------------------------------------------------------------------------------------------------
  $body = '{"kind":"AdlsGen2","name":"'+$adlsstorage_name+'","properties":{"endpoint":"https://'+$adlsstorage_name+'.dfs.core.windows.net/","subscriptionId":"'+$subscription_id+'","resourceGroup":"'+$resource_group_name+'","location":"australiaeast","resourceName":"'+$adlsstorage_name+'","resourceId":"/subscriptions/'+$subscription_id+'/resourceGroups/'+$resource_group_name+'/providers/Microsoft.Storage/storageAccounts/'+$adlsstorage_name+'","collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"dataUseGovernance":"Disabled"}}'
  $uri = "$purviewEndpoint/scan/datasources/"+$adlsstorage_name+"?api-version=2018-12-01-preview"
  CallPurviewApi -Method "PUT" -Url $uri  -Body $body
  if($isFirstRun -eq "n") {
    $uri = "$purviewEndpoint/scan/datasources/"+$adlsstorage_name+"/scans/AdlsScanWeekly?api-version=2018-12-01-preview"
    $body = '{"name":"AdlsScanWeekly","kind":"AdlsGen2Credential","properties":{'+$irref+'"credential":{"referenceName":"SPCredentials","credentialType":"ServicePrincipal"},"collection":{"type":"CollectionReference","referenceName":"'+$purview_name+'"},"scanRulesetType":"System","scanRulesetName":"AdlsGen2"}}'
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body

    # Schedule
    $body = '{"name":"default","properties":{"scanLevel":"Incremental","recurrence":{"startTime":"2021-12-30T18:37:00Z","interval":1,"frequency":"Week","timezone":"UTC","schedule":{"hours":[4],"minutes":[0],"weekDays":["Sunday"]}}}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$adlsstorage_name+"/scans/AdlsScanWeekly/triggers/default?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body

    # Filter
    $body = '{"properties":{"excludeUriPrefixes":[],"includeUriPrefixes":["https://'+$adlsstorage_name+'.dfs.core.windows.net/"]}}'
    $uri = "$purviewEndpoint/scan/datasources/"+$adlsstorage_name+"/scans/AdlsScanWeekly/filters/custom?api-version=2018-12-01-preview"
    CallPurviewApi -Method "PUT" -Url $uri  -Body $body
  }

  #----------------------------------------------------------------------------------------------------------------
  # Configure the datafactory link
  #----------------------------------------------------------------------------------------------------------------
  $uri ="/subscriptions/$subscription_id/resourceGroups/$resource_group_name/providers/Microsoft.DataFactory/factories/"+$datafactory_name+"?api-version=2018-06-01"
  $body = '{\"tags\":{\"catalogUri\":\"https://'+$purview_name+'.purview.azure.com/catalog\"}, \"properties\":{\"purviewConfiguration\":{\"purviewResourceId\":\"/subscriptions/'+$subscription_id+'/resourceGroups/'+$resource_group_name+'/providers/Microsoft.Purview/accounts/'+$purview_name+'\"}}}'

  az rest --url $uri --method patch --body $body --headers "Content-Type=application/json"

  #----------------------------------------------------------------------------------------------------------------
  # Grant ADF permissions to push Lineage into the root collection
  #----------------------------------------------------------------------------------------------------------------
  # Currently this needs to be done manually but we may automate this in the future.
  # https://docs.microsoft.com/en-us/azure/purview/tutorial-metadata-policy-collections-apis

  #$uri = "$purviewEndpoint/policystore/metadataroles?api-version=2021-07-01"
  #CallPurviewApi -Method "GET" -Url $uri  -Body $body

  $uri = "$purviewEndpoint/policystore/metadataPolicies?api-version=2021-07-01"
  $res = (CallPurviewApi -Method "GET" -Url $uri  -Body $body) 
  $policy = $res

  $res | Select-Object {$.values.properties.attributeRules.name -eq "purviewmetadatarole_builtin_data-curator:$purview_name"}
  $datac = ($res.values.properties.attributeRules | Where-Object {$_.name -eq "purviewmetadatarole_builtin_data-curator:$purview_name"})
  $arrayIndex = [array]::indexof($policy.values.properties.attributeRules, ($policy.values.properties.attributeRules | Where-Object {$_.name -eq "purviewmetadatarole_builtin_data-curator:$purview_name"}))

  #datafactory / function app
  $objectIds = @($datafactory_principal_id, $function_app_principal_id)
  #add each data curator from the dictionary to the list of objectIds to grant the permission
  foreach ($obj in $data_curators.values) 
  {
    $objectIds += $obj
  }
  foreach ($id in $objectIds) {
    #we dont want to add blank id's if any of the resources aren't deployed.
    if ($id -ne "")
    {
      $datac.dnfCondition[0][0].attributeValueIncludedIn += $id
    }
  }
  $policy.values.properties.attributeRules[$arrayIndex] = $datac 

  #we need the policy we wish to update - this changes each time we update it
  $policyId = $policy.values.id
  $uri = "$purviewEndpoint/policystore/metadataPolicies/$($policyId)?api-version=2021-07-01"
  $body = $policy.values | ConvertTo-Json -Depth 50
  CallPurviewApi -Method "PUT" -Url $uri  -Body $body
}