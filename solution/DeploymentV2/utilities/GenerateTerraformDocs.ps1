




$PathToReturnTo = (Get-Location).Path
$deploymentFolderPath = Convert-Path( (Get-Location).Path + '/../')

Set-Location $deploymentFolderPath 
Set-Location ./terraform_layer0
$content = terraform-docs markdown table .
$content | Set-Content tformdocs.md

Set-Location $deploymentFolderPath 
Set-Location ./terraform_layer1
$content = terraform-docs markdown table .
$content | Set-Content tformdocs.md

Set-Location $deploymentFolderPath
Set-Location ./terraform_layer2
$content = terraform-docs markdown table .
$content | Set-Content tformdocs.md

Set-Location $deploymentFolderPath
Set-Location ./terraform_layer3
$content = terraform-docs markdown table .
$content | Set-Content tformdocs.md

Set-Location $deploymentFolderPath
Set-Location ./terraform_layer2
$content = terraform-docs markdown table .
$content | Set-Content tformdocs.md

Set-Location $deploymentFolderPath
Write-Host "Finished"