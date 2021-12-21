
if ($env:AdsOpts_CD_Services_KeyVault_Enable -eq "True")
{
    Write-Debug "Creating Key Vault"
    $result = az deployment group create -g $env:AdsOpts_CD_ResourceGroup_Name --template-file ./../arm/KeyVault.json --parameters location=$env:AdsOpts_CD_ResourceGroup_Location keyvault-name=$env:AdsOpts_CD_Services_KeyVault_Name tenant-id=$env:AdsOpts_CD_ResourceGroup_TenantId
}
else 
{
    Write-Warning "Skipped Creation of Key Vault"
}
