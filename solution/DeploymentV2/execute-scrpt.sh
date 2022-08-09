# ------------------------------------------------------------------------------------------------------------
# You must be logged into the Azure CLI to run this script
# ------------------------------------------------------------------------------------------------------------
# arg0 is the URl for Ixup Applicaiton
# ixup-egw is the name for Encryption gateway VM
# resource group Name is set in Local Vars eg sandbox

resourcegroup="SandboxSetup"
arg0="https://test.ixup.com"
az vm run-command invoke  --command-id RunPowerShellScript --name ixup-egw --resource-group "$resourcegroup" \
    --scripts @InstallEncryptiongateway.ps1 --parameters "arg0=$arg0"

