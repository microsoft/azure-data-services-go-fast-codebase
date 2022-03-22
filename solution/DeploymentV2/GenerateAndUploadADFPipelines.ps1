$CurrDir = $PWD
Set-Location ../DataFactory/Patterns/
Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1
Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
Invoke-Expression  ./UploadTaskTypeMappings.ps1
#Below is temporary - we want to make a parent folder for the both of these directories in the future.
#Currently there are duplicate powershell scripts. Plan is to iterate through each subfolder (datafactory / synapse) with one script
Set-Location ../../Synapse/Patterns/
Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1
Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
Invoke-Expression  ./UploadTaskTypeMappings.ps1
Invoke-Expression  ./uploadNotebooks.ps1


Set-Location $CurrDir