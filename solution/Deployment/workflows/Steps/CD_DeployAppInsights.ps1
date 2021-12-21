
if ($env:AdsOpts_CD_Services_AppInsights_Enable -eq "True")
{
    Write-Debug " Creating App Insights"
    $storageaccountkey = (az storage account keys list -g $env:AdsOpts_CD_ResourceGroup_Name -n $env:AdsOpts_CD_Services_Storage_Logging_Name | ConvertFrom-Json)[0].value

    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/ApplicationInsights.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location appinsights_name=$env:AdsOpts_CD_Services_AppInsights_Name 
}
else 
{
    Write-Warning "Skipped Creation of App Insights"
}
