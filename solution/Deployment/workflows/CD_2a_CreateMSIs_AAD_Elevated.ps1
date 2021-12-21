az config set extension.use_dynamic_install=yes_without_prompt
#Create MSIs
if($env:AdsOpts_CD_Services_CoreFunctionApp_Enable -eq "True")
{
    $id = $null
    $id = ((az functionapp identity show --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name) | ConvertFrom-Json).principalId
    if ($null -eq $id) {
        Write-Host "Creating MSI for FunctionApp"
        $id = ((az functionapp identity assign --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_CoreFunctionApp_Name) | ConvertFrom-Json).principalId
    }
}
else 
{

    Write-Host "AdsOpts_CD_Services_CoreFunctionApp skipped as flag in environment file is set to false" -ForegroundColor Yellow
}

if($env:AdsOpts_CD_Services_WebSite_Enable -eq "True")
{
    $id = $null
    $id = ((az webapp identity show --name $env:AdsOpts_CD_Services_WebSite_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name) | ConvertFrom-Json).principalId
    if ($id -eq $null) {
        Write-Host "Creating MSI for WebApp"
        $id = ((az webapp identity assign --resource-group $env:AdsOpts_CD_ResourceGroup_Name --name $env:AdsOpts_CD_Services_WebSite_Name) | ConvertFrom-Json).principalId
    }
}
else 
{

    Write-Host "AdsOpts_CD_Services_WebSite_Enable skipped as flag in environment file is set to false" -ForegroundColor Yellow
}


#Make sure we have the datafactory extension 
az extension add --name datafactory

#Get ADF MSI Id
$dfpid = ((az datafactory show --factory-name $env:AdsOpts_CD_Services_DataFactory_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name) | ConvertFrom-Json).identity.principalId
$dfoid = ((az ad sp show --id $dfpid) | ConvertFrom-Json).objectId
#Allow ADF to Read Key Vault
$result = az keyvault set-policy --name $env:AdsOpts_CD_Services_KeyVault_Name --certificate-permissions get list --key-permissions get list --object-id $dfoid --resource-group $env:AdsOpts_CD_ResourceGroup_Name --secret-permissions get list --storage-permissions get --subscription $env:AdsOpts_CD_ResourceGroup_Subscription





#Give MSIs Required AD Privileges
#Assign SQL Admin
$cu = az ad signed-in-user show | ConvertFrom-Json
$result = az sql server ad-admin create --display-name $cu.DisplayName --object-id $cu.ObjectId --resource-group $env:AdsOpts_CD_ResourceGroup_Name --server $env:AdsOpts_CD_Services_AzureSQLServer_Name --subscription $env:AdsOpts_CD_ResourceGroup_Subscription

#az login --service-principal --username $env:secrets_AZURE_CREDENTIALS_clientId --password $env:secrets_AZURE_CREDENTIALS_clientSecret --tenant $env:secrets_AZURE_CREDENTIALS_tenantId


$SqlInstalled = Get-InstalledModule SqlServer
if($null -eq $SqlInstalled)
{
    write-host "Installing SqlServer Module"
    Install-Module -Name SqlServer -Scope CurrentUser -Force
}

#Add Ip to SQL Firewall
write-host "Creating SQL Server Firewall Rules"
$myIp = (Invoke-WebRequest ifconfig.me/ip).Content
$result = az sql server firewall-rule create -g $env:AdsOpts_CD_ResourceGroup_Name -s $env:AdsOpts_CD_Services_AzureSQLServer_Name -n "MySetupIP" --start-ip-address $myIp --end-ip-address $myIp


#May Need to add a wait here to allow MSI creation to have propogated completely

#ADS GO FAST DB
#Deployment SP
$sqlcommand = "
        DROP USER IF EXISTS [$env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Name] 
        CREATE USER [$env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Name] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_owner ADD MEMBER [$env:AdsOpts_CD_ServicePrincipals_DeploymentSP_Name];
        GO"

$sqlcommand = "
        DROP USER IF EXISTS [$env:AdsOpts_CD_Services_CoreFunctionApp_Name] 
        CREATE USER [$env:AdsOpts_CD_Services_CoreFunctionApp_Name] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$env:AdsOpts_CD_Services_CoreFunctionApp_Name];
        ALTER ROLE db_datawriter ADD MEMBER [$env:AdsOpts_CD_Services_CoreFunctionApp_Name];
        ALTER ROLE db_ddladmin ADD MEMBER [$env:AdsOpts_CD_Services_CoreFunctionApp_Name];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$env:AdsOpts_CD_Services_CoreFunctionApp_Name];
        GO"

$sqlcommand = $sqlcommand + "
        DROP USER IF EXISTS [$env:AdsOpts_CD_Services_WebSite_Name] 
        CREATE USER [$env:AdsOpts_CD_Services_WebSite_Name] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$env:AdsOpts_CD_Services_WebSite_Name];
        ALTER ROLE db_datawriter ADD MEMBER [$env:AdsOpts_CD_Services_WebSite_Name];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$env:AdsOpts_CD_Services_WebSite_Name];
        GO
"

$sqlcommand = $sqlcommand + "
        DROP USER IF EXISTS [$env:AdsOpts_CD_Services_DataFactory_Name] 
        CREATE USER [$env:AdsOpts_CD_Services_DataFactory_Name] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        ALTER ROLE db_datawriter ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$env:AdsOpts_CD_Services_DataFactory_Name];
        GO
"

write-host "Granting MSI Privileges on ADS Go Fast DB"
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
Invoke-Sqlcmd -ServerInstance "$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken $token -query $sqlcommand

#SAMPLE DB
$sqlcommand = "
        DROP USER IF EXISTS [$env:AdsOpts_CD_Services_DataFactory_Name] 
        CREATE USER [$env:AdsOpts_CD_Services_DataFactory_Name] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        ALTER ROLE db_datawriter ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        ALTER ROLE db_ddladmin ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$env:AdsOpts_CD_Services_DataFactory_Name];
        GO
"

write-host "Granting MSI Privileges on SAMPLE DB"
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
Invoke-Sqlcmd -ServerInstance "$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_SampleDB_Name -AccessToken $token -query $sqlcommand


#STAGING DB
$sqlcommand = "
        DROP USER IF EXISTS [$env:AdsOpts_CD_Services_DataFactory_Name] 
        CREATE USER [$env:AdsOpts_CD_Services_DataFactory_Name] FROM EXTERNAL PROVIDER;
        ALTER ROLE db_datareader ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        ALTER ROLE db_datawriter ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        ALTER ROLE db_ddladmin ADD MEMBER [$env:AdsOpts_CD_Services_DataFactory_Name];
        GRANT EXECUTE ON SCHEMA::[dbo] TO [$env:AdsOpts_CD_Services_DataFactory_Name];
        GO
"

write-host "Granting MSI Privileges on STAGING DB"
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
Invoke-Sqlcmd -ServerInstance "$env:AdsOpts_CD_Services_AzureSQLServer_Name.database.windows.net,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_StagingDB_Name -AccessToken $token -query $sqlcommand


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


#Web App
write-host "Adding Admin Role To WebApp"
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


Invoke-Expression -Command  ".\Steps\CD_GrantRBAC.ps1"  
