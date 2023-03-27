Import-Module ./GatherOutputsFromTerraform_VMFolder.psm1 -Force
$tout = GatherOutputsFromTerraform_VMFolder
$newfolder = "./output/"


#Generate Patterns.json
(jsonnet "./patterns.jsonnet") | Set-Content("./Patterns.json")

$GenerateArm="false"

if (!(Test-Path "./output"))
{
    $fld = New-Item -itemType Directory -Name "output"
}
else
{
    Write-Verbose "Output Folder already exists"
}

#Remove Previous Outputs
$hiddenoutput = Get-ChildItem ./output | foreach {
    Remove-item $_ -force
}

$irsjson = ($tout.virtual_machine_integration_runtimes | ConvertTo-Json -Depth 10)


$irsql = @"
            Merge dbo.IntegrationRuntime Tgt
            using (
            Select * from OPENJSON('[$irsjson]') WITH 
            (
                name varchar(200), 
                short_name varchar(20), 
                is_azure bit, 
                is_managed_vnet bit     
            )
            ) Src on Src.short_name = tgt.IntegrationRuntimeName 
            when NOT matched by TARGET then insert
            (IntegrationRuntimeName, EngineId, ActiveYN)
            VALUES (Src.short_name,3,1);


            drop table if exists #tempIntegrationRuntimeMapping 
            Select ir.IntegrationRuntimeId, a.short_name IntegrationRuntimeName, c.[value] SystemId
            into #tempIntegrationRuntimeMapping
            from 
            (
            Select IR.*, Patterns.[Value] from OPENJSON('[$irsjson]') A 
           CROSS APPLY OPENJSON(A.[value]) Patterns 
           CROSS APPLY OPENJSON(A.[value]) with (short_name varchar(max)) IR 
           where Patterns.[key] = 'valid_source_systems'
           ) A
           OUTER APPLY OPENJSON(A.[Value])  C
           join 
           dbo.IntegrationRuntime ir on ir.IntegrationRuntimeName = a.short_name 
           
           drop table if exists #tempIntegrationRuntimeMapping2
           Select * into #tempIntegrationRuntimeMapping2
           from 
           (
           select a.IntegrationRuntimeId, a.IntegrationRuntimeName, b.SystemId from #tempIntegrationRuntimeMapping  a
           cross join [dbo].[SourceAndTargetSystems] b 
           where a.SystemId = '*'
           union 
           select a.IntegrationRuntimeId, a.IntegrationRuntimeName, a.SystemId from #tempIntegrationRuntimeMapping  a
           where a.SystemId != '*'
           ) a
                    
           Merge dbo.IntegrationRuntimeMapping tgt
           using #tempIntegrationRuntimeMapping2 src on 
           tgt.IntegrationRuntimeName = src.IntegrationRuntimeName and tgt.SystemId = src.SystemId
           when not matched by target then 
           insert 
           ([IntegrationRuntimeId], [IntegrationRuntimeName], [SystemId], [ActiveYN])
           values 
           (src.IntegrationRuntimeId, src.IntegrationRuntimeName, cast(src.SystemId as bigint), 1);            

           
"@            

$irsql | Set-Content "MergeIRs.sql"



#Copy IR Specific Pipelines
$patterns = (Get-Content "Patterns.json") | ConvertFrom-Json -Depth 10
foreach ($ir in $tout.integration_runtimes)
{    

    $GFPIR = $ir
    if (($tout.synapse_spark_pool_name -eq ""))
    {
        Write-Verbose "Skipping Synapse pipeline generation as there is no Synapse Spark Pool"
    }
    else
    {        
        foreach ($pattern in $patterns)
        {    
            $folder = "./pipeline/" + $pattern.Folder
            $templates = (Get-ChildItem -Path $folder -Filter "*.libsonnet"  -Verbose)

            Write-Verbose "_____________________________"
            Write-Verbose $folder 
            Write-Verbose "_____________________________"

            foreach ($t in $templates) {        
                $GFPIR = $pattern.GFPIR
                $SourceType = $pattern.SourceType
                $SourceFormat = $pattern.SourceFormat
                $TargetType = $pattern.TargetType
                $TargetFormat = $pattern.TargetFormat
                $SparkPoolName = $tout.synapse_spark_pool_name

                $newname = ($t.PSChildName).Replace(".libsonnet",".json")        
                Write-Verbose $newname        
                (jsonnet --tla-str GenerateArm=$GenerateArm  --tla-str SparkPoolName="$SparkPoolName"  --tla-str GFPIR="$GFPIR" $t.FullName) | Set-Content('./output/' + $newname)

            }

        }
    }
}

#foreach unique folder used by pattern.json
$patternFolders = $patterns.Folder | Get-Unique 
$schemafiles = @()
foreach ($patternFolder in $patternFolders)
 {  
    #clear previous runs
    if (Test-Path ("./pipeline/" + $patternFolder + "/output/schemas/taskmasterjson/"))
    {
        $hiddenoutput = Get-ChildItem ("./pipeline/" + $patternFolder + "/output/schemas/taskmasterjson/") | Remove-item -Recurse
    }
    
    $patternsInFolder = ($patterns | where-object {$_.Folder -eq $patternFolder})
    #get all patterns for that folder and generate the schema files
    $patternsInFolder | ForEach-Object {
        $guid = [guid]::NewGuid() 
        $item = $_
        $schemafile = [PSCustomObject]@{
            Guid = $guid            
            SourceType = $item.SourceType
            SourceFormat = $item.SourceFormat
            TargetType = $item.TargetType
            TargetFormat = $item.TargetFormat
            TaskTypeId = $item.TaskTypeId
            SourceFolder = "./pipeline/" + $item.Folder
            TargetFolder = ""
            Pipeline = $item.pipeline
        }               
        $schemafiles += $schemafile
        Write-Verbose "_____________________________"
        Write-Verbose "Generating ADF Schema Files: " 
        Write-Verbose ($schemafile.SourceFolder)
        Write-Verbose "_____________________________"
        
        $newfolder = ($schemafile.SourceFolder + "/output")
        $hiddenoutput = !(Test-Path $newfolder) ? ($F = New-Item -itemType Directory -Name $newfolder -Force) : ($F = "")
        $newfolder = ($newfolder + "/schemas")
        $hiddenoutput = !(Test-Path $newfolder) ? ($F = New-Item -itemType Directory -Name $newfolder -Force) : ($F = "")
        $newfolder = ($newfolder + "/taskmasterjson/")
        $hiddenoutput = !(Test-Path $newfolder) ? ($F = New-Item -itemType Directory -Name $newfolder -Force) : ($F = "")
        
        $schemafile.TargetFolder = $newfolder
        $schemafiletemplate = (Get-ChildItem -Path ($schemafile.SourceFolder+"/jsonschema/") -Filter "Main.libsonnet")

        $newname = ($schemafiletemplate.PSChildName).Replace(".libsonnet",".json").Replace("Main", $guid);

        $SourceType = $schemafile.SourceType
        $SourceFormat = $schemafile.SourceFormat
        $TargetType = $schemafile.TargetType
        $TargetFormat = $schemafile.TargetFormat

        (jsonnet --tla-str SourceType="$SourceType" --tla-str SourceFormat="$SourceFormat" --tla-str TargetType="$TargetType" --tla-str TargetFormat="$TargetFormat" $schemafiletemplate) | Set-Content($newfolder + $newname)
        
        
    }    
    
    $sql = @"
    BEGIN 
    Select * into #TempTTM from ( VALUES
"@
    $folder = "./pipeline/" + $patternFolder    
    foreach ($pattern in  $patternsInFolder)
    {  
        $pipeline = $pattern.Pipeline                
                
        #Write-Verbose "_____________________________"
        #Write-Verbose "Inserting into TempTTM: " 
        #Write-Verbose $pipeline
        #Write-Verbose "_____________________________"        
        $psplit = $pipeline.split("_")
        $SourceType = $pattern.SourceType
        $SourceFormat = $pattern.SourceFormat
        $TargetType = $pattern.TargetType
        $TargetFormat = $pattern.TargetFormat
        $TaskTypeId = $pattern.TaskTypeId

        $schemafileguid = ($schemafiles | where-object {$_.SourceFormat -eq $SourceFormat -and $_.SourceType -eq $SourceType -and $_.TargetFormat -eq $TargetFormat -and $_.TargetType -eq $TargetType -and $_.Pipeline -eq $pipeline}).Guid
        $tschemafile = $folder + "/output/schemas/taskmasterjson/"+ $schemafileguid + ".json"

        #$SourceType = $psplit[1]


        if ($TaskTypeId -eq -13) 
        {
            $MappingType = 'DLL'
        }
        else 
        {
            $MappingType = 'INVALID'
        }

        $content = Get-Content $tschemafile -raw
        $sql += "("
        $sql += "$TaskTypeId, N'$MappingType', N'$pipeline', N'$SourceType', N'$SourceFormat', N'$TargetType', N'$TargetFormat', NULL, 1,N'$content',N'{}'"
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
