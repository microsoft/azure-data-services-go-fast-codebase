#Description - Run this script per user who require the Web App UI access.

#Note: --id parameter is principal name of the user for which to get information. 
$cu = az ad user show --id 'xxxxx@xxxxx.com' | ConvertFrom-Json 

#Script from CD_2a_ file
#Web App
$authapp = az ad app show --id "api://$env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name" | ConvertFrom-Json
$callinguser = $cu.objectId
$authappid = $authapp.appId
$permissionid =  $authapp.oauth2Permissions.id

$authappobjectid =  (az ad sp show --id $authapp.appId | ConvertFrom-Json).objectId

$body = '{"principalId": "@principalid","resourceId":"@resourceId","appRoleId": "@appRoleId"}' | ConvertFrom-Json
$body.resourceId = $authappobjectid
$body.appRoleId =  ($authapp.appRoles | Where-Object {$_.value -eq "Administrator" }).id
$body.principalId = $callinguser
$body = ($body | ConvertTo-Json -compress | Out-String).Replace('"','\"')

$result = az rest --method post --uri "https://graph.microsoft.com/v1.0/servicePrincipals/$authappobjectid/appRoleAssignedTo" --headers '{\"Content-Type\":\"application/json\"}' --body $body
