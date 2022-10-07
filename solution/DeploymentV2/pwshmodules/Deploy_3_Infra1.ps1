param (
    [Parameter(Mandatory=$true)]
    [String]$deploymentFolderPath,
    [Parameter(Mandatory=$true)]
    [bool]$skipCustomTerraform=$true,
    [Parameter(Mandatory=$true)]
    [bool]$skipTerraformDeployment=$true
)

#------------------------------------------------------------------------------------------------------------
# Deploy the customisable terraform layer
#------------------------------------------------------------------------------------------------------------
if ($skipCustomTerraform) {
    Write-Host "Skipping Custom Terraform Layer"    
}
else {
    Set-Location $deploymentFolderPath
    Set-Location "./terraform_custom"

    terragrunt init --terragrunt-config vars/$env:environmentName/terragrunt.hcl -reconfigure

    if ($skipTerraformDeployment) {
        Write-Host "Skipping Custom Terraform Deployment"
    }
    else {
        Write-Host "Starting Custom Terraform Deployment"
        terragrunt apply -auto-approve --terragrunt-config vars/$env:environmentName/terragrunt.hcl
    }
}
#------------------------------------------------------------------------------------------------------------
$deploymentFolderPath = (Get-Location).Path