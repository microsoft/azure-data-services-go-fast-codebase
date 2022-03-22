Import-Module .\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform


if($tout.datafactory_name -eq "") {
    $tout.datafactory_name = Read-Host "Enter the name of the data factory"
}
if($tout.resource_group_name -eq "") {
    $tout.resource_group_name = Read-Host "Enter the name of the resource group"
}

$items = Get-ChildItem -Path "../../FunctionApp/FunctionApp.TestHarness/UnitTestResults/Todo/" 

#$arr = @()

foreach($item in $items)
{
    $testfromjson = $item | Get-Content | ConvertFrom-Json 
    ($item | Get-Content) | Set-Content('FileForUpload.json')
    $pipeline = $testfromjson.TaskObject.DataFactory.ADFPipeline + "_Azure"
    #echo az datafactory pipeline create-run --factory-name $tout.datafactory_name --parameters '@FileForUpload.json' --name $pipeline--resource-group $tout.resource_group_name 
    az datafactory pipeline create-run --factory-name $tout.datafactory_name --parameters '@FileForUpload.json' --name $pipeline --resource-group $tout.resource_group_name 
}


