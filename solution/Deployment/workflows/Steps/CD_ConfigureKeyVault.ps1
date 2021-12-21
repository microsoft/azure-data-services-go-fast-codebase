Write-Debug " Configuring Key Vault"

if($env:AdsOpts_CD_Services_KeyVault_Enable -eq "True")
{
    #Try to set user object id based on an interactive login
    $AADUserId = (az ad signed-in-user show | ConvertFrom-Json).objectId
    if ([string]::IsNullOrEmpty($AADUserId))
    {
        #If Interactive user failed then use SP method.
        $AADUserId = (az ad sp show --id (az account show | ConvertFrom-Json).user.name | ConvertFrom-Json).objectId                                                                             
    }


    $functionkey = (az functionapp keys list -g $env:AdsOpts_CD_ResourceGroup_Name -n $env:AdsOpts_CD_Services_CoreFunctionApp_Name | ConvertFrom-Json).functionKeys.default
    Write-Debug " Enabling Access to KeyVault and Adding Secrets"
    #Set KeyVault Policy to allow logged in user to add key
    $result = az keyvault set-policy --name $env:AdsOpts_CD_Services_KeyVault_Name --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey --object-id $AADUserId --resource-group $env:AdsOpts_CD_ResourceGroup_Name --secret-permissions backup delete get list purge recover restore set --storage-permissions backup delete deletesas get getsas list listsas purge recover regeneratekey restore set setsas update --subscription $env:AdsOpts_CD_ResourceGroup_Subscription
    #Set KeyVault Policy to allow MSI for ADF to Retrieve Key Vault Key
    #az keyvault set-policy --name $env:AdsOpts_CD_Services_KeyVault_Name --certificate-permissions backup create delete deleteissuers get getissuers import list listissuers managecontacts manageissuers purge recover restore setissuers update --key-permissions backup create decrypt delete encrypt get import list purge recover restore sign unwrapKey update verify wrapKey --object-id $AADUserId --resource-group $env:AdsOpts_CD_ResourceGroup_Name --secret-permissions backup delete get list purge recover restore set --storage-permissions backup delete deletesas get getsas list listsas purge recover regeneratekey restore set setsas update --subscription $env:AdsOpts_CD_ResourceGroup_Subscription

    #Save Function Key to KeyVault
    $result = az keyvault secret set --name "AdsGfCoreFunctionAppKey" --vault-name $env:AdsOpts_CD_Services_KeyVault_Name --disabled false --subscription  $env:AdsOpts_CD_ResourceGroup_Subscription --value $functionkey --output none

}
else 
{
    Write-Warning "Skipped Configuring Key Vault"
}
