function runajv($a){
    # Setup the Process startup info
    $pinfo = New-Object System.Diagnostics.ProcessStartInfo
    $pinfo.FileName = "ajv"
    $pinfo.Arguments = $a
    $pinfo.UseShellExecute = $false
    $pinfo.CreateNoWindow = $true
    $pinfo.RedirectStandardOutput = $true
    $pinfo.RedirectStandardError = $true    

    # Create a process object using the startup info
    $process = New-Object System.Diagnostics.Process
    $process.StartInfo = $pinfo

    # Start the process
    $process.Start() | Out-Null

    # Wait a while for the process to do something
    Start-Sleep -s 2

    # If the process is still active kill it
    if (!$process.HasExited) {
        $process.Kill()
    }

    # get output from stdout and stderr
    $stdout = $process.StandardOutput.ReadToEnd()
    $stderr = $process.StandardError.ReadToEnd()

    # check output for success information, you may want to check stderr if stdout if empty
    if ($process.ExitCode -eq 0) {                

    } else {
        if($stderr.Contains("Cannot find schema"))
        {
            write-host "SchemaFile Missing" -ForegroundColor DarkYellow -BackgroundColor Black            
        }
        else 
        {
            if($stderr.Contains("failed test"))
            {
            write-host $stderr.Split("failed test")[1] -ForegroundColor DarkRed -BackgroundColor Black        
            }
            else 
            {
                write-error 'unknown'
            }
        }
    }
}


$token=$(az account get-access-token --resource=https://database.windows.net/ --query accessToken --output tsv)     
$targetserver = $env:AdsOpts_CD_Services_AzureSQLServer_Name + ".database.windows.net"

$jsonbase = "./../../TaskTypeJson/"   

$sql = "Select a.TaskMasterId,a.TaskMasterJson, c.MappingName,c.SourceSystemType, c.SourceType, c.TargetSystemType, c.TargetType
        from dbo.TaskMaster a
        inner join dbo.TaskType b on a.TaskTypeId = b.TaskTypeId
        inner join dbo.SourceAndTargetSystems src on src.SystemId = a.SourceSystemId
        inner join dbo.SourceAndTargetSystems tgt on tgt.SystemId = a.TargetSystemId
        inner join dbo.TaskTypeMapping c on a.TaskDatafactoryIR = c.TaskDatafactoryIR and b.tasktypeid = c.tasktypeid and c.SourceSystemType = src.SystemType and c.TargetSystemType = tgt.SystemType"
    
$output = Invoke-Sqlcmd -ServerInstance "$targetserver,1433" -Database $env:AdsOpts_CD_Services_AzureSQLServer_AdsGoFastDB_Name -AccessToken "$token" -Query $sql

foreach ($row in $output)
{
    $tmj = $row.TaskMasterJson | ConvertFrom-Json
    if(($row.SourceType -eq $tmj.Source.Type) -and ($row.TargetType -eq $tmj.Target.Type))
    {            
        $schemaname = $row.MappingName 
        Write-Host "Processing TaskMaster " $row.TaskMasterId " using " $schemaname -ForegroundColor Yellow
        $row.TaskMasterJson | Set-Content('./temp/FileForUpload.json')               
        $a = 'migrate -s "./TaskTypeJson/"'+$schemaname+'".json" -o ./DataFactory/Patterns/temp/migrated_schema.json'
        runajv -a $a
        runajv -a "test -s ./DataFactory/Patterns/temp/migrated_schema.json -d ./DataFactory/Patterns/temp/FileForUpload.json --strict=false --valid"
        
    }
}


(((((Get-Content './pipeline/Azure-Storage-to-SQL-Database/tests/1.json' -raw).Replace("TaskObject","TaskMasterJson")) | ConvertFrom-Json).TaskMasterJson) | ConvertTo-Json -depth 100) | Set-Content('./temp/FileForUpload.json') 
ajv migrate -s ../../TaskTypeJson/GPL_AzureBlobFS_Excel_AzureSqlTable_NA.json -o ./temp/migrated_schema.json 
ajv test -s ./temp/migrated_schema.json -d ./temp/FileForUpload.json --strict=false --valid