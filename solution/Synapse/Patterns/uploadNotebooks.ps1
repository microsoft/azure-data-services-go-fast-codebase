Import-Module .\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform

Write-Host "_____________________________"
Write-Host " Uploading Synapse Notebooks " 
Write-Host "_____________________________"

$tests = (Get-ChildItem -Path ("../../Synapse/Notebooks/") -Verbose -recurse)
foreach ($test in $tests)
{
    ($test | Get-Content) | Set-Content('FileForUpload.json')
        az synapse notebook import --workspace-name $tout.synapse_workspace_name --name $test.BaseName --file '@FileForUpload.json' --folder-path 'FrameworkNotebooks'
        Remove-Item FileForUpload.json
}


