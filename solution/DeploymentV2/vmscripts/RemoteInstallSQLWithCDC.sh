#!/bin/bash
cd terraform
json=$(terraform output -json)
cd ..

selfhostedsqlvm_name=$(echo $json | jq '.selfhostedsqlvm_name.value' -r)
resource_group_name=$(echo $json | jq '.resource_group_name.value' -r)

az vm run-command create --name "Script1" --vm-name $selfhostedsqlvm_name --resource-group $resource_group_name --parameters test="test" --script @RemoteInstallSQLWithCDC_Script.ps1

az vm run-command show --name "Script1" --vm-name $selfhostedsqlvm_name --resource-group $resource_group_name --parameters test="test" 
