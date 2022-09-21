function GatherOutputsFromTerraform_DataFactoryFolder()
{
    $PathToReturnTo = (Get-Location).Path
    $DeploymentFolderPath = Convert-Path -Path ((Get-Location).tostring() + './../../DeploymentV2/')
    $TerraformFolderPath = Convert-Path -Path ($DeploymentFolderPath + '/terraform_layer2/')

    Import-Module (Convert-Path -Path ($DeploymentFolderPath + "/pwshmodules/GatherOutputsFromTerraform.psm1")) -Force
    Import-Module (Convert-Path -Path ($DeploymentFolderPath + "/pwshmodules/Deploy_0_Prep.psm1")) -Force 
    
    $gitDeploy = ([System.Environment]::GetEnvironmentVariable('gitDeploy')  -eq 'true')
    if($gitDeploy)
    {
        #Do Nothing as prepare will already have been run
    }
    else 
    {
        PrepareDeployment -gitDeploy $false -deploymentFolderPath $deploymentFolderPath -FeatureTemplate "" -PathToReturnTo $PathToReturnTo
    }

    $tout = GatherOutputsFromTerraform -TerraformFolderPath $TerraformFolderPath
    return $tout
}
