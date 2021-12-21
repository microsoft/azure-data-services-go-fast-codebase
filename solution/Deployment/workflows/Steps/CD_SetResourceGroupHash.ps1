

function Get-UniqueString ([string]$id, $length=13)
{
    $hashArray = (new-object System.Security.Cryptography.SHA512Managed).ComputeHash($id.ToCharArray())
        -join ($hashArray[1..$length] | ForEach-Object { [char]($_ % 26 + [byte][char]'a') })
}

Write-Debug "Creating RG Hash"
$ResourceGroupHash = Get-UniqueString ($id=$env:AdsOpts_CD_ResourceGroup_Name+$env:AdsOpts_CD_ResourceGroup_TenantId) #Resource Group Name + TenantId to make hash more unique
Write-Debug $ResourceGroupHash

PersistEnvVariable -Name "AdsOpts_CD_ResourceGroup_Hash" -Value $ResourceGroupHash
Write-Debug "Created RG Hash"
Write-Debug "Setting Service Names"
SetServiceName -RootElement "AdsOpts_CD_Services_AzureSQLServer"
SetServiceName -RootElement "AdsOpts_CD_Services_CoreFunctionApp"
SetServiceName -RootElement "AdsOpts_CD_Services_WebSite" 
SetServiceName -RootElement "AdsOpts_CD_Services_AppInsights"
SetServiceName -RootElement "AdsOpts_CD_Services_Storage_Logging"
SetServiceName -RootElement "AdsOpts_CD_Services_Storage_ADLS"
SetServiceName -RootElement "AdsOpts_CD_Services_Storage_ADLSTransient" #Added for Transient Storage
SetServiceName -RootElement "AdsOpts_CD_Services_Storage_Blob"
SetServiceName -RootElement "AdsOpts_CD_Services_DataFactory"
SetServiceName -RootElement "AdsOpts_CD_Services_AppPlans_WebApp"
SetServiceName -RootElement "AdsOpts_CD_Services_AppPlans_FunctionApp"
SetServiceName -RootElement "AdsOpts_CD_Services_LogAnalytics"
SetServiceName -RootElement "AdsOpts_CD_Services_KeyVault"
SetServiceName -RootElement "AdsOpts_CD_ServicePrincipals_DeploymentSP"
SetServiceName -RootElement "AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP"
SetServiceName -RootElement "AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP"

SetServiceName -RootElement "AdsOpts_CD_Services_Vnet"      #Added for enabling vNet Integration
SetServiceName -RootElement "AdsOpts_CD_Services_Bastion"   #Added for enabling vNet Integration



