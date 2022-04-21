#----------------------------------------------------------------------------------------------------------------
# You must be logged into the Azure CLI to run this script
#----------------------------------------------------------------------------------------------------------------
# This script will:
# - Deploy all infra resources using terra
# - Approve all private link requests
# - Build and deploy web app
# - Build and deploy function app
# - Build database app and deploy
# - Deploy samples into blob storage
# 
# This is intended for creating a once off deployment from your development machine. You should setup the
# GitHub actions for your long term prod/non-prod environments
#
# Intructions
# - Ensure that you have run the Prepare.ps1 script first. This will prepare your azure subscription for deployment
# - Ensure that you have run az login and az account set
# - Ensure you have Owner access to the resource group you are planning on deploying to
# - Run this script
# 
# You can run this script multiple times if needed.
#----------------------------------------------------------------------------------------------------------------

Import-Module .\pwshmodules\GetSelectionFromUser.psm1 -force
$environmentName = Get-SelectionFromUser -Options ('local','staging') -Prompt "Select deployment environment"
if ($environmentName -eq "Quit")
{
    Exit
}

[System.Environment]::SetEnvironmentVariable('TFenvironmentName',$environmentName)

$myIp = (Invoke-WebRequest ifconfig.me/ip).Content
$skipTerraformDeployment = $false
$deploymentFolderPath = (Get-Location).Path

#----------------------------------------------------------------------------------------------------------------
#   Deploy Infrastructure
#----------------------------------------------------------------------------------------------------------------
# DEBUGGING HINTS:
# - If you don't have an access policy for the KeyVault to set the secret values, run this
#           az keyvault set-policy -n {keyVaultName} --secret-permissions all --object-id <<object-id-for-your-user>>
# - If the firewall is blocking you, add your IP as firewall rule / exemption to the appropriate resource
# - If you havn't run prepare but want to run this script on its own, set the TF_VAR_jumphost_password and TF_VAR_domain env vars
#------------------------------------------------------------------------------------------------------------
Set-Location "./terraform"
$env:TF_VAR_ip_address = $myIp

if ($skipTerraformDeployment) {
    Write-Host "Skipping Terraform Deployment"
}
else {
    Write-Host "Starting Terraform Deployment"
    terragrunt init --terragrunt-config vars/$environmentName/terragrunt.hcl -reconfigure
    terragrunt apply -auto-approve --terragrunt-config vars/$environmentName/terragrunt.hcl
}

#------------------------------------------------------------------------------------------------------------
# Get all the outputs from terraform so we can use them in subsequent steps
#------------------------------------------------------------------------------------------------------------
Write-Host "Reading Terraform Outputs"
Import-Module .\..\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform

$outputs = terragrunt output -json --terragrunt-config ./vars/$environmentName/terragrunt.hcl | ConvertFrom-Json

$subscription_id =$outputs.subscription_id.value
$resource_group_name =$outputs.resource_group_name.value
$webapp_name =$outputs.webapp_name.value
$functionapp_name=$outputs.functionapp_name.value
$purview_name=$outputs.purview_name.value
$sqlserver_name=$outputs.sqlserver_name.value
$blobstorage_name=$outputs.blobstorage_name.value
$adlsstorage_name=$outputs.adlsstorage_name.value
$datafactory_name=$outputs.datafactory_name.value
$keyvault_name=$outputs.keyvault_name.value
$stagingdb_name=$outputs.stagingdb_name.value
$sampledb_name=$outputs.sampledb_name.value
$metadatadb_name=$outputs.metadatadb_name.value
$loganalyticsworkspace_id=$outputs.loganalyticsworkspace_id.value
$purview_sp_name=$outputs.purview_sp_name.value
$synapse_workspace_name=if([string]::IsNullOrEmpty($outputs.synapse_workspace_name.value)) {"Dummy"} else {$outputs.synapse_workspace_name.value}
$synapse_sql_pool_name=if([string]::IsNullOrEmpty($outputs.synapse_sql_pool_name.value)) {"Dummy"} else {$outputs.synapse_sql_pool_name.value}

$skipWebApp = if($tout.publish_web_app) {$false} else {$true}
$skipFunctionApp = if($tout.publish_function_app) {$false} else {$true}
$skipDatabase = if($tout.publish_database) {$false} else {$true}
$skipSampleFiles = if($tout.publish_sample_files){$false} else {$true}
$skipSif= if($tout.publish_sif){$false} else {$true}
$skipNetworking = if($tout.configure_networking){$false} else {$true}
$skipDataFactoryPipelines = if($tout.publish_datafactory_pipelines) {$false} else {$true}
$AddCurrentUserAsWebAppAdmin = if($tout.publish_web_app_addcurrentuserasadmin) {$true} else {$false}

if ($skipNetworking -or $tout.is_vnet_isolated -eq $false) {
    Write-Host "Skipping Private Link Connnections"    
}
else {
    #------------------------------------------------------------------------------------------------------------
    # Approve the Private Link Connections that get generated from the Managed Private Links in ADF
    #------------------------------------------------------------------------------------------------------------
    Write-Host "Approving Private Link Connections"
    $links = az network private-endpoint-connection list -g $resource_group_name -n $keyvault_name --type 'Microsoft.KeyVault/vaults' |  ConvertFrom-Json
    foreach($link in $links){
        if($link.properties.privateLinkServiceConnectionState.status -eq  "Pending"){
            $id_parts = $link.id.Split("/");
            Write-Host "- " + $id_parts[$id_parts.length-1]
            $result = az network private-endpoint-connection approve -g $resource_group_name -n $id_parts[$id_parts.length-1] --resource-name $keyvault_name --type Microsoft.Keyvault/vaults --description "Approved by Deploy.ps1"
        }
    }
    $links = az network private-endpoint-connection list -g $resource_group_name -n $sqlserver_name --type 'Microsoft.Sql/servers' |  ConvertFrom-Json
    foreach($link in $links){
        if($link.properties.privateLinkServiceConnectionState.status -eq  "Pending"){
            $id_parts = $link.id.Split("/");
            Write-Host "- " + $id_parts[$id_parts.length-1]
            $result = az network private-endpoint-connection approve -g $resource_group_name -n $id_parts[$id_parts.length-1] --resource-name $sqlserver_name --type Microsoft.Sql/servers --description "Approved by Deploy.ps1"
        }
    }
    $links = az network private-endpoint-connection list -g $resource_group_name -n $blobstorage_name --type 'Microsoft.Storage/storageAccounts' |  ConvertFrom-Json
    foreach($link in $links){
        if($link.properties.privateLinkServiceConnectionState.status -eq  "Pending"){
            $id_parts = $link.id.Split("/");
            Write-Host "- " + $id_parts[$id_parts.length-1]
            $result = az network private-endpoint-connection approve -g $resource_group_name -n $id_parts[$id_parts.length-1] --resource-name $blobstorage_name --type Microsoft.Storage/storageAccounts --description "Approved by Deploy.ps1"
        }
    }
    $links = az network private-endpoint-connection list -g $resource_group_name -n $adlsstorage_name --type 'Microsoft.Storage/storageAccounts' |  ConvertFrom-Json
    foreach($link in $links){
        if($link.properties.privateLinkServiceConnectionState.status -eq "Pending"){
            $id_parts = $link.id.Split("/");
            Write-Host "- " + $id_parts[$id_parts.length-1]
            $result = az network private-endpoint-connection approve -g $resource_group_name -n $id_parts[$id_parts.length-1] --resource-name $adlsstorage_name --type Microsoft.Storage/storageAccounts --description "Approved by Deploy.ps1"
        }
    }
}

#----------------------------------------------------------------------------------------------------------------
#   Building & Deploy Web App
#----------------------------------------------------------------------------------------------------------------
if ($skipWebApp) {
    Write-Host "Skipping Building & Deploying Web Application"    
}
else {
    Write-Host "Building & Deploying Web Application"
    #Move From Workflows to Function App
    Set-Location $deploymentFolderPath
    Set-Location "../WebApplication"
    dotnet restore
    dotnet publish --no-restore --configuration Release --output '..\DeploymentV2\bin\publish\unzipped\webapplication\'
    #Move back to workflows 
    Set-Location $deploymentFolderPath
    Set-Location "./bin/publish"
    $Path = (Get-Location).Path + "/zipped/webapplication" 
    New-Item -ItemType Directory -Force -Path $Path
    $Path = $Path + "/Publish.zip"
    Compress-Archive -Path '.\unzipped\webapplication\*' -DestinationPath $Path -force

    $result = az webapp deployment source config-zip --resource-group $resource_group_name --name $webapp_name --src $Path

    if ($AddCurrentUserAsWebAppAdmin) {                
        write-host "Adding Admin Role To WebApp"
        $authapp = (az ad app show --id $tout.aad_webreg_id) | ConvertFrom-Json
        $cu = az ad signed-in-user show | ConvertFrom-Json
        $callinguser = $cu.objectId
        $authappid = $authapp.appId
        $authappobjectid =  (az ad sp show --id $authapp.appId | ConvertFrom-Json).objectId

        $body = '{"principalId": "@principalid","resourceId":"@resourceId","appRoleId": "@appRoleId"}' | ConvertFrom-Json
        $body.resourceId = $authappobjectid
        $body.appRoleId =  ($authapp.appRoles | Where-Object {$_.value -eq "Administrator" }).id
        $body.principalId = $callinguser
        $body = ($body | ConvertTo-Json -compress | Out-String).Replace('"','\"')

        $result = az rest --method post --uri "https://graph.microsoft.com/v1.0/servicePrincipals/$authappobjectid/appRoleAssignedTo" --headers '{\"Content-Type\":\"application/json\"}' --body $body
    }
}

#----------------------------------------------------------------------------------------------------------------
#   Building & Deploy Function App
#----------------------------------------------------------------------------------------------------------------
if ($skipFunctionApp) {
    Write-Host "Skipping Building & Deploying Function Application"    
}
else {
    Write-Host "Building & Deploying Function Application"
    Set-Location $deploymentFolderPath
    Set-Location "..\FunctionApp\FunctionApp"
    dotnet restore
    dotnet publish --no-restore --configuration Release --output '..\..\DeploymentV2\bin\publish\unzipped\functionapp\'
    
    Set-Location $deploymentFolderPath
    Set-Location "./bin/publish"
    $Path = (Get-Location).Path + "/zipped/functionapp" 
    New-Item -ItemType Directory -Force -Path $Path
    $Path = $Path + "/Publish.zip"
    Compress-Archive -Path '.\unzipped\functionapp\*' -DestinationPath $Path -force
    
    $result = az functionapp deployment source config-zip --resource-group $resource_group_name --name $functionapp_name --src $Path
}

#----------------------------------------------------------------------------------------------------------------
#   Populate the Metadata Database
#----------------------------------------------------------------------------------------------------------------
if($skipDatabase) {
    Write-Host "Skipping Populating Metadata Database"    
}
else {
    
    Write-Host "Populating Metadata Database"

    Set-Location $deploymentFolderPath
    Set-Location "..\Database\ADSGoFastDbUp\AdsGoFastDbUp"
    dotnet restore
    dotnet publish --no-restore --configuration Release --output '..\..\..\DeploymentV2\bin\publish\unzipped\database\'
    
    #Add Ip to SQL Firewall
    $result = az sql server update -n $sqlserver_name -g $resource_group_name  --set publicNetworkAccess="Enabled"
    $result = az sql server firewall-rule create -g $resource_group_name -s $sqlserver_name -n "Deploy.ps1" --start-ip-address $myIp --end-ip-address $myIp
    #Allow Azure services and resources to access this server
    $result = az sql server firewall-rule create -g $resource_group_name -s $sqlserver_name -n "Azure" --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

    Set-Location $deploymentFolderPath
    Set-Location ".\bin\publish\unzipped\database\"

    # This has been updated to use the Azure CLI cred
    dotnet AdsGoFastDbUp.dll -a True -c "Data Source=tcp:${sqlserver_name}.database.windows.net;Initial Catalog=${metadatadb_name};" -v True --DataFactoryName $datafactory_name --ResourceGroupName $resource_group_name --KeyVaultName $keyvault_name --LogAnalyticsWorkspaceId $loganalyticsworkspace_id --SubscriptionId $subscription_id --SampleDatabaseName $sampledb_name --StagingDatabaseName $stagingdb_name --MetadataDatabaseName $metadatadb_name --BlobStorageName $blobstorage_name --AdlsStorageName $adlsstorage_name --WebAppName $webapp_name --FunctionAppName $functionapp_name --SqlServerName $sqlserver_name --SynapseWorkspaceName $synapse_workspace_name --SynapseDatabaseName $synapse_sql_pool_name --SynapseSQLPoolName $synapse_sql_pool_name --PurviewAccountName $purview_name

    # Fix the MSI registrations on the other databases. I'd like a better way of doing this in the future
    $SqlInstalled = Get-InstalledModule SqlServer
    if($null -eq $SqlInstalled)
    {
        write-host "Installing SqlServer Module"
        Install-Module -Name SqlServer -Scope CurrentUser -Force
    }

    $databases = @($stagingdb_name, $sampledb_name, $metadatadb_name)
    $aadUsers =  @($datafactory_name)

    if(!$purview_sp_id -eq 0)
    {
        $aadUsers +=  $purview_name
        $aadUsers +=  $purview_sp_name
    }

    $token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)
    foreach($database in $databases)
    {
        
        foreach($user in $aadUsers)        
        {
            if (![string]::IsNullOrEmpty($user))
            {
                $sqlcommand = "
                        DROP USER IF EXISTS [$user] 
                        CREATE USER [$user] FROM EXTERNAL PROVIDER;
                        ALTER ROLE db_datareader ADD MEMBER [$user];
                        ALTER ROLE db_datawriter ADD MEMBER [$user];
                        GRANT EXECUTE ON SCHEMA::[dbo] TO [$user];
                        GO
                "

                write-host "Granting MSI Privileges on $database DB to $user"
                Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $database -AccessToken $token -query $sqlcommand    
            }
        }
    }

    $ddlCommand = "ALTER ROLE db_ddladmin ADD MEMBER [$datafactory_name];"
    foreach($database in $databases)
    {
            write-host "Granting DDL Role on $database DB to $datafactory_name"
            Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $database -AccessToken $token -query $ddlCommand   
    }
}

#----------------------------------------------------------------------------------------------------------------
#   Configure Synapse Logins
#----------------------------------------------------------------------------------------------------------------
if([string]::IsNullOrEmpty($tout.synapse_workspace_name)) {
    Write-Host "Skipping Synapse SQL Users"    
}
else {
    Write-Host "Configuring Synapse SQL Users"

    #Add Ip to SQL Firewall
    #$result = az synapse workspace update -n $synapse_workspace_name -g $resource_group_name  --set publicNetworkAccess="Enabled"
    $result = az synapse workspace firewall-rule create --resource-group $resource_group_name --workspace-name $synapse_workspace_name --name "Deploy.ps1" --start-ip-address $myIp --end-ip-address $myIp

    if ($tout.is_vnet_isolated -eq $false)
    {
         $result = az synapse workspace firewall-rule create --resource-group $resource_group_name --workspace-name $synapse_workspace_name --name "AllowAllWindowsAzureIps" --start-ip-address "0.0.0.0" --end-ip-address "0.0.0.0"
    }
   
    if([string]::IsNullOrEmpty($synapse_sql_pool_name) )
    {
        write-host "Synapse pool is not deployed."
    }
    else 
    {
        # Fix the MSI registrations on the other databases. I'd like a better way of doing this in the future
        $SqlInstalled = Get-InstalledModule SqlServer
        if($null -eq $SqlInstalled)
        {
            write-host "Installing SqlServer Module"
            Install-Module -Name SqlServer -Scope CurrentUser -Force
        }



        $token=$(az account get-access-token --resource=https://sql.azuresynapse.net --query accessToken --output tsv)
        if ((![string]::IsNullOrEmpty($datafactory_name)) -and ($synapse_sql_pool_name -ne 'Dummy') -and (![string]::IsNullOrEmpty($synapse_sql_pool_name)))
        {
            # For a Spark user to read and write directly from Spark into or from a SQL pool, db_owner permission is required.
            Invoke-Sqlcmd -ServerInstance "$synapse_workspace_name.sql.azuresynapse.net,1433" -Database $synapse_sql_pool_name -AccessToken $token -query "IF NOT EXISTS (SELECT name
    FROM [sys].[database_principals]
    WHERE [type] = 'E' AND name = N'$datafactory_name') BEGIN CREATE USER [$datafactory_name] FROM EXTERNAL PROVIDER END"    
            Invoke-Sqlcmd -ServerInstance "$synapse_workspace_name.sql.azuresynapse.net,1433" -Database $synapse_sql_pool_name -AccessToken $token -query "EXEC sp_addrolemember 'db_owner', '$datafactory_name'"
        }
    }


}

#----------------------------------------------------------------------------------------------------------------
#   Deploy Data Factory Pipelines
#----------------------------------------------------------------------------------------------------------------
if ($skipDataFactoryPipelines) {
    Write-Host "Skipping DataFactory Pipelines"    
}
else {
    Set-Location $deploymentFolderPath    
    #Add Ip to SQL Firewall
    $result = az sql server update -n $sqlserver_name -g $resource_group_name  --set publicNetworkAccess="Enabled"
    $result = az sql server firewall-rule create -g $resource_group_name -s $sqlserver_name -n "Deploy.ps1" --start-ip-address $myIp --end-ip-address $myIp
    #Allow Azure services and resources to access this server
    $result = az sql server firewall-rule create -g $resource_group_name -s $sqlserver_name -n "Azure" --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
    
    $SqlInstalled = Get-InstalledModule SqlServer
    if($null -eq $SqlInstalled)
    {
        write-host "Installing SqlServer Module"
        Install-Module -Name SqlServer -Scope CurrentUser -Force
    }

    Invoke-Expression ./GenerateAndUploadADFPipelines.ps1
    Set-Location ./terraform

    
}


#----------------------------------------------------------------------------------------------------------------
#   Deploy Sample Files
#----------------------------------------------------------------------------------------------------------------

#----------------------------------------------------------------------------------------------------------------
if($skipSampleFiles) {
    Write-Host "Skipping Sample Files"    
}
else 
{
    Set-Location $deploymentFolderPath
    Set-Location "../SampleFiles/"
    Write-Host "Deploying Sample files"
    if ($tout.is_vnet_isolated -eq $true)
    {
        $result = az storage account update --resource-group $resource_group_name --name $adlsstorage_name --default-action Allow
    }

    $result = az storage container create --name "datalakelanding" --account-name $adlsstorage_name --auth-mode login
    $result = az storage container create --name "datalakeraw" --account-name $adlsstorage_name --auth-mode login
    $result = az storage container create --name "datalakeraw" --account-name $blobstorage_name --auth-mode login
    $result = az storage container create --name "transientin" --account-name $blobstorage_name --auth-mode login

    $result = az storage blob upload-batch --destination "datalakeraw" --account-name $adlsstorage_name --source ./ --destination-path samples/ --auth-mode login
    $result = az storage blob upload-batch --destination "datalakeraw" --account-name $blobstorage_name --source ./ --destination-path samples/ --auth-mode login

    #$files = Get-ChildItem -Name
    #foreach ($file in $files) {
    #    $result = az storage blob upload --file $file --container-name "datalakeraw" --name samples/$file --account-name $adlsstorage_name --auth-mode login
    #    $result = az storage blob upload --file $file --container-name "datalakeraw" --name samples/$file --account-name $blobstorage_name --auth-mode login
    #}

#----------------------------------------------------------------------------------------------------------------
#   Deploy SIF 
#----------------------------------------------------------------------------------------------------------------
if ($skipSif) {
    Write-Host "Skipping Deploying SIF"    
}
else {
    Set-Location $deploymentFolderPath
    Set-Location "../SampleFiles/SIF/"
    if ($tout.is_vnet_isolated -eq $true)
    {
        $result = az storage account update --resource-group $resource_group_name --name $adlsstorage_name --default-action Allow
    }
    $files = Get-ChildItem -Name
    foreach ($file in $files) {
        $result = az storage blob upload --file $file --container-name "datalakeraw" --name samples/$file --account-name $adlsstorage_name --auth-mode login
        $result = az storage blob upload --file $file --container-name "datalakeraw" --name samples/$file --account-name $blobstorage_name --auth-mode login
    }
   }

}

Set-Location $deploymentFolderPath
Write-Host "Finished"