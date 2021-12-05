function CoreReplacements ($string, $ReplaceIR)
{
    $string = $string.Replace("@GFP{SourceType}",$Pattern.SourceType).Replace("@GFP{SourceFormat}",$Pattern.SourceFormat).Replace("@GFP{TargetType}",$Pattern.TargetType).Replace("@GFP{TargetFormat}",$Pattern.TargetFormat)    
    if($ReplaceIR)
    {
        $string = $string.Replace("@GF{IR}",$IR).Replace("{IR}",$IR)
    }
    return  $string
}

function Generate($IR, $Pattern, $ReplaceIR, $FileIncludes)
{
    
    $files = (Get-ChildItem -Path "./Relational Source To File" -Include $FileIncludes  -Verbose -recurse) 
    foreach ($file in $files)  {
        $targetfile = ($file.BaseName).Replace("@GFP{SourceType}",$Pattern.SourceType).Replace("@GFP{SourceFormat}",$Pattern.SourceFormat).Replace("@GFP{TargetType}",$Pattern.TargetType).Replace("@GFP{TargetFormat}",$Pattern.TargetFormat) + ".json"
        Write-Host "Processing: $targetfile"
        if($ReplaceIR)
        {
            $targetfile = $targetfile.Replace("@GF{IR}",$IR).Replace("{IR}",$IR)
        }
        $fileName = $file.FullName
        $jsonobject = ($file | Get-Content).Replace("@GFP{SourceType}",$Pattern.SourceType).Replace("@GFP{SourceFormat}",$Pattern.SourceFormat).Replace("@GFP{TargetType}",$Pattern.TargetType).Replace("@GFP{TargetFormat}",$Pattern.TargetFormat)
                                
        if($ReplaceIR)
        {
            $jsonobject = $jsonobject.Replace("@GF{IR}",$IR).Replace("{IR}",$IR)
        }
       


        #Last do the major template chunks         
        foreach ($pipeline in $Pattern.Pipelines) {
         foreach ($name in $pipeline.Names) {           
            if(($jsonobject | ConvertFrom-Json).name -eq (CoreReplacements -string $name -ReplaceIR $ReplaceIR))
            {
                Write-Host "Doing Pattern Replacements"                
                foreach ($item in $pipeline.Replacements) {         
                    switch ($item.Type)
                    {
                        "InnerArray" { $jsonobject = $jsonobject.Replace($item.OldValue,($item.NewValue | ConvertTo-Json -AsArray -Depth 100))     }
                        "File"  {          
                                    $NewValFile = (CoreReplacements -string $item.NewValue -ReplaceIR $ReplaceIR)
                                    Write-Host  $NewValFile                      
                                    $jsonobject = $jsonobject.Replace($item.OldValue,(Get-Content -Path $NewValFile))     
                                }
                        default { $jsonobject = $jsonobject.Replace($item.OldValue,($item.NewValue | ConvertTo-Json -Depth 100))     }                    
                    }
                }
            }            
         }
        }

        if($ReplaceIR)
        {
            $jsonobject = $jsonobject.Replace("@GF{IR}",$IR).Replace("{IR}",$IR)
        }
                
        $jsonobject | set-content ("./output/" + $targetfile)
        
    }
}

$IR = "IRA"

Write-Host "_____________________________"
Write-Host "Datasets and Linked Services"
Write-Host "_____________________________"
Get-Content '.\Relational Source To File\PatternGeneration.json' | ConvertFrom-Json |ForEach-Object {  
    if ($_.Active -eq $true) {         
    Generate -IR $IR -Pattern $_ -ReplaceIR $true -FileIncludes "GDS*.json", "GLS*.json"
    }
}

Write-Host "_____________________________"
Write-Host "Pipelines"
Write-Host "_____________________________"
Get-Content '.\Relational Source To File\PatternGeneration.json' | ConvertFrom-Json |ForEach-Object {
    if ($_.Active -eq $true) {         
    Generate -IR $IR -Pattern $_ -ReplaceIR $true -FileIncludes "GPL_*.jsonc"
    }
}




