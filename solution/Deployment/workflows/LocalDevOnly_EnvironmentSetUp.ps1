#az login 
#az account set -s "jorampon internal consumption"
#$DebugPreference = "Continue"
#$DebugPreference = "SilentlyContinue"

[Environment]::SetEnvironmentVariable("ENVIRONMENT_NAME", "development")
if (Test-Path -PathType Container -Path "../bin/"){$newitem = New-Item -ItemType Directory -Force -Path "../bin"}
$newitem = New-Item -Path "../bin/" -Name "GitEnv.txt" -type "file" -value "" -force   
. .\Steps\PushEnvFileIntoVariables.ps1
ParseEnvFile("$env:ENVIRONMENT_NAME")
Invoke-Expression -Command  ".\Steps\CD_SetResourceGroupHash.ps1" 


#Load Secrets into Environment Variables 
ParseSecretsFile ($SecretFile) 

