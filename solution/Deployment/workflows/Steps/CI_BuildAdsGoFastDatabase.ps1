#Move From Workflows to Function App
$CurrentPath = (Get-Location).Path
Set-Location "..\..\Database\ADSGoFastDbUp\AdsGoFastDbUp\"
dotnet restore
dotnet build --configuration Release --output ".\..\..\..\Deployment\bin\publish\unzipped\database\" 
#Move back to workflows 
Set-Location $CurrentPath
Set-Location "../bin/publish"
$Path = (Get-Location).Path + "/zipped/database" 
New-Item -ItemType Directory -Force -Path $Path
$Path = $Path + "/Publish.zip"
Compress-Archive -Path '.\unzipped\database\*' -DestinationPath $Path -force
#Move back to workflows 
Set-Location $CurrentPath