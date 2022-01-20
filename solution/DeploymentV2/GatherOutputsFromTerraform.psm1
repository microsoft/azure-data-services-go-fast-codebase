function GatherOutputsFromTerraform()
{
    $environmentName = "arkahna" # currently supports (local, staging)
    $myIp = (Invoke-WebRequest ifconfig.me/ip).Content

    $CurrentFolderPath = $PWD
    $env:TF_VAR_ip_address = $myIp

    #------------------------------------------------------------------------------------------------------------
    # Get all the outputs from terraform so we can use them in subsequent steps
    #------------------------------------------------------------------------------------------------------------
    Write-Host "-------------------------------------------------------------------------------------------------"
    Write-Host "Reading Terraform Outputs - Started"

    $tout = New-Object PSObject

    $tout0 = (terraform output -json | ConvertFrom-Json).PSObject.Properties 
    $tout0 | Foreach-Object {                    
        $tout | Add-Member  -MemberType NoteProperty -Name $_.Name -Value $_.Value.value
    }

    $rgid = (az group show -n $tout.resource_group_name | ConvertFrom-Json).id
    $tout | Add-Member  -MemberType NoteProperty -Name "resource_group_id" -Value $rgid

    Set-Location $CurrentFolderPath
    Write-Host "Reading Terraform Outputs - Finished"
    Write-Host "-------------------------------------------------------------------------------------------------"
    return $tout
}