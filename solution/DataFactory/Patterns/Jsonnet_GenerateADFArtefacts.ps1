Import-Module .\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform

$GenerateArm="false"

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



#Remove Previous Outputs
Get-ChildItem ./output | foreach {
    Remove-item $_ -force
}

#Copy Static Pipelines
$folder = "./pipeline/static"
$templates = (Get-ChildItem -Path $folder -Filter "*.json"  -Verbose)
foreach ($file in $templates)
{ 
    $content = Get-Content $file
    $outfile = ('./output/' + $File.Name)
    $content | Set-Content -Path $outfile 
}

#Copy IR Specific Pipelines
foreach ($ir in $tout.integration_runtimes)
{    

    $GFPIR = $ir.short_name
    if (($ir.is_azure -eq $false) -and ($tout.is_onprem_datafactory_ir_registered -eq $false))
    {
        Write-Host "Skipping Self Hosted Runtime as it is not yet registered"
    }
    else
    {
        $patterns = (Get-Content "Patterns.json") | ConvertFrom-Json

        foreach ($pattern in $patterns)
        {    
            $folder = "./pipeline/" + $pattern.Folder
            $templates = (Get-ChildItem -Path $folder -Filter "*.libsonnet"  -Verbose)

            Write-Host "_____________________________"
            Write-Host $folder 
            Write-Host "_____________________________"

            foreach ($t in $templates) {        
                #$GFPIR = $pattern.GFPIR
                $SourceType = $pattern.SourceType
                $SourceFormat = $pattern.SourceFormat
                $TargetType = $pattern.TargetType
                $TargetFormat = $pattern.TargetFormat

                $newname = (CoreReplacements -string $t.PSChildName -GFPIR $GFPIR -SourceType $SourceType -SourceFormat $SourceFormat -TargetType $TargetType -TargetFormat $TargetFormat).Replace(".libsonnet",".json")        
                Write-Host $newname        
                (jsonnet --tla-str GenerateArm=$GenerateArm --tla-str GFPIR=$GFPIR --tla-str SourceType="$SourceType" --tla-str SourceFormat="$SourceFormat" --tla-str TargetType="$TargetType" --tla-str TargetFormat="$TargetFormat" $t.FullName) | Set-Content('./output/' + $newname)

            }

        }
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

# This will copy the output pipeline files into the locations required for the terraform deployment
if($GenerateArm -eq "true") {
    $templates = Get-ChildItem -Path './output/*' -Exclude '*_Azure.json', '*_Azure.json' -Include "GPL*.json", "GPL_Sql*.json" -Name
    foreach($template in $templates) {
        Copy-Item -Path "./output/$template" -Destination "../../DeploymentV2\terraform\modules\data_factory_pipelines_selfhosted/arm/"  
    }
        
    Write-Host "Copied $($templates.Count) to Self Hosted Pipelines Module in Terraform folder"

    $templates = Get-ChildItem -Path './output/*' -Exclude '*_Azure.json', '*_Azure.json' -Include "GPL*.json", "GPL_Az*.json" -Name
    foreach($template in $templates) {
        Copy-Item -Path "./output/$template" -Destination "../../DeploymentV2\terraform\modules\data_factory_pipelines_azure/arm/"  
    }
    Write-Host "Copied $($templates.Count) to Azure Hosted Pipelines Module in Terraform folder"

    $templates = Get-ChildItem -Path './output/*' -Exclude '*_Azure.json', '*_Azure.json' -Include "SPL_Az*.json" -Name
    foreach($template in $templates) {
        Copy-Item -Path "./output/$template" -Destination "../../DeploymentV2\terraform\modules\data_factory_pipelines_azure/arm/"  
    }
    Write-Host "Copied $($templates.Count) to Static Hosted Pipelines Module in Terraform folder"
}
