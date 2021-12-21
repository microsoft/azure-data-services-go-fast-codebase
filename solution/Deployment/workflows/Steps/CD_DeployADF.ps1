
if ($env:AdsOpts_CD_Services_DataFactory_Enable -eq "True")
{
    Write-Debug " Creating Data Factory"
    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/DataFactory.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location adf-name=$env:AdsOpts_CD_Services_DataFactory_Name 
}
else 
{
    Write-Warning "Skipped Creation of Data Factory"
}
