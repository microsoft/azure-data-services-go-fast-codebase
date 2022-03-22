
$folder = "./pipeline/Azure-Storage-to-SQL-Database/tests/"
$tests = (Get-ChildItem -Path $folder -Verbose -recurse) 

foreach ($test in $tests)
{
    $testobj = ($test | Get-Content -raw) | ConvertFrom-Json
    Write-Host "Processing Test " $testobj.Description " using " $testobj.JsonSchema -ForegroundColor Yellow
    (((((Get-Content $test.FullName -raw).Replace("TaskObject","TaskMasterJson")) | ConvertFrom-Json).TaskMasterJson) | ConvertTo-Json -depth 100) | Set-Content('./temp/FileForUpload.json') 
    ajv migrate -s ("./../../TaskTypeJson/"+$testobj.JsonSchema+".json") -o ./temp/migrated_schema.json
    ajv test -s ./temp/migrated_schema.json -d ./temp/FileForUpload.json --strict=false --valid
        
 
}


