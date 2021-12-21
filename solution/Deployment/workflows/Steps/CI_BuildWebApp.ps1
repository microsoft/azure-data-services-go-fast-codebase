#Move From Workflows to Function App
$CurrentPath = (Get-Location).Path
Set-Location "..\..\WebApplication"
dotnet restore
dotnet publish --no-restore --configuration Release --output '..\Deployment\bin\publish\unzipped\webapplication\'
#Move back to workflows 
Set-Location $CurrentPath
Set-Location "../bin/publish"
$Path = (Get-Location).Path + "/zipped/webapplication" 
New-Item -ItemType Directory -Force -Path $Path
$Path = $Path + "/Publish.zip"
Compress-Archive -Path '.\unzipped\webapplication\*' -DestinationPath $Path -force
#Move back to workflows 
Set-Location $CurrentPath