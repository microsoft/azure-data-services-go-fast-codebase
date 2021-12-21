Write-Debug " Creating Storage Account (ADLS) For Data Lake"
if($env:AdsOpts_CD_Services_Storage_ADLS_Enable -eq "True")
{
    #StorageAccount For Logging
    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/Storage_ADLS.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location storage-account-name=$env:AdsOpts_CD_Services_Storage_ADLS_Name
    Write-Debug " Creating Storage Account (ADLS) For Data Lake"
}
else 
{
    Write-Warning "Skipped Creation of Storage (ADLS) For Data Lake"
}

#Transient Storage Account
if($env:AdsOpts_CD_Services_Storage_ADLSTransient_Enable -eq "True")
{
    Write-Debug " Creating Transient Storage Account (ADLS)"
    
    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/Storage_ADLS.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location storage-account-name=$env:AdsOpts_CD_Services_Storage_ADLSTransient_Name storage-raw-container-name=transient
}
else 
{
    Write-Warning "Skipped Creation of Transient Storage (ADLS)"
}