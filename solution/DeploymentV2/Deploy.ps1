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

$environmentName = "local" # currently supports (local, staging)
$myIp = (Invoke-WebRequest ifconfig.me/ip).Content
$skipTerraformDeployment = $false
$skipWebApps = $false
$skipDatabase = $false
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
Set-Location ".\terraform"
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
$subscription_id = terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl subscription_id
$resource_group_name = terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl resource_group_name
$webapp_name= terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl webapp_name
$functionapp_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl functionapp_name)
$sqlserver_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl sqlserver_name)
$blobstorage_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl blobstorage_name)
$adlsstorage_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl adlsstorage_name)
$datafactory_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl datafactory_name)
$keyvault_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl keyvault_name)
$stagingdb_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl stagingdb_name)
$sampledb_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl sampledb_name)
$metadatadb_name=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl metadatadb_name)
$loganalyticsworkspace_id=$(terragrunt output --raw --terragrunt-config ./vars/$environmentName/terragrunt.hcl loganalyticsworkspace_id)


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

#----------------------------------------------------------------------------------------------------------------
#   Building & Deploy Web App
#----------------------------------------------------------------------------------------------------------------
if ($skipWebApps) {
    Write-Host "Skipping Building & Deploying Web Application"    
}
else {
    Write-Host "Building & Deploying Web Application"
    #Move From Workflows to Function App
    Set-Location $deploymentFolderPath
    Set-Location "../WebApplication"
    dotnet restore
    dotnet publish --no-restore --configuration Release --output '..\Deployment\bin\publish\unzipped\webapplication\'
    #Move back to workflows 
    Set-Location $deploymentFolderPath
    Set-Location "./bin/publish"
    $Path = (Get-Location).Path + "/zipped/webapplication" 
    New-Item -ItemType Directory -Force -Path $Path
    $Path = $Path + "/Publish.zip"
    Compress-Archive -Path '.\unzipped\webapplication\*' -DestinationPath $Path -force

    $result = az webapp deployment source config-zip --resource-group $resource_group_name --name $webapp_name --src $Path
}

#----------------------------------------------------------------------------------------------------------------
#   Building & Deploy Function App
#----------------------------------------------------------------------------------------------------------------
if ($skipWebApps) {
    Write-Host "Skipping Building & Deploying Function Application"    
}
else {
    Write-Host "Building & Deploying Function Application"
    Set-Location $deploymentFolderPath
    Set-Location "..\FunctionApp"
    dotnet restore
    dotnet publish --no-restore --configuration Release --output '..\Deployment\bin\publish\unzipped\functionapp\'
    
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
    Set-Location "..\Database\AdsGoFastDbUp\AdsGoFastDbUp"
    dotnet restore
    dotnet publish --no-restore --configuration Release --output '..\..\..\Deployment\bin\publish\unzipped\database\'

    #Add Ip to SQL Firewall
    $result = az sql server update -n $sqlserver_name -g $resource_group_name  --set publicNetworkAccess="Enabled"
    $result = az sql server firewall-rule create -g $resource_group_name -s $sqlserver_name -n "Deploy.ps1" --start-ip-address $myIp --end-ip-address $myIp
    #Allow Azure services and resources to access this server
    $result = az sql server firewall-rule create -g $resource_group_name -s $sqlserver_name -n "Azure" --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0

    Set-Location $deploymentFolderPath
    Set-Location ".\bin\publish\unzipped\database\"

    # This has been updated to use the Azure CLI cred
    dotnet AdsGoFastDbUp.dll -a True -c "Data Source=tcp:${sqlserver_name}.database.windows.net;Initial Catalog=${metadatadb_name};" -v True --DataFactoryName $datafactory_name --ResourceGroupName $resource_group_name --KeyVaultName $keyvault_name --LogAnalyticsWorkspaceId $loganalyticsworkspace_id --SubscriptionId $subscription_id --SampleDatabaseName $sampledb_name --StagingDatabaseName $stagingdb_name --MetadataDatabaseName $metadatadb_name --BlobStorageName $blobstorage_name --AdlsStorageName $adlsstorage_name --WebAppName $webapp_name --FunctionAppName $functionapp_name --SqlServerName $sqlserver_name
}


#----------------------------------------------------------------------------------------------------------------
#   Update TaskTypeJson With Latest Versions
#----------------------------------------------------------------------------------------------------------------
# TODO: Move this into the DbUp tool
# Get Access Token for SQL --Note that the deployment principal or user running locally will need rights on the database
#------------------------------------------------------------------------------------------------------------
if($skipDatabase) {
    Write-Host "Skipping TaskTypeJson Update"    
}
else {
    Write-Host "Updating TaskTypeJson"    
    #Install Sql Server Module
    if (Get-Module -ListAvailable -Name SqlServer) {
        Write-Host "SqlServer Module exists"
    } 
    else {
        Write-Host "Module does not exist.. installing.."
        Install-Module -Name SqlServer -Force
    }
    Set-Location $deploymentFolderPath
    Set-Location "../TaskTypeJson/"  

    $token=$(az account get-access-token --resource=https://database.windows.net/ --query accessToken --output tsv)     
    $targetserver = $sqlserver_name + ".database.windows.net"
    
    Get-ChildItem "." -Filter *.json | 
    Foreach-Object {
        $lsName = $_.BaseName 
        $fileName = $_.FullName
        $jsonobject = ($_ | Get-Content).Replace("'", "''")
        $Name = $_.BaseName
        $sql = "Update TaskTypeMapping
        Set TaskMasterJsonSchema = new.TaskMasterJsonSchema
        from TaskTypeMapping ttm 
        inner join 
        (
            Select MappingName = N'$Name' , TaskMasterJsonSchema = N'$jsonobject'
        ) new on ttm.MappingName = new.MappingName"
        Invoke-Sqlcmd -ServerInstance "${targetserver},1433" -Database $metadatadb_name -AccessToken $token -Query $sql
    }

    $result = az sql server update -n $sqlserver_name -g $resource_group_name  --set publicNetworkAccess="Disabled"
}

#----------------------------------------------------------------------------------------------------------------
#   Deploy Sample Files
#----------------------------------------------------------------------------------------------------------------
Set-Location $deploymentFolderPath
Set-Location "../SampleFiles/"
Write-Host "Deploying Sample files"

$result = az storage account update --resource-group $resource_group_name --name $adlsstorage_name --default-action Allow
$result = az storage account update --resource-group $resource_group_name --name $blobstorage_name --default-action Allow


$result = az storage container create --name "datalakeraw" --account-name $adlsstorage_name --auth-mode login
$result = az storage container create --name "datalakeraw" --account-name $blobstorage_name --auth-mode login

$files = Get-ChildItem -Name
foreach ($file in $files) {
    $result = az storage blob upload --file $file --container-name "datalakeraw" --name samples/$file --account-name $adlsstorage_name --auth-mode login
    $result = az storage blob upload --file $file --container-name "datalakeraw" --name samples/$file --account-name $blobstorage_name --auth-mode login
}

$result = az storage account update --resource-group $resource_group_name --name $adlsstorage_name --default-action Deny
$result = az storage account update --resource-group $resource_group_name --name $blobstorage_name --default-action Deny

Set-Location $deploymentFolderPath
Write-Host "Finished"