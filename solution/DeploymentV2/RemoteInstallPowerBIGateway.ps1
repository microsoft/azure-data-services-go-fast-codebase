$irKey1 = az datafactory integration-runtime list-auth-key --factory-name $env:AdsOpts_CD_Services_DataFactory_Name --name $env:AdsOpts_CD_Services_DataFactory_OnPremVnetIr_Name --resource-group $env:AdsOpts_CD_ResourceGroup_Name --query authKey1 --out tsv
Write-Debug " irKey1 retrieved."

$fileUris = @("https://jbtstgacct9283.blob.core.windows.net/scripts/Install-IIS.ps1")
$protectedSettings = @{
    "fileUris" = $fileUris
    "storageAccountName" = "jbtstgacct9283"
    "storageAccountKey" = "xnZDaK9Fr2hYRRaH9nqJiHb/3Q=="
    "commandToExecute" = "powershell -ExecutionPolicy Unrestricted -File Install-IIS.ps1"
}
Set-AzVMExtension `
    -ResourceGroupName "rg-azpsremote" `
    -Location "westus" `
    -VMName "server0" `
    -Name "InstalIIS" `
    -Publisher "Microsoft.Compute" `
    -ExtensionType "CustomScriptExtension" `
    -TypeHandlerVersion "1.10" `
    -ProtectedSettings $protectedSettings