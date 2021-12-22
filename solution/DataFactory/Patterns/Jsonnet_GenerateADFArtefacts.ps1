


function CoreReplacements ($string, $SourceType, $SourceFormat, $TargetType, $TargetFormat) {
    $string = $string.Replace("@GFP{SourceType}", $SourceType).Replace("@GFP{SourceFormat}", $SourceFormat).Replace("@GFP{TargetType}", $TargetType).Replace("@GFP{TargetFormat}", $TargetFormat).Replace("@GF{IR}", $GFPIR).Replace("{IR}", $GFPIR)
    return  $string
}

$patterns = (Get-Content "Patterns.json") | ConvertFrom-Json

foreach ($pattern in $patterns)
{    
    $folder = "./pipeline/" + $pattern.Folder
    $templates = (Get-ChildItem -Path $folder -Filter "*.libsonnet"  -Verbose)

    foreach ($t in $templates) {
        $testasjson = ($test | ConvertTo-Json -Depth 100)
        $SourceType = $pattern.SourceType
        $SourceFormat = $pattern.SourceFormat
        $TargetType = $pattern.TargetType
        $TargetFormat = $pattern.TargetFormat

        $newname = (CoreReplacements -string $t.PSChildName -SourceType $SourceType -SourceFormat $SourceFormat -TargetType $TargetType -TargetFormat $TargetFormat).Replace(".libsonnet",".json")
        Write-Host "_____________________________"
        Write-Host $newname
        Write-Host "_____________________________"
        (jsonnet --tla-str SourceType="$SourceType" --tla-str SourceFormat="$SourceFormat" --tla-str TargetType="$TargetType" --tla-str TargetFormat="$TargetFormat" $t.FullName) | Set-Content('./output/' + $newname)

    }
}
    




