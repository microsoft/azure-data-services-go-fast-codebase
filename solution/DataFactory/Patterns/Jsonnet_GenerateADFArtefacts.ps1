Import-Module .\GatherOutputsFromTerraform.psm1 -force
$tout = GatherOutputsFromTerraform


#Generate Patterns.json
(jsonnet "./patterns.jsonnet") | Set-Content("./Patterns.json")

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

if (!(Test-Path "./output"))
{
    New-Item -itemType Directory -Name "output"
}
else
{
    Write-Information "Output Folder already exists"
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

$irsjson = ($tout.integration_runtimes | ConvertTo-Json)


$irsql = @"
            Merge dbo.IntegrationRuntime Tgt
            using (
            Select * from OPENJSON('$irsjson') WITH 
            (
                name varchar(200), 
                short_name varchar(20), 
                is_azure bit, 
                is_managed_vnet bit     
            )
            ) Src on Src.short_name = tgt.IntegrationRuntimeName 
            when NOT matched by TARGET then insert
            (IntegrationRuntimeName, EngineId, ActiveYN)
            VALUES (Src.short_name,1,1);
"@            

$irsql | Set-Content "MergeIRs.sql"

#Copy IR Specific Pipelines
$patterns = (Get-Content "Patterns.json") | ConvertFrom-Json
foreach ($ir in $tout.integration_runtimes)
{    

    $GFPIR = $ir.short_name
    if (($ir.is_azure -eq $false) -and ($tout.is_onprem_datafactory_ir_registered -eq $false))
    {
        Write-Host "Skipping Self Hosted Runtime as it is not yet registered"
    }
    else
    {        
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

#foreach unique folder used by pattern.json
$patternFolders = $patterns.Folder | Get-Unique 
foreach ($patternFolder in $patternFolders)
 {   
    $patternsInFolder = ($patterns | where-object {$_.Folder -eq $patternFolder})
    #get all patterns for that folder and generate the schema files
    $patternsInFolder | ForEach-Object -Parallel {
        $pattern = $_
        $SourceType = $pattern.SourceType
        $SourceFormat = $pattern.SourceFormat
        $TargetType = $pattern.TargetType
        $TargetFormat = $pattern.TargetFormat

        $TaskTypeId = $pattern.TaskTypeId
        
        $folder = "./pipeline/" + $pattern.Folder
        Write-Host "_____________________________"
        Write-Host "Generating ADF Schema Files: " 
        Write-Host $folder 
        Write-Host "_____________________________"
        
        $newfolder = ($folder + "/output")
        !(Test-Path $newfolder) ? ($F = New-Item -itemType Directory -Name $newfolder) : ($F = "")
        $newfolder = ($newfolder + "/schemas")
        !(Test-Path $newfolder) ? ($F = New-Item -itemType Directory -Name $newfolder) : ($F = "")
        $newfolder = ($newfolder + "/taskmasterjson/")
        !(Test-Path $newfolder) ? ($F = New-Item -itemType Directory -Name $newfolder) : ($F = "")
        
        $schemafile = (Get-ChildItem -Path ($folder+"/jsonschema/") -Filter "Main.libsonnet"  -Verbose)
        #foreach ($schemafile in $schemafiles)
        #{  
            $mappingName = $pattern.pipeline
            write-host $mappingName
            $newname = ($schemafile.PSChildName).Replace(".libsonnet",".json").Replace("Main", $MappingName);
            #(jsonnet $schemafile.FullName) | Set-Content('../../TaskTypeJson/' + $newname)
            (jsonnet --tla-str SourceType="$SourceType" --tla-str SourceFormat="$SourceFormat" --tla-str TargetType="$TargetType" --tla-str TargetFormat="$TargetFormat" $schemafile) | Set-Content($newfolder + $newname)
            #(jsonnet $schemafile.FullName) | Set-Content($newfolder + $newname)
        #}
    }    
    
    $sql = @"
    BEGIN 
    Select * into #TempTTM from ( VALUES
"@
    $folder = "./pipeline/" + $patternFolder    
    foreach ($pattern in  $patternsInFolder)
    {  
        $pipeline = $pattern.Pipeline        
        $schemafile = $folder + "/output/schemas/taskmasterjson/"+ $pattern.Pipeline + ".json"
                
        #Write-Host "_____________________________"
        #Write-Host "Inserting into TempTTM: " 
        #Write-Host $pipeline
        #Write-Host "_____________________________"        
        $psplit = $pipeline.split("_")
        $SourceType = $pattern.SourceType
        $SourceFormat = $pattern.SourceFormat
        $TargetType = $pattern.TargetType
        $TargetFormat = $pattern.TargetFormat
        $TaskTypeId = $pattern.TaskTypeId

        #$SourceType = $psplit[1]
        $SourceType = ($SourceType -eq "AzureBlobStorage") ? "Azure Blob":$SourceType
        $SourceType = ($SourceType -eq "AzureBlobFS") ? "ADLS" : $SourceType
        $SourceType = ($SourceType -eq "AzureSqlTable") ? "Azure SQL" : $SourceType
        $SourceType = ($SourceType -eq "AzureSqlDWTable") ? "Azure Synapse" : $SourceType
        $SourceType = ($SourceType -eq "SqlServerTable") ? "SQL Server" : $SourceType

        #$SourceFormat = $psplit[2]
        $SourceFormat = ($SourceFormat -eq "DelimitedText") ? "Csv":$SourceFormat

        #$TargetType = $psplit[3]
        $TargetType = ($TargetType -eq "AzureBlobStorage") ? "Azure Blob":$TargetType
        $TargetType = ($TargetType -eq "AzureBlobFS") ? "ADLS" : $TargetType
        $TargetType = ($TargetType -eq "AzureSqlTable") ? "Azure SQL" : $TargetType
        $TargetType = ($TargetType -eq "AzureSqlDWTable") ? "Azure Synapse" : $TargetType
        $TargetType = ($TargetType -eq "SqlServerTable") ? "SQL Server" : $TargetType

        #$TargetFormat = $psplit[4]        
        $TargetFormat = ($TargetFormat -eq "DelimitedText") ? "Csv":$TargetFormat

        if ($TaskTypeId -eq -1)
        {
        $TargetFormat = "Table"
        }

        $content = Get-Content $schemafile -raw
        $sql += "("
        $sql += "$TaskTypeId, N'ADF', N'$pipeline', N'$SourceType', N'$SourceFormat', N'$TargetType', N'$TargetFormat', NULL, 1,N'$content',N'{}'"
        $sql += "),"
    }
    if ($sql.endswith(","))
    {   $sql = $sql.Substring(0,$sql.Length-1) }
    $sql += @"
    ) a([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema])
    
    
    Update [dbo].[TaskTypeMapping]
    Set 
    MappingName = ttm2.MappingName,
    TaskMasterJsonSchema = ttm2.TaskMasterJsonSchema,
    TaskInstanceJsonSchema = ttm2.TaskInstanceJsonSchema
    from 
    [dbo].[TaskTypeMapping] ttm  
    inner join #TempTTM ttm2 on 
        ttm2.TaskTypeId = ttm.TaskTypeId 
        and ttm2.MappingType = ttm.MappingType
        and ttm2.SourceSystemType = ttm.SourceSystemType 
        and ttm2.SourceType = ttm.SourceType 
        and ttm2.TargetSystemType = ttm.TargetSystemType 
        and ttm2.TargetType = ttm.TargetType 

    Insert into 
    [dbo].[TaskTypeMapping]
    ([TaskTypeId], [MappingType], [MappingName], [SourceSystemType], [SourceType], [TargetSystemType], [TargetType], [TaskTypeJson], [ActiveYN], [TaskMasterJsonSchema], [TaskInstanceJsonSchema])
    Select ttm2.* 
    from [dbo].[TaskTypeMapping] ttm  
    right join #TempTTM ttm2 on 
        ttm2.TaskTypeId = ttm.TaskTypeId 
        and ttm2.MappingType = ttm.MappingType
        and ttm2.SourceSystemType = ttm.SourceSystemType 
        and ttm2.SourceType = ttm.SourceType 
        and ttm2.TargetSystemType = ttm.TargetSystemType 
        and ttm2.TargetType = ttm.TargetType 
    where ttm.TaskTypeMappingId is null

    END 
"@

        $sql | Set-Content ($folder + "/output/schemas/taskmasterjson/TaskTypeMapping.sql")    
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
