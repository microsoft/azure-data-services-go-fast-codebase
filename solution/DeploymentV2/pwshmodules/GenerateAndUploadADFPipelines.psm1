
<#
 * Copyright (c) Microsoft Corporation.
 * Licensed under the MIT license.

* General Description *
This is a PowerShell function that generates and uploads Data Factory and Synapse artifacts. 
The function takes three mandatory parameters: a "tout" object, a string for the deployment folder path, and a string for the path to return to after the deployment. 
The function starts by setting the location to the deployment folder path and importing a module for gathering outputs from Terraform. 
The function then generates ADF artifacts in the "DataFactory/Patterns" directory by calling a script named "Jsonnet_GenerateADFArtefacts.ps1". 
If the "adf_git_toggle_integration" property of the "tout" object is set to true, the function then uploads the generated patterns to Git. Otherwise, it uploads them to the Azure Data Factory. 
The function then uploads task type mappings. The function then repeats the same process for the "Synapse/Patterns" directory. 
Finally, the function returns to the original location if specified.


#>
function GenerateAndUploadDataFactoryAndSynapseArtefacts (    
    [Parameter(Mandatory = $true)]
    [pscustomobject]$tout = $false,
    [Parameter(Mandatory = $true)]
    [string]$deploymentFolderPath = "",
    [Parameter(Mandatory = $true)]
    [String]$PathToReturnTo = ""
) {
    Set-Location $deploymentFolderPath
    Import-Module .\pwshmodules\GatherOutputsFromTerraform.psm1 -force
    
    Write-Host "Starting Adf Patterns" -ForegroundColor Yellow
    Set-Location ../DataFactory/Patterns/
    Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1

    if ($tout.adf_git_toggle_integration) {
        Invoke-Expression  ./UploadGeneratedPatternsToGit.ps1
    }
    else {
        Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
    }
    Invoke-Expression  ./UploadTaskTypeMappings.ps1

    if ($tout.update_execution_engine_jsons) {
        Invoke-Expression  ./UpdateExecutionEngine.ps1
    }
    #Below is temporary - we want to make a parent folder for the both of these directories in the future.
    #Currently there are duplicate powershell scripts. Plan is to iterate through each subfolder (datafactory / synapse) with one script
    Write-Host "Starting Synapse Parts" -ForegroundColor Yellow
    Set-Location ../../Synapse/Patterns/ 
    Invoke-Expression  ./Jsonnet_GenerateADFArtefacts.ps1
    if ($tout.synapse_git_toggle_integration) {
        Invoke-Expression  ./UploadGeneratedPatternsToGit.ps1
    }
    else {
        #upload notebooks first as we have pipelines directly dependent on them -> changing so that notebooks references are dynamic instead of direct but still uploading notebooks first.
        Invoke-Expression  ./uploadNotebooks.ps1
        Invoke-Expression  ./UploadGeneratedPatternsToADF.ps1
    }
    Invoke-Expression  ./UploadTaskTypeMappings.ps1

    if ($tout.update_execution_engine_jsons) {
        Invoke-Expression  ./UpdateExecutionEngine.ps1
    }

    Set-Location $deploymentFolderPath
    if([string]::IsNullOrEmpty($PathToReturnTo) -ne $true)
    {
            Write-Debug "Returning to $PathToReturnTo"
            Set-Location $PathToReturnTo
        }
        else {
            Write-Debug "Path to return to is null"
    }

    if ($tout.deploy_cmd_executor_vm) {
        Write-Host "Starting Virtual Machines Parts" -ForegroundColor Yellow
        Set-Location ../../VirtualMachine/Patterns/ 
        Invoke-Expression  ./Jsonnet_GeneratePatterns.ps1
        Invoke-Expression  ./UploadTaskTypeMappings.ps1

        if ($tout.update_execution_engine_jsons) {
            Invoke-Expression  ./UpdateExecutionEngine.ps1
        }
    }



}