
$GenerateArm="true"

function CoreReplacements ($string, $GFPIR, $SourceType, $SourceFormat, $TargetType, $TargetFormat) {
    $string = $string.Replace("@GFP{SourceType}", $SourceType).Replace("@GFP{SourceFormat}", $SourceFormat).Replace("@GFP{TargetType}", $TargetType).Replace("@GFP{TargetFormat}", $TargetFormat)

    if($GenerateArm -eq "false")
    {
        $string = $string.Replace("@GF{IR}", $GFPIR).Replace("{IR}", $GFPIR)
    }
    else 
    {
        $string = $string.Replace("_@GF{IR}", "").Replace("_{IR}", "")
    }

    return  $string
}

$patterns = (Get-Content "Patterns.json") | ConvertFrom-Json

foreach ($pattern in $patterns)
{    
    $folder = "./pipeline/" + $pattern.Folder
    $templates = (Get-ChildItem -Path $folder -Filter "*.libsonnet"  -Verbose)

    Write-Host "_____________________________"
    Write-Host $folder 
    Write-Host "_____________________________"

    foreach ($t in $templates) {
        $testasjson = ($test | ConvertTo-Json)

        $GFPIR = $pattern.GFPIR
        $SourceType = $pattern.SourceType
        $SourceFormat = $pattern.SourceFormat
        $TargetType = $pattern.TargetType
        $TargetFormat = $pattern.TargetFormat

        $newname = (CoreReplacements -string $t.PSChildName -GFPIR $GFPIR -SourceType $SourceType -SourceFormat $SourceFormat -TargetType $TargetType -TargetFormat $TargetFormat).Replace(".libsonnet",".json")        
        Write-Host $newname        
        (jsonnet --tla-str GenerateArm=$GenerateArm --tla-str GFPIR="IRA" --tla-str SourceType="$SourceType" --tla-str SourceFormat="$SourceFormat" --tla-str TargetType="$TargetType" --tla-str TargetFormat="$TargetFormat" $t.FullName) | Set-Content('./output/' + $newname)

    }

}

foreach ($folder in ($patterns.Folder | Get-Unique))
{
    $folder = "./pipeline/" + $folder
    Write-Host "_____________________________"
    Write-Host "Generating ADF Schema Files: " + $folder
    Write-Host "_____________________________"
    
    $schemafiles = (Get-ChildItem -Path ($folder+"/jsonschema/") -Filter "*.jsonnet"  -Verbose)
    foreach ($schemafile in $schemafiles)
    {    
        $newname = ($schemafile.PSChildName).Replace(".jsonnet",".json")
        (jsonnet $schemafile.FullName) | Set-Content('../../TaskTypeJson/' + $newname)
    }

}