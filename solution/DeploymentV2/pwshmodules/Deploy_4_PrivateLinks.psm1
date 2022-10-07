
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


        #$links = (az network private-dns zone list --resource-group gfh5 | ConvertFrom-Json).name
        #foreach($l in $links) {az network private-dns link vnet create --name "adscore.$l" --registration-enabled false --resource-group gfuat --virtual-network "/subscriptions/035a1364-f00d-48e2-b582-4fe125905ee3/resourceGroups/adsgfcore/providers/Microsoft.Network/virtualNetworks/ads-gf-core-vnet" --zone-name $l }
    }
}