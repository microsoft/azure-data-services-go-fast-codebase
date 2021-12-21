
if ($env:AdsOpts_CD_Services_DataFactory_Enable -eq "True")
{
    Write-Debug " Creating Log Analyticss"
    $results = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/LogAnalytics.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location workspaces_adsgofastloganalytics_name=$env:AdsOpts_CD_Services_LogAnalytics_Name 
}
else 
{
    Write-Warning "Skipped Creation of  Log Analytics"
}
