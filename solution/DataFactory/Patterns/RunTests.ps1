
$patterns = ((Get-Content "Patterns.json") | ConvertFrom-Json).Folder | Get-Unique

foreach ($folder in $patterns)
{   
    Write-Host "_____________________________"
    Write-Host  $folder
    Write-Host "_____________________________" 
    
    $tests = (Get-ChildItem -Path ("./pipeline/"+$folder+"/tests/") -Verbose -recurse)
    foreach ($test in $tests)
    {
        $testfromjson = $test | Get-Content | ConvertFrom-Json    
        ($test | Get-Content) | Set-Content('FileForUpload.json')
        if ($testfromjson.Active -eq $true)
        {
            az datafactory pipeline create-run --factory-name $env:AdsOpts_CD_Services_DataFactory_Name --parameters '@FileForUpload.json' --name $testfromjson.TaskObject.DataFactory.ADFPipeline --resource-group $env:AdsOpts_CD_ResourceGroup_Name 
        }
    }
}