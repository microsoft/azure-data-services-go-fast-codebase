

<#
 * Copyright (c) Microsoft Corporation.
 * Licensed under the MIT license.

* General Description *
This script is for deploying private links. It takes in one parameter: $tout, which is a mandatory pscustomobject.
It checks if the configure_networking property of $tout is set to true and is_vnet_isolated property is set to true. 
If that's the case, it proceeds to approve private link connections for different services like keyvault, sqlserver, databricks and synapse.
It uses the Azure CLI command az network private-endpoint-connection list to list all the private endpoint connections of the corresponding resource and resource type, converts the output to json and loops through the list to check if the status of the connection is 'Pending' and if so, it uses the az network private-endpoint-connection approve command to approve the connection.

#>

function DeployPrivateLinks (
    [Parameter(Mandatory = $true)]
    [pscustomobject]$tout = $false
) {
    $skipNetworking = if($tout.configure_networking){$false} else {$true}
    if ($skipNetworking -or $tout.is_vnet_isolated -eq $false) {
        Write-Host "Skipping Private Link Connnections"    
    }
    else {
        #------------------------------------------------------------------------------------------------------------
        # Approve the Private Link Connections that get generated from the Managed Private Links in ADF
        #------------------------------------------------------------------------------------------------------------
        Write-Host "Approving Private Link Connections"
        $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.keyvault_name --type 'Microsoft.KeyVault/vaults' --only-show-errors |  ConvertFrom-Json
        foreach ($link in $links) {
            if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                $id_parts = $link.id.Split("/");
                Write-Host "- " + $id_parts[$id_parts.length - 1]
                $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.keyvault_name --type Microsoft.Keyvault/vaults --description "Approved by Deploy.ps1" --only-show-errors
            }
        }
        $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.sqlserver_name --type 'Microsoft.Sql/servers' --only-show-errors |  ConvertFrom-Json
        foreach ($link in $links) {
            if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                $id_parts = $link.id.Split("/");
                Write-Host "- " + $id_parts[$id_parts.length - 1]
                $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.sqlserver_name --type Microsoft.Sql/servers --description "Approved by Deploy.ps1" --only-show-errors
            }
        }
        if ($tout.deploy_databricks) {
            $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.databricks_workspace_name --type 'Microsoft.Databricks/workspaces' --only-show-errors |  ConvertFrom-Json
            foreach ($link in $links) {
                if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                    $id_parts = $link.id.Split("/");
                    Write-Host "- " + $id_parts[$id_parts.length - 1]
                    $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.databricks_workspace_name --type Microsoft.Databricks/workspaces --description "Approved by Deploy.ps1" --only-show-errors
                }
            }
        }


        $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.synapse_workspace_name --type 'Microsoft.Synapse/workspaces' --only-show-errors |  ConvertFrom-Json
        foreach ($link in $links) {
            if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                $id_parts = $link.id.Split("/");
                Write-Host "- " + $id_parts[$id_parts.length - 1]
                $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.synapse_workspace_name --type Microsoft.Synapse/workspaces --description "Approved by Deploy.ps1" --only-show-errors
            }
        }

        $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.blobstorage_name --type 'Microsoft.Storage/storageAccounts' --only-show-errors |  ConvertFrom-Json
        foreach ($link in $links) {
            if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                $id_parts = $link.id.Split("/");
                Write-Host "- " + $id_parts[$id_parts.length - 1]
                $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.blobstorage_name --type Microsoft.Storage/storageAccounts --description "Approved by Deploy.ps1" --only-show-errors
            }
        }
        $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.adlsstorage_name --type 'Microsoft.Storage/storageAccounts' --only-show-errors |  ConvertFrom-Json
        foreach ($link in $links) {
            if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                $id_parts = $link.id.Split("/");
                Write-Host "- " + $id_parts[$id_parts.length - 1]
                $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.adlsstorage_name --type Microsoft.Storage/storageAccounts --description "Approved by Deploy.ps1" --only-show-errors
            }
        }
        if($tout.deploy_cmd_executor_vm) {
            $links = az network private-endpoint-connection list -g $tout.resource_group_name -n $tout.adls_vm_cmd_executor_name --type 'Microsoft.Storage/storageAccounts' --only-show-errors |  ConvertFrom-Json
            foreach ($link in $links) {
                if ($link.properties.privateLinkServiceConnectionState.status -eq "Pending") {
                    $id_parts = $link.id.Split("/");
                    Write-Host "- " + $id_parts[$id_parts.length - 1]
                    $result = az network private-endpoint-connection approve -g $tout.resource_group_name -n $id_parts[$id_parts.length - 1] --resource-name $tout.adls_vm_cmd_executor_name --type Microsoft.Storage/storageAccounts --description "Approved by Deploy.ps1" --only-show-errors
                }
            }
        }


        #$links = (az network private-dns zone list --resource-group gfh5 | ConvertFrom-Json).name
        #foreach($l in $links) {az network private-dns link vnet create --name "adscore.$l" --registration-enabled false --resource-group gfuat --virtual-network "/subscriptions/035a1364-f00d-48e2-b582-4fe125905ee3/resourceGroups/adsgfcore/providers/Microsoft.Network/virtualNetworks/ads-gf-core-vnet" --zone-name $l }
    }
}