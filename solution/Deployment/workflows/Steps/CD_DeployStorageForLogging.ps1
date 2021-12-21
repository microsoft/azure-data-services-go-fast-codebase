Write-Debug " Creating Storage Account For Logging"
Write-Debug $env:AdsOpts_CD_Services_Storage_Logging_Name
if($env:AdsOpts_CD_Services_Storage_Logging_Enable -eq "True")
{
    #StorageAccount For Logging
    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/Storage_Logging.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location storage-log-account-name=$env:AdsOpts_CD_Services_Storage_Logging_Name
    Write-Debug " Creating Storage Account For Logging"
}
else 
{
    Write-Warning "Skipped Creation of Storage Account For Logging"
}