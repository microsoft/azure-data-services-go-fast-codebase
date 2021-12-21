
#Invoke-Expression -Command  ".\Steps\CD_SetResourceGroupHash.ps1"

az config set extension.use_dynamic_install=yes_without_prompt

#az login --service-principal --username $env:secrets_AZURE_CREDENTIALS_clientId --password $env:secrets_AZURE_CREDENTIALS_clientSecret --tenant $env:secrets_AZURE_CREDENTIALS_tenantId


######################################################
### Continuous Deployment - Configure             ####
######################################################Write-Host ([Environment]::GetEnvironmentVariable("AdsOpts_CI_Enable"))
if (([Environment]::GetEnvironmentVariable("AdsOpts_CD_EnableConfigure")) -eq "True")
{
    Write-Host "Starting CD.."

    Invoke-Expression -Command  ".\Steps\CD_ConfigureKeyVault.ps1" 

    Invoke-Expression -Command  ".\Steps\CD_ConfigureAzureSQLServer.ps1"

    Invoke-Expression -Command  ".\Steps\CD_ConfigureWebApp.ps1"

    Invoke-Expression -Command  ".\Steps\CD_ConfigureFunctionApp.ps1"  

    Invoke-Expression -Command  ".\Steps\CD_ConfigureADF.ps1"  

    Invoke-Expression -Command  ".\Steps\CD_ConfigureVnet.ps1"

    Invoke-Expression -Command ".\Steps\CD_ConfigureAzureSqlServer_UpdateTaskTypeMappingJson.ps1"

    Invoke-Expression -Command ".\Steps\CD_ConfigureSampleData.ps1"

    Write-Host "Finishing CD.."
}

#Invoke-Expression -Command  ".\Cleanup_RemoveAll.ps1"