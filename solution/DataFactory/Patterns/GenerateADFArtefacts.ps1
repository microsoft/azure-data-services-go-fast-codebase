
#$folder = ".\RelationalSourceToFile"
$Folder = ".\pipeline\Azure Storage to SQL Database\"
function CoreReplacements ($string, $ReplaceIR)
{
    $string = $string.Replace("@GFP{SourceType}",$Pattern.SourceType).Replace("@GFP{SourceFormat}",$Pattern.SourceFormat).Replace("@GFP{TargetType}",$Pattern.TargetType).Replace("@GFP{TargetFormat}",$Pattern.TargetFormat)    
    if($ReplaceIR)
    {
        $string = $string.Replace("@GF{IR}",$IR).Replace("{IR}",$IR)
    }
    return  $string
}

function Generate($IR, $Pattern, $ReplaceIR, $FileIncludes, $Folder)
{
    
    $files = (Get-ChildItem -Path $Folder -Include $FileIncludes  -Verbose -recurse) 
    foreach ($file in $files)  {
        $targetfile = ($file.BaseName)
        $targetfile = (CoreReplacements -string $targetfile -ReplaceIR $ReplaceIR) + ".json"
        Write-Host "------------------------------"       
        Write-Host "Processing: $targetfile"       
        Write-Host "------------------------------"       
        $fileName = $file.FullName
        $contents = ($file | Get-Content -Raw)
        $jsonobject = (CoreReplacements -string $contents -ReplaceIR $ReplaceIR)
  
        #Last do the major template chunks                 
        foreach ($pipeline in $Pattern.Pipelines) {
         foreach ($name in $pipeline.Names) {           
            if(($jsonobject | ConvertFrom-Json).name -eq (CoreReplacements -string $name -ReplaceIR $ReplaceIR))
            {
                Write-Host "Doing Pattern Replacements for: " (CoreReplacements -string $name -ReplaceIR $ReplaceIR)                
                foreach ($item in $pipeline.Replacements) {         
                    switch ($item.Type)
                    {
                        "InnerArray" { $jsonobject = $jsonobject.Replace($item.OldValue,($item.NewValue | ConvertTo-Json -AsArray -Depth 100))     }
                        "File"  {          
                                    if($name.contains("Create"))
                                    {
                                        Write-Host ""
                                    }
                                    Write-Host  "Searching for partial: " $item.NewValue            
                                    Write-Host  "TemplatePlaceHolder: " $item.OldValue                                      
                                    if ($jsonobject.contains($item.OldValue))
                                    {                                       
                                        $NewValFile = (CoreReplacements -string $item.NewValue -ReplaceIR $ReplaceIR)
                                        if ($null -eq (Get-Content -Path $NewValFile) || (Get-Content -Path $NewValFile) -eq "")
                                        {
                                            Write-Warning "Partial not found"
                                        } 
                                        $jsonobject = $jsonobject.Replace($item.OldValue,(Get-Content -Path $NewValFile))   
                                    }     
                                    else {
                                        Write-Warning "Template placehoder not in original"
                                    }                
                                     
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
Generate -IR $IR -Pattern $null -ReplaceIR $true -FileIncludes "GDS_*.json" -Folder ".\dataset\"
Generate -IR $IR -Pattern $null -ReplaceIR $true -FileIncludes "GLS_*.json" -Folder ".\linkedservice\"


Write-Host "_____________________________"
Write-Host "Pipelines"
Write-Host "_____________________________"
Get-Content ($Folder + '\PatternGeneration.json') | ConvertFrom-Json |ForEach-Object {
    if ($_.Active -eq $true) {         
    Generate -IR $IR -Pattern $_ -ReplaceIR $true -FileIncludes "GPL*.jsonc" -Folder $Folder
    }
}

Write-Host "_____________________________"
Write-Host "Master"
Write-Host "_____________________________"
Get-Content ($Folder + '\PatternGeneration.json')| ConvertFrom-Json |ForEach-Object {
    if ($_.Active -eq $true) {         
    Generate -IR $IR -Pattern $_ -ReplaceIR $true -FileIncludes "Master_*.json" -Folder $Folder
    }
}


