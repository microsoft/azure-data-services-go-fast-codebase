
Write-Debug " Creating Function App"
if ($env:AdsOpts_CD_Services_CoreFunctionApp_Enable -eq "True")
{   
    if ($env:AdsOpts_CD_Services_AppPlans_FunctionApp_ResourceGroup -eq $null)
    {
        $rg = $env:AdsOpts_CD_ResourceGroup_Name
    }
    else 
    {
        $rg = $env:AdsOpts_CD_Services_AppPlans_FunctionApp_ResourceGroup
    }

    $sn = $env:AdsOpts_CD_Services_AppPlans_FunctionApp_Name
    

    #$appserviceid = ((az appservice plan show --name $sn  --resource-group $rg) | ConvertFrom-Json).id

    $key = az storage account keys list -g $env:AdsOpts_CD_ResourceGroup_Name -n $env:AdsOpts_CD_Services_Storage_Logging_Name --query [0].value -o tsv

    $result = az deployment group create -g $rg --template-file ./../arm/FunctionApp.json --parameters azure-function-site-name=$env:AdsOpts_CD_Services_CoreFunctionApp_Name app-insights-name=$env:AdsOpts_CD_Services_AppInsights_Name storage-log-account-name=$env:AdsOpts_CD_Services_Storage_Logging_Name storage-log-account-key=$key appservice-name=$sn
}
else 
{
    Write-Warning "Skipped Creation of Function App"
}

