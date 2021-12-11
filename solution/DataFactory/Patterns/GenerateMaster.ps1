
$PrimaryPipelines = (Get-ChildItem -Path ".\output\" -Include "GPL_*"  -recurse )
$SwitchTemplate =  (Get-Content -path ".\partials\Master_SwitchItem.json")

$SwitchItems = @()
$i = 0
foreach ($item in $PrimaryPipelines) {
    $NewItem = $SwitchTemplate.Replace("{PipelineName}",$item.Name).Replace("{ActivityName}",$i.ToString()) | ConvertFrom-Json
    $SwitchItems+=$NewItem
    $i = $i + 1
}


$Master = Get-Content ".\output\Master_$IR.json" | ConvertFrom-Json
foreach ($item in $Master.properties.activities) {
    if($item.name -eq "Switch Pipelines")
    {
        $item = $SwitchItems
    }    
}

$Master | ConvertTo-Json -Depth 100 | set-content ".\output\Master_$IR.json"