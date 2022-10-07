function ProcessTerraformApply (
    [Parameter(Mandatory = $true)]
    [System.Boolean]$gitDeploy = $false,
    [Parameter(Mandatory = $true)]
    [System.Object]$output
) {
    
    $warnings = ($output | ConvertFrom-Json -Depth 20) | Where-Object {$_."@level" -eq "warn"}              
    $errors = ($output | ConvertFrom-Json -Depth 20) | Where-Object {$_."@level" -eq "error"}              
    if($warnings.count -gt 0)
    {
        Write-Host "---------------------Terraform Warnings-----------------------------------------------------------"
        foreach($o in $warnings) {Write-Warning ($o."@message" + "; Address:" + $o.diagnostic.address + "; Detail:" + $o.diagnostic.detail)}
        Write-Host "--------------------------------------------------------------------------------------------------"
    }
    if($errors.count -gt 0)
    {
        Write-Host "---------------------Terraform Errors-------------------------------------------------------------"
        foreach($o in $errors) {Write-Error ($o."@message" + "; Address:" + $o.diagnostic.address + "; Detail:" + $o.diagnostic.detail)}
        Write-Host "--------------------------------------------------------------------------------------------------"
    }

}


# 
#
# $pout =  terragrunt plan --terragrunt-config vars/$env:environmentName/terragrunt.hcl -json
# (($pout | ConvertFrom-Json -Depth 20) | Where-Object {$_.type -eq "change_summary"})