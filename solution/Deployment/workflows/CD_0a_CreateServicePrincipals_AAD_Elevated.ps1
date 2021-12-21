$error.clear()
#First Create the Resource Group 
Invoke-Expression -Command  ".\Steps\CD_DeployResourceGroup.ps1" 
Import-Module .\Functions\Helpers.psm1
########################################################################

###      SetUp Service Principals Required.. Need to run this part with elevated privileges

#########################################################################
if($env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Enable -eq "True")
{
    Write-Debug "Creating Deployment Service Principal"
    $subid =  ((az account show -s $env:AdsOpts_CD_ResourceGroup_Subscription) | ConvertFrom-Json ).id

    $spcheck = az ad sp list --filter "displayname eq '$env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Name'" | ConvertFrom-Json
    if ($null -eq $spcheck)
    {
        Write-Debug "Deployment Principal does not exist so creating now."
        $SP = az ad sp create-for-rbac --name $env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Name --role contributor --scopes /subscriptions/$subid/resourceGroups/$env:AdsOpts_CD_ResourceGroup_Name | ConvertFrom-Json  
    }
    else {
        Write-Debug "Deployment Prinicpal Already Exists So Just Adding Contributor Role on Resource Group"
        $SP = az role assignment create --assignee $spcheck[0].objectId --role "Contributor" --scope  /subscriptions/$subid/resourceGroups/$env:AdsOpts_CD_ResourceGroup_Name   | ConvertFrom-Json  
    }
}


$environmentfile = $env:AdsOpts_CD_FolderPaths_Environments + "/" + $env:ENVIRONMENT_NAME + ".json"
$envsettings = Get-Content $environmentfile | ConvertFrom-Json  

if($env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Enable -eq "True")
{
    Write-Debug "Creating WebAppAuthentication Service Principal"
    
    $roleid = [guid]::NewGuid()
    $roles = '[{\"allowedMemberTypes\":  [\"Application\"],\"description\":  \"Administrator\",\"displayName\":  \"Administrator\",\"id\":  \"@Id\",\"isEnabled\":  true,\"lang\":  null,\"origin\":  \"Users\\Groups\",\"value\":  \"Administrator\"}]'
    $roles = $roles.Replace("@Id",$roleid)
    
    $replyurls = "https://$env:AdsOpts_CD_Services_WebSite_Name.azurewebsites.net/signin-oidc"

    $subid =  ((az account show -s $env:AdsOpts_CD_ResourceGroup_Subscription) | ConvertFrom-Json  ).id
    $appid = ((az ad app create --display-name $env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name --homepage "api://$env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name"  --identifier-uris "api://$env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name" --app-roles $roles --reply-urls $replyurls) | ConvertFrom-Json   ).appId
    $appid = ((az ad app show --id "api://$env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name") | ConvertFrom-Json  ).appId
    $spid = ((az ad sp create --id $appid) | ConvertFrom-Json  ).ObjectId

}

if($env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Enable -eq "True")
{
    Write-Debug "Creating FunctionAppAuthentication Service Principal"
    
    $roleid = [guid]::NewGuid()
    $roles = '[{\"allowedMemberTypes\":  [\"Application\"],\"description\":  \"Used to applications to call the ADS Go Fast functions\",\"displayName\":  \"FunctionAPICaller\",\"id\":  \"@Id\",\"isEnabled\":  true,\"lang\":  null,\"origin\":  \"Application\",\"value\":  \"FunctionAPICaller\"}]'
    $roles = $roles.Replace("@Id",$roleid) 

    $subid =  ((az account show -s $env:AdsOpts_CD_ResourceGroup_Subscription) | ConvertFrom-Json  ).id
    $appid = ((az ad app create --display-name $env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name --homepage "api://$env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name"  --identifier-uris "api://$env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name" --app-roles $roles) | ConvertFrom-Json  ).appId
    $appid = ((az ad app show --id "api://$env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name") | ConvertFrom-Json  ).appId
    $spid = ((az ad sp create --id $appid) | ConvertFrom-Json  ).ObjectId
    #Will need to do below during service creation to add the Azure Function MSI to role

    #az role assignment create --assignee $appid  --role $roleid --scope "/subscriptions/{subscriptionId}/resourcegroups/{resourceGroupName}/providers/{providerName}/{resourceType}/{resourceSubType}/{resourceName}"

    #az rest --method patch --uri "https://graph.microsoft.com/beta/applications/<object-id>" --headers '{"Content-Type":"application/json"}' --body '{"api":{"preAuthorizedApplications":[{"appId":"a37c1158-xxxxx94f2b","permissionIds":["5479xxxxx522869e718f0"]}]}}'

}


#Update the Environment File
$appid = ((az ad app show --id "api://$env:AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_Name") | ConvertFrom-Json  ).appId
$envsettings.AdsOpts.CD.ServicePrincipals.FunctionAppAuthenticationSP.ClientId = $appid
[Environment]::SetEnvironmentVariable("AdsOpts_CD_ServicePrincipals_FunctionAppAuthenticationSP_ClientId", "$appid")
$appid = ((az ad app show --id "api://$env:AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_Name") | ConvertFrom-Json  ).appId
$envsettings.AdsOpts.CD.ServicePrincipals.WebAppAuthenticationSP.ClientId = $appid
[Environment]::SetEnvironmentVariable("AdsOpts_CD_ServicePrincipals_WebAppAuthenticationSP_ClientId", "$appid")
$envsettings | ConvertTo-Json  -Depth 10 | set-content $environmentfile


#Check Status of Errors 

Write-Host "Script Complete Please Check below for Errors:"
Write-Host $error