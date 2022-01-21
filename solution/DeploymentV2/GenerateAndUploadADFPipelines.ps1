$CurrDir = $PWD
Set-Location ../DataFactory/Patterns/
Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1
Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
Set-Location $CurrDir