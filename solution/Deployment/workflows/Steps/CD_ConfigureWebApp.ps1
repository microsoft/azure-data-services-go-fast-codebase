Write-Debug " Configuring Web App"

$SourceFile = $env:AdsOpts_CD_FolderPaths_PublishZip + "/webapplication/Publish.zip"
if($env:AdsOpts_CD_Services_WebSite_Enable -eq "True")
{

    #Update App Settings
    
    $appsettingsfile = $env:AdsOpts_CD_FolderPaths_PublishUnZip + "/webapplication/appsettings.json"
    $appSettings = Get-Content $appsettingsfile | ConvertFrom-Json    
    
    $appSettings.ApplicationOptions.UseMSI = $true
    $appSettings.ApplicationOptions.AdsGoFastTaskMetaDataDatabaseServer = "$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net"
    $appSettings.ApplicationOptions.AdsGoFastTaskMetaDataDatabaseName = $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name

    $AppInsightsWPId = (az monitor app-insights component show --app $env:AdsOpts_CD_Services_AppInsights_Name -g $env:AdsOpts_CD_ResourceGroup_Name | ConvertFrom-Json).appId
    $appSettings.ApplicationOptions.AppInsightsWorkspaceId =  $AppInsightsWPId

    $LogAnalyticsWorkspaceId =  (az monitor log-analytics workspace show --workspace-name $env:AdsOpts_CD_Services_LogAnalytics_Name -g $env:AdsOpts_CD_ResourceGroup_Name | ConvertFrom-Json -AsHashtable).customerId
    $appSettings.ApplicationOptions.LogAnalyticsWorkspaceId =  $LogAnalyticsWorkspaceId

    $appSettings.AzureAdAuth.Domain=$env:AdsOpts_CD_ResourceGroup_Domain
    $appSettings.AzureAdAuth.TenantId=$env:AdsOpts_CD_ResourceGroup_TenantId
    $appSettings.AzureAdAuth.ClientId= $env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_ClientId
    $appSettings | ConvertTo-Json  -Depth 10 | set-content $appsettingsfile

    #Repack WebApp
    $CurrentPath = Get-Location
    Set-Location "./../bin/publish"
    $Path = (Get-Location).Path + "/zipped/webapplication" 
    New-Item -ItemType Directory -Force -Path $Path
    $Path = $Path + "/Publish.zip"
    Compress-Archive -Path '.\unzipped\webapplication\*' -DestinationPath $Path -force
    #Move back to workflows 
    Set-Location $CurrentPath
    
    # Deploy Web App
    $result = az webapp deployment source config-zip --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_WebSite_Name --src $SourceFile

    #Enable App Insights
    #az resource create --resource-group $env:AdsOpts_CD_ResourceGroup_Name --resource-type "Microsoft.Insights/components" --name $env:AdsOpts_CD_Services_WebSite_Name --location $env:AdsOpts_CD_ResourceGroup_Location --properties '{\"Application_Type\":\"web\"}'

}
else 
{
    Write-Warning "Skipped Configuring Web App"
}