#------------------------------------------------------------------------------------------------------------
# Module Imports #Mandatory
#------------------------------------------------------------------------------------------------------------
import-Module ./pwshmodules/Deploy_0_Prep.psm1 -force
import-Module ./pwshmodules/GatherOutputsFromTerraform.psm1 -force
#------------------------------------------------------------------------------------------------------------
# Preparation #Mandatory
#------------------------------------------------------------------------------------------------------------
$PathToReturnTo = (Get-Location).Path
$deploymentFolderPath = Convert-Path -Path ((Get-Location).tostring() + '/')
$ipaddress = $env:TF_VAR_ip_address
$ipaddress2 = $env:TF_VAR_ip_address2
$gitDeploy = ([System.Environment]::GetEnvironmentVariable('gitDeploy')  -eq 'true')
PrepareDeployment -gitDeploy $gitDeploy -deploymentFolderPath $deploymentFolderPath -FeatureTemplate $FeatureTemplate -PathToReturnTo $PathToReturnTo
$terraformFolderPath = $PathToReturnTo + "/terraform_layer2"
$tout = GatherOutputsFromTerraform -TerraformFolderPath $terraformFolderPath

#------------------------------------------------------------------------------------------------------------
# SQL Connection
#------------------------------------------------------------------------------------------------------------
$sqlserver_name=$tout.sqlserver_name
$metadatadb_name=$tout.metadatadb_name

# Get Token
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)


# Get latest version that hasn't been extracted
$sqlcommand = @"
SELECT 
    ExtractionVersionId,
    ExtractedDateTime
FROM 
    [dbo].[MetadataExtractionVersion]
WHERE 
    ExtractionVersionId = (SELECT MAX(ExtractionVersionId) FROM MetadataExtractionVersion) AND ExtractedDateTime IS NULL
"@
$output = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   

if ($output.count -gt 0) {
    #------------------------------------------------------------------------------------------------------------
    # Query TaskMasters
    #------------------------------------------------------------------------------------------------------------
    $versionId = $output.ExtractionVersionId
    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[TaskMaster]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $taskMasters = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   

}
else {
    Write-Error "No Valid Version ID found. The latest VersionId must not have an associated ExtractedDateTime"
}