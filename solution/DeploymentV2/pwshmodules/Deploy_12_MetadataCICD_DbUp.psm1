
<#
 * Copyright (c) Microsoft Corporation.
 * Licensed under the MIT license.

* General Description *
This script appears to deploy an Azure SQL database and populate it with metadata. 
It first checks if the publish_metadata_database flag is true, and if so, proceeds to build and publish the database using the dotnet command. 
It then adds the IP addresses specified in the TF_VAR_ip_address and TF_VAR_ip_address2 environment variables to the SQL firewall, and enables public network access to the SQL server. 
It then allows Azure services and resources to access the server. 
Finally, it runs the AdsGoFastDbUp.dll command with various parameters to populate the metadata database. The script also has some error handling and debug logs.

#>

function DeployMetadataCICDDbUp (
    [Parameter(Mandatory = $false)]
    [bool]$publish_metadata_database = $false, 
    [Parameter(Mandatory = $true)]
    [pscustomobject]$tout = $false,
    [Parameter(Mandatory = $true)]
    [string]$deploymentFolderPath = "",
    [Parameter(Mandatory = $true)]
    [String]$PathToReturnTo = ""
)
{
    #----------------------------------------------------------------------------------------------------------------
    #   Populate the Metadata Database
    #----------------------------------------------------------------------------------------------------------------
    if ($publish_metadata_cicd_dbup -eq $true) {
        Write-Host "Metadata CICD DBUP Starting"

        Set-Location $deploymentFolderPath
        Set-Location "..\Database\ADSGoFastDbUp\MetaDataCICD"
        dotnet restore
        dotnet publish --no-restore --configuration Release --output '..\..\..\DeploymentV2\bin\publish\unzipped\MetaDataCICD\'
    
        #Add Ip to SQL Firewall
        $result = az sql server update -n $tout.sqlserver_name -g $tout.resource_group_name  --set publicNetworkAccess="Enabled" --only-show-errors

        $myIp = $env:TF_VAR_ip_address
        $myIp2 = $env:TF_VAR_ip_address2

        if ($myIp -ne $null) {
            $result = az sql server firewall-rule create -g $tout.resource_group_name -s $tout.sqlserver_name -n "CICDAgent" --start-ip-address $myIp --end-ip-address $myIp --only-show-errors
        }
        if ($myIp2 -ne $null) {        
            $result = az sql server firewall-rule create -g $tout.resource_group_name -s $tout.sqlserver_name -n "CICDUser" --start-ip-address $myIp2 --end-ip-address $myIp2 --only-show-errors
        }
        #Allow Azure services and resources to access this server
        $result = az sql server firewall-rule create -g $tout.resource_group_name -s $tout.sqlserver_name -n "Azure" --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0 --only-show-errors

        Set-Location $deploymentFolderPath
        Set-Location ".\bin\publish\unzipped\MetaDataCICD\"

        $lake_database_container_name = $tout.synapse_lakedatabase_container_name

        # This has been updated to use the Azure CLI cred
        dotnet MetaDataCICD.dll -a True -c "Data Source=tcp:$($tout.sqlserver_name).database.windows.net;Initial Catalog=$($tout.metadatadb_name);" -v True --DataFactoryName $tout.datafactory_name --ResourceGroupName $tout.resource_group_name --KeyVaultName $tout.keyvault_name --LogAnalyticsWorkspaceId $tout.loganalyticsworkspace_id --SubscriptionId $tout.subscription_id --SampleDatabaseName $tout.sampledb_name --StagingDatabaseName $tout.stagingdb_name --MetadataDatabaseName $tout.metadatadb_name --BlobStorageName $tout.blobstorage_name --AdlsStorageName $tout.adlsstorage_name --WebAppName $tout.webapp_name --FunctionAppName $tout.functionapp_name --SqlServerName $tout.sqlserver_name --SynapseWorkspaceName $tout.synapse_workspace_name --SynapseDatabaseName $tout.synapse_sql_pool_name --SynapseSQLPoolName $tout.synapse_sql_pool_name --SynapseSparkPoolName $tout.synapse_spark_pool_name --PurviewAccountName $tout.purview_name --SynapseLakeDatabaseContainerName $tout.synapse_lakedatabase_container_name --DatabricksWorkspaceURL $tout.databricks_workspace_url --DatabricksWorkspaceResourceID $tout.databricks_workspace_id --DefaultInstancePoolID $tout.databricks_instance_pool_id --CmdExecutorVMName $tout.cmd_executor_vm_name --CmdExecutorVMAdlsName $tout.adls_vm_cmd_executor_name
    
        <# # Fix the MSI registrations on the other databases. I'd like a better way of doing this in the future
        $SqlInstalled = false
        try { 
            $SqlInstalled = Get-InstalledModule SqlServer
        }
        catch { "SqlServer PowerShell module not installed." }
    
        if ($null -eq $SqlInstalled) {
            write-host "Installing SqlServer Module"
            Install-Module -Name SqlServer -Scope CurrentUser -Force
        } #>
            
        Set-Location $deploymentFolderPath

        if([string]::IsNullOrEmpty($PathToReturnTo) -ne $true)
        {
            Write-Debug "Returning to $PathToReturnTo"
            Set-Location $PathToReturnTo
        }
        else {
            Write-Debug "Path to return to is null"
        }
 
    }
    else {
            Write-Host "Metadata CICD DB Up disabled"   

    }
}