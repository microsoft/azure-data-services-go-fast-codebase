#Move From Workflows to Function App
$CurrentPath = (Get-Location).Path
Set-Location "..\..\FunctionApp"
dotnet restore
dotnet publish --no-restore --configuration Release --output '..\Deployment\bin\publish\unzipped\functionapp\'
#Move back to workflows 
Set-Location $CurrentPath
Set-Location "../bin/publish"
$Path = (Get-Location).Path + "/zipped/functionapp" 
New-Item -ItemType Directory -Force -Path $Path
$Path = $Path + "/Publish.zip"
Compress-Archive -Path '.\unzipped\functionapp\*' -DestinationPath $Path -force
#Move back to workflows 
Set-Location $CurrentPath