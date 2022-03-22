#Next Add MSIs Permissions
#Function App MSI Access to App Role to allow chained function calls
write-host "Granting Function App MSI Access to App Role to allow chained function calls"
$authapp = az ad app show --id "api://$env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name" | ConvertFrom-Json
$callingappid = ((az functionapp identity show --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name) | ConvertFrom-Json).principalId
$authappid = $authapp.appId
$permissionid =  $authapp.oauth2Permissions.id

$authappobjectid =  (az ad sp show --id $authappid | ConvertFrom-Json).objectId

$body = '{"principalId": "@principalid","resourceId":"@resourceId","appRoleId": "@appRoleId"}' | ConvertFrom-Json
$body.resourceId = $authappobjectid
$body.appRoleId =  ($authapp.appRoles | Where-Object {$_.value -eq "FunctionAPICaller" }).id
$body.principalId = $callingappid
$body = ($body | ConvertTo-Json -compress | Out-String).Replace('"','\"')

$result = az rest --method post --uri "https://graph.microsoft.com/v1.0/servicePrincipals/$authappobjectid/appRoleAssignedTo" --headers '{\"Content-Type\":\"application/json\"}' --body $body
