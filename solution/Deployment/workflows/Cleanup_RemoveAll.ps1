[Environment]::SetEnvironmentVariable("ENVIRONMENT_NAME", "development")
. .\Steps\PushEnvFileIntoVariables.ps1
ParseEnvFile("$env:ENVIRONMENT_NAME")
Invoke-Expression -Command  ".\Steps\CD_SetResourceGroupHash.ps1"

az group delete --name $env:AdsOpts_CD_ResourceGroup_Name 

#Delete App and SP for Web App Auth 
az ad app delete --id "api://$env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name"

#Delete App and SP for Function App Auth
az ad app delete --id "api://$env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name"

$resources = az resource list --resource-group $env:AdsOpts_CD_ResourceGroup_Name  | ConvertFrom-Json
foreach ($resource in $resources) {
  az resource delete --resource-group myResourceGroup --ids $resource.id --verbose
}