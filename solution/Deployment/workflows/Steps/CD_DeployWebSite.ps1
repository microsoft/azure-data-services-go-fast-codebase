
if ($env:AdsOpts_CD_Services_WebSite_Enable -eq "True")
{   
    if ($env:AdsOpts_CD_Services_AppPlans_WebApp_ResourceGroup -eq $null)
    {
        $rg = $env:AdsOpts_CD_ResourceGroup_Name
    }
    else 
    {
        $rg = $env:AdsOpts_CD_Services_AppPlans_WebApp_ResourceGroup
    }

    
    $sn = $env:AdsOpts_CD_Services_AppPlans_WebApp_Name
    
    Write-Debug " Deploying Wesite to $sn in resource group $rg" 
    $result = az deployment group create -g $rg --template-file ./../arm/WebApp.json --parameters resource_group_name=$rg sites_AdsGoFastWebApp_name=$env:AdsOpts_CD_Services_WebSite_Name appservice_name=$sn}
else 
{
    Write-Warning "Skipped Creation of Web Site"
}

