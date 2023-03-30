#------------------------------------------------------------------------------------------------------------
# Script Summary
#------------------------------------------------------------------------------------------------------------
## This script will allow you to extract rows from specific tables within the metadata database on one environment and upsert it to a branch of another
## This script will be executed on the environment you are extracting rows from
## Summary of steps executed by script:
##      - Clone the branch of the repository that you wish to move the rows to
##      - Find the latest version Id that does not have a DateTime (extracted date time) within the MetadataExtractionVersion table
##      - Find any rows in the valid tables that have a versionId matching the above versionId
##      - Create a Insert/Merge sql statement for each row on the table, replacing any environment specific variables with the DBUp variable
##      - Create a Sql file for each table within the cloned branch MetadataCICD Dbup, under the versionid folder
##      - Modify the csproj xml to include the folder and files that have been created at time of execution
##      - Commit and push the changes to the remote branch
##      - Delete the temporarily cloned repo
##      - Set all of the rows with a ExtractionVersionId to null within the metadata db
##      - Set the DateTime of the MetadataExtractionVersion row that contained the versionId used in the script as this version has been 'completed'
##      - Create a new row in the MetadataExtractionVersion without a date time (this is the next version) 
##
## To enable the execution of the MetadataCICD DbUp in the written to environment, ensure you have the terraform variable publish_metadata_cicd_dbup = true
##
## This script will use the extra parameters. These will include:
## metadata_extraction_repo_link 
## metadata_extraction_publish_branch
## metadata_extraction_user_name
## metadata_extraction_email_address

#------------------------------------------------------------------------------------------------------------
# Static Parameters
#------------------------------------------------------------------------------------------------------------
#These variables can be modified to suit environment needs. It is advised to not change them inbetween runs.
## versionIncrement -> For incrementing the next ExtractionVersionId from the MetadataExtractionVersion table
##      Example: if versionIncrement is 1 and the versionId at runtime is 0, the MetadataExtractionVersion table 
##      is given the next ExtractionVersionId of 1. If versionIncrement is -100, then the next ExtractionVersionId will be -100.
## idIncrement -> This is for incrementing the Ids from the extracted rows in between environments. 
##      Example: If a taskmaster is extracted with the TaskMasterId of 1 with the idIncrement variable set to 100.
##      The SQL statement generated will compare (do the merge / insert) against a row with an TaskMasterId in the new environment of 101.
##      idIncrement can be used to help avoid ID overlaps.

$versionIncrement = 1
$idIncrement = 0

#------------------------------------------------------------------------------------------------------------
# Module Imports #Mandatory
#------------------------------------------------------------------------------------------------------------
import-Module ./pwshmodules/Deploy_0_Prep.psm1 -force
import-Module ./pwshmodules/GatherOutputsFromTerraform.psm1 -force
#------------------------------------------------------------------------------------------------------------
# Preparation #Mandatory
#------------------------------------------------------------------------------------------------------------
$PathToReturnTo = (Get-Location).Path
$deploymentFolderPath = Convert-Path -Path ((Get-Location).tostring() + '/')
$ipaddress = $env:TF_VAR_ip_address
$ipaddress2 = $env:TF_VAR_ip_address2
$gitDeploy = ([System.Environment]::GetEnvironmentVariable('gitDeploy')  -eq 'true')
PrepareDeployment -gitDeploy $gitDeploy -deploymentFolderPath $deploymentFolderPath -FeatureTemplate $FeatureTemplate -PathToReturnTo $PathToReturnTo
$terraformFolderPath = $PathToReturnTo + "/terraform_layer2"
$tout = GatherOutputsFromTerraform -TerraformFolderPath $terraformFolderPath



$repo_clone_url = "https://github.com/hugosharpe-insight/devgofast.git"
$publish_branch = "test2"
$user_name = "testuser"
$email_address = "testuser@test.com"

#$repo_clone_url = $tout.metadata_extraction_repo_link 
#$publish_branch = $tout.metadata_extraction_publish_branch 
#$user_name = $tout.metadata_extraction_user_name 
#$email_address = $tout.metadata_extraction_email_address 



#------------------------------------------------------------------------------------------------------------
# tout to DBUP Mapping Object
#------------------------------------------------------------------------------------------------------------
$map = @"
{
    "$($tout.datafactory_name)": "`$DataFactoryName`$",
    "$($tout.resource_group_name)": "`$ResourceGroupName`$",
    "$($tout.keyvault_name)": "`$KeyVaultName`$",
    "$($tout.loganalyticsworkspace_id)": "`$LogAnalyticsWorkspaceId`$",
    "$($tout.subscription_id)": "`$SubscriptionId`$",
    "$($tout.sampledb_name)": "`$SampleDatabaseName`$",
    "$($tout.stagingdb_name)": "`$StagingDatabaseName`$",
    "$($tout.metadatadb_name)": "`$MetadataDatabaseName`$",
    "$($tout.blobstorage_name)": "`$BlobStorageName`$",
    "$($tout.adlsstorage_name)": "`$AdlsStorageName`$",
    "$($tout.webapp_name)": "`$WebAppName`$",
    "$($tout.sqlserver_name)": "`$SqlServerName`$",
    "$($tout.synapse_workspace_name)": "`$SynapseWorkspaceName`$",
    "$($tout.synapse_sql_pool_name)": "`$SynapseDatabaseName`$",
    "$($tout.synapse_sql_pool_name)": "`$SynapseSQLPoolName`$",
    "$($tout.synapse_spark_pool_name)": "`$SynapseSparkPoolName`$",
    "$($tout.synapse_lakedatabase_container_name)": "`$SynapseLakeDatabaseContainerName`$",
    "$($tout.databricks_workspace_url)": "`$DatabricksWorkspaceURL`$",
    "$($tout.databricks_workspace_id)": "`$DatabricksWorkspaceResourceID`$",
    "$($tout.databricks_instance_pool_id)": "`$DefaultInstancePoolID`$",
    "$($tout.cmd_executor_vm_name)": "`$CmdExecutorVMName`$",
    "$($tout.adls_vm_cmd_executor_name)": "`$CmdExecutorVMAdlsName`$"
}
"@

$map = $map.replace('""','"EmptyProperty"')
$json = $map | ConvertFrom-Json -AsHashtable
# for use of mapping -> check source and target systems


#was for converting custom object to hash, not needed due to -AsHashTable
#$hash = @{}
#foreach ($property in $json.PSObject.Properties) {
#    $hash[$property.Name] = $property.Value
#}




#------------------------------------------------------------------------------------------------------------

#------------------------------------------------------------------------------------------------------------
# SQL Connection
#------------------------------------------------------------------------------------------------------------


$sqlserver_name=$tout.sqlserver_name
$metadatadb_name=$tout.metadatadb_name

# Get Token
$token=$(az account get-access-token --resource=https://database.windows.net --query accessToken --output tsv)


# Get latest version that hasn't been extracted
$sqlcommand = @"
SELECT 
    ExtractionVersionId,
    ExtractedDateTime
FROM 
    [dbo].[MetadataExtractionVersion]
WHERE 
    ExtractionVersionId = (SELECT MAX(ExtractionVersionId) FROM MetadataExtractionVersion) AND ExtractedDateTime IS NULL
"@
$output = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand   

if ($output.count -gt 0) {
    $versionId = $output.ExtractionVersionId


    #------------------------------------------------------------------------------------------------------------
    # Git Repo set up
    #------------------------------------------------------------------------------------------------------------
    $temporaryRepoName = "tempRepo"
    $temporaryRepoDirectory = "../../$($temporaryRepoName)"
    git clone -b "$($publish_branch)" "$($repo_clone_url)" "$($temporaryRepoDirectory)"
    Set-Location "$($temporaryRepoDirectory)/solution/Database/AdsGoFastDbUp/MetadataCICD"
    New-Item -ItemType Directory -Force -Path "./Version-$($versionId)/A-Journaled"

    #------------------------------------------------------------------------------------------------------------
    # Query TaskMasters
    #------------------------------------------------------------------------------------------------------------

    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[TaskMaster]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $taskMasters = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
    if($taskMasters.count -gt 0)
    {

        $headerSQL = @"
        SET IDENTITY_INSERT [dbo].[TaskMaster] ON
        GO

"@
        $footerSQL = @"
        SET IDENTITY_INSERT [dbo].[TaskMaster] OFF
        GO

"@
        $tmSQLStatement = $headerSQL
        foreach ($tm in $taskMasters)
        {
            $tmSQLTemplate = @"
                MERGE 
                    [dbo].[TaskMaster] AS [Target]
                USING 
                    (SELECT 
                        TaskMasterId = $($tm.TaskMasterId), 
                        TaskMasterName = '$($tm.TaskMasterName)', 
                        TaskTypeId = $($tm.TaskTypeId), 
                        TaskGroupId = $($tm.TaskGroupId), 
                        ScheduleMasterId = $($tm.ScheduleMasterId),
                        SourceSystemId = $($tm.SourceSystemId),
                        TargetSystemId = $($tm.TargetSystemId),
                        DegreeOfCopyParallelism = $($tm.DegreeOfCopyParallelism),
                        AllowMultipleActiveInstances = $([int][bool]::Parse($tm.AllowMultipleActiveInstances)),
                        TaskDatafactoryIR = '$($tm.TaskDatafactoryIR)',
                        TaskMasterJSON = '$($tm.TaskMasterJSON)',
                        ActiveYN = $([int][bool]::Parse($tm.ActiveYN)),
                        DependencyChainTag = '$($tm.DependencyChainTag)',
                        EngineId = $($tm.EngineId), 
                        InsertIntoCurrentSchedule = $([int][bool]::Parse($tm.InsertIntoCurrentSchedule))) AS [Source] 
                ON 
                    [Target].TaskMasterId = ([Source].TaskMasterId + $($idIncrement))
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].TaskMasterName = [Source].TaskMasterName,
                        [Target].TaskTypeId = [Source].TaskTypeId,
                        [Target].TaskGroupId = [Source].TaskGroupId,
                        [Target].ScheduleMasterId = [Source].ScheduleMasterId,
                        [Target].SourceSystemId = [Source].SourceSystemId,
                        [Target].TargetSystemId = [Source].TargetSystemId,
                        [Target].DegreeOfCopyParallelism = [Source].DegreeOfCopyParallelism,
                        [Target].AllowMultipleActiveInstances = [Source].AllowMultipleActiveInstances,
                        [Target].TaskDatafactoryIR = [Source].TaskDatafactoryIR,
                        [Target].TaskMasterJSON = [Source].TaskMasterJSON,
                        [Target].DependencyChainTag = [Source].DependencyChainTag,
                        [Target].EngineId = [Source].EngineId
                WHEN NOT MATCHED THEN
                    INSERT 
                        (TaskMasterId, 
                        TaskMasterName,
                        TaskTypeId,
                        TaskGroupId,
                        ScheduleMasterId,
                        SourceSystemId,
                        TargetSystemId,
                        DegreeOfCopyParallelism,
                        AllowMultipleActiveInstances, 
                        TaskDatafactoryIR,
                        TaskMasterJSON,
                        ActiveYN,
                        DependencyChainTag,
                        EngineId,
                        InsertIntoCurrentSchedule)
                    VALUES 
                        (([Source].TaskMasterId + $($idIncrement)),
                        [Source].TaskMasterName,
                        [Source].TaskTypeId,
                        [Source].TaskGroupId,
                        [Source].ScheduleMasterId,
                        [Source].SourceSystemId,
                        [Source].TargetSystemId,
                        [Source].DegreeOfCopyParallelism,
                        [Source].AllowMultipleActiveInstances,
                        [Source].TaskDatafactoryIR,
                        [Source].TaskMasterJSON,
                        0,
                        [Source].DependencyChainTag,
                        [Source].EngineId,
                        0);
                GO

"@
           $tmSQLStatement = $tmSQLStatement + "`r" + $tmSQLTemplate 

        }
        $tmSQLStatement = $tmSQLStatement + "`r" + $footerSQL
        $tmSQLStatement | Set-Content "./Version-$($versionId)/A-Journaled/TaskMaster.sql" -Force

    }

    #------------------------------------------------------------------------------------------------------------
    # Query Task Group
    #------------------------------------------------------------------------------------------------------------


    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[TaskGroup]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $taskGroups = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
    if($taskGroups.count -gt 0)
    {

        $headerSQL = @"
        SET IDENTITY_INSERT [dbo].[TaskGroup] ON
        GO

"@
        $footerSQL = @"
        SET IDENTITY_INSERT [dbo].[TaskGroup] OFF
        GO
        
"@
        $tgSQLStatement = $headerSQL
        foreach ($tg in $taskGroups)
        {
            $tgSQLTemplate = @"
                MERGE 
                    [dbo].[TaskGroup] AS [Target]
                USING 
                    (SELECT  
                        TaskGroupId = $($tg.TaskGroupId), 
                        SubjectAreaId = $($tg.SubjectAreaId), 
                        TaskGroupName = '$($tg.TaskGroupName)', 
                        TaskGroupPriority = $($tg.TaskGroupPriority), 
                        TaskGroupConcurrency = $($tg.TaskGroupConcurrency),
                        TaskGroupJSON = '$($tg.TaskGroupJSON)',
                        MaximumTaskRetries = $($tg.MaximumTaskRetries),
                        ActiveYN = $([int][bool]::Parse($tg.ActiveYN))) AS [Source] 
                ON 
                    [Target].TaskGroupId = ([Source].TaskGroupId + $($idIncrement))
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].SubjectAreaId = [Source].SubjectAreaId,
                        [Target].TaskGroupName = [Source].TaskGroupName,
                        [Target].TaskGroupPriority = [Source].TaskGroupPriority,
                        [Target].TaskGroupConcurrency = [Source].TaskGroupConcurrency,
                        [Target].TaskGroupJSON = [Source].TaskGroupJSON,
                        [Target].MaximumTaskRetries = [Source].MaximumTaskRetries,
                        [Target].ActiveYN = [Source].ActiveYN
                WHEN NOT MATCHED THEN
                    INSERT 
                        (TaskGroupId, 
                        SubjectAreaId,
                        TaskGroupName,
                        TaskGroupPriority,
                        TaskGroupConcurrency,
                        TaskGroupJSON,
                        MaximumTaskRetries,
                        ActiveYN)
                    VALUES 
                        (([Source].TaskGroupId + $($idIncrement)),
                        [Source].SubjectAreaId,
                        [Source].TaskGroupName,
                        [Source].TaskGroupPriority,
                        [Source].TaskGroupConcurrency,
                        [Source].TaskGroupJSON,
                        [Source].MaximumTaskRetries,
                        [Source].ActiveYN);
                GO

"@
           $tgSQLStatement = $tgSQLStatement + "`r" + $tgSQLTemplate 

        }
        $tgSQLStatement = $tgSQLStatement + "`r" + $footerSQL
        $tgSQLStatement | Set-Content "./Version-$($versionId)/A-Journaled/TaskGroup.sql" -Force

    }   

    #------------------------------------------------------------------------------------------------------------
    # Query Task Group Dependency
    #------------------------------------------------------------------------------------------------------------


    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[TaskGroupDependency]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $taskGroupDependencies = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
    if($taskGroupDependencies.count -gt 0)
    {
        $tgdSQLStatement = ""
        foreach ($tgd in $taskGroupDependencies)
        {
            $tgdSQLTemplate = @"
                MERGE 
                    [dbo].[TaskGroupDependency] AS [Target]
                USING 
                    (SELECT  
                        AncestorTaskGroupId = $($tgd.AncestorTaskGroupId), 
                        DescendantTaskGroupId = $($tgd.DescendantTaskGroupId), 
                        DependencyType = '$($tgd.DependencyType)') AS [Source] 
                ON 
                    [Target].AncestorTaskGroupId = [Source].AncestorTaskGroupId AND [Target].DescendantTaskGroupId = [Source].DescendantTaskGroupId
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].AncestorTaskGroupId = [Source].AncestorTaskGroupId,
                        [Target].DescendantTaskGroupId = [Source].DescendantTaskGroupId,
                        [Target].DependencyType = [Source].DependencyType
                WHEN NOT MATCHED THEN
                    INSERT 
                        (AncestorTaskGroupId, 
                        DescendantTaskGroupId,
                        DependencyType)
                    VALUES 
                        ([Source].AncestorTaskGroupId,
                        [Source].DescendantTaskGroupId,
                        [Source].DependencyType);
                GO

"@
           $tgdSQLStatement = $tgdSQLStatement + "`r" + $tgdSQLTemplate 

        }
        $tgdSQLStatement | Set-Content "./Version-$($versionId)/A-Journaled/TaskGroupDependency.sql" -Force

    }

    
    #------------------------------------------------------------------------------------------------------------
    # Query Schedule Master
    #------------------------------------------------------------------------------------------------------------


    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[ScheduleMaster]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $scheduleMasters = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
    if($scheduleMasters.count -gt 0)
    {

        $headerSQL = @"
        SET IDENTITY_INSERT [dbo].[ScheduleMaster] ON
        GO

"@
        $footerSQL = @"
        SET IDENTITY_INSERT [dbo].[ScheduleMaster] OFF
        GO

"@
        $smSQLStatement = $headerSQL
        foreach ($sm in $scheduleMasters)
        {
            $smSQLTemplate = @"
                MERGE 
                    [dbo].[ScheduleMaster] AS [Target]
                USING 
                    (SELECT  
                        ScheduleMasterId = $($sm.ScheduleMasterId), 
                        ScheduleCronExpression = '$($sm.ScheduleCronExpression)', 
                        ScheduleDesciption = '$($sm.ScheduleDesciption)', 
                        ActiveYN = $([int][bool]::Parse($sm.ActiveYN))) AS [Source] 
                ON 
                    [Target].ScheduleMasterId = ([Source].ScheduleMasterId + $($idIncrement))
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].ScheduleCronExpression = [Source].ScheduleCronExpression,
                        [Target].ScheduleDesciption = [Source].ScheduleDesciption,
                        [Target].ActiveYN = [Source].ActiveYN
                WHEN NOT MATCHED THEN
                    INSERT 
                        (ScheduleMasterId, 
                        ScheduleCronExpression,
                        ScheduleDesciption,
                        0)
                    VALUES 
                        (([Source].ScheduleMasterId + $($idIncrement)),
                        [Source].ScheduleCronExpression,
                        [Source].ScheduleDesciption,
                        [Source].ActiveYN);
                GO

"@
           $smSQLStatement = $smSQLStatement + "`r" + $smSQLTemplate 

        }
        $smSQLStatement = $smSQLStatement + "`r" + $footerSQL
        $smSQLStatement | Set-Content "./Version-$($versionId)/A-Journaled/ScheduleMaster.sql" -Force

    }

    #------------------------------------------------------------------------------------------------------------
    # Query Subject Area
    #------------------------------------------------------------------------------------------------------------


    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[SubjectArea]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $subjectAreas = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
    if($subjectAreas.count -gt 0)
    {

        $headerSQL = @"
        SET IDENTITY_INSERT [dbo].[SubjectArea] ON
        GO

"@
        $footerSQL = @"
        SET IDENTITY_INSERT [dbo].[SubjectArea] OFF
        GO

"@
        $saSQLStatement = $headerSQL
        foreach ($sa in $subjectAreas)
        {
            $saSQLTemplate = @"
                MERGE 
                    [dbo].[SubjectArea] AS [Target]
                USING 
                    (SELECT  
                        SubjectAreaId = $($sa.SubjectAreaId), 
                        SubjectAreaName = '$($sa.SubjectAreaName)', 
                        ActiveYN = $([int][bool]::Parse($sa.ActiveYN)),
                        SubjectAreaFormId = $($sa.SubjectAreaFormId.GetType().Name -eq 'DBNull' ? "NULL" : $sa.SubjectAreaFormId),
                        DefaultTargetSchema = '$($sa.DefaultTargetSchema)',
                        UpdatedBy = '$($sa.UpdatedBy)',
                        ShortCode = $($sa.ShortCode)) AS [Source] 
                ON 
                    [Target].SubjectAreaId = ([Source].SubjectAreaId + $($idIncrement))
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].SubjectAreaName = [Source].SubjectAreaName,
                        [Target].ActiveYN = [Source].ActiveYN,
                        [Target].SubjectAreaFormId = [Source].SubjectAreaFormId,
                        [Target].DefaultTargetSchema = [Source].DefaultTargetSchema,
                        [Target].UpdatedBy = [Source].UpdatedBy,
                        [Target].ShortCode = [Source].ShortCode
                WHEN NOT MATCHED THEN
                    INSERT 
                        (SubjectAreaId, 
                        SubjectAreaName,
                        ActiveYN,
                        SubjectAreaFormId,
                        DefaultTargetSchema,
                        UpdatedBy,
                        ShortCode)
                    VALUES 
                        (([Source].SubjectAreaId + $($idIncrement)),
                        [Source].SubjectAreaName,
                        [Source].ActiveYN,
                        [Source].SubjectAreaFormId,
                        [Source].DefaultTargetSchema,
                        [Source].UpdatedBy,
                        [Source].ShortCode);
                GO

"@
           $saSQLStatement = $saSQLStatement + "`r" + $saSQLTemplate 

        }
        $saSQLStatement = $saSQLStatement + "`r" + $footerSQL
        $saSQLStatement | Set-Content "./Version-$($versionId)/A-Journaled/SubjectArea.sql" -Force

    }      
      

    #------------------------------------------------------------------------------------------------------------
    # Query Source and Target Systems
    #------------------------------------------------------------------------------------------------------------


    $sqlcommand = @"
    SELECT
        *
    FROM
        [dbo].[SourceAndTargetSystems]
    WHERE
        ExtractionVersionId = $($versionId)
"@
    $sourceAndTargetSystems = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
    if($sourceAndTargetSystems.count -gt 0)
    {

        $headerSQL = @"
        SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] ON
        GO

"@
        $footerSQL = @"
        SET IDENTITY_INSERT [dbo].[SourceAndTargetSystems] OFF
        GO

"@
        $stsSQLStatement = $headerSQL
        foreach ($sts in $sourceAndTargetSystems)
        {
            $stsSQLTemplate = @"
                MERGE 
                    [dbo].[SourceAndTargetSystems] AS [Target]
                USING 
                    (SELECT  
                        SystemId = $($sts.SystemId), 
                        SystemName = '$($sts.SystemName)',
                        SystemType = '$($sts.SystemType)',
                        SystemDescription = '$($sts.SystemDescription)',
                        SystemServer = '$($sts.SystemServer)',
                        SystemAuthType = '$($sts.SystemAuthType)',
                        SystemUserName = $($sts.SystemUserName.GetType().Name -eq 'DBNull' ? "NULL" : "'" + $sts.SystemUserName + "'"),
                        SystemSecretName = $($sts.SystemSecretName.GetType().Name -eq 'DBNull' ? "NULL" : "'" + $sts.SystemSecretName + "'"),
                        SystemKeyVaultBaseUrl = 'https://`$KeyVaultName`$.vault.azure.net/', 
                        SystemJSON = '$($sts.SystemJSON)',  
                        ActiveYN = $([int][bool]::Parse($sts.ActiveYN)),
                        IsExternal = $([int][bool]::Parse($sts.IsExternal))) AS [Source] 
                ON 
                    [Target].SystemId = ([Source].SystemId + $($idIncrement))
                WHEN MATCHED THEN
                    UPDATE SET 
                        [Target].SystemName = [Source].SystemName,
                        [Target].SystemType = [Source].SystemType,
                        [Target].SystemDescription = [Source].SystemDescription,
                        [Target].SystemServer = [Source].SystemServer,
                        [Target].SystemAuthType = [Source].SystemAuthType,
                        [Target].SystemUserName = [Source].SystemUserName,
                        [Target].SystemSecretName = [Source].SystemSecretName,
                        [Target].SystemKeyVaultBaseUrl = [Source].SystemKeyVaultBaseUrl,
                        [Target].SystemJSON = [Source].SystemJSON,
                        [Target].ActiveYN = [Source].ActiveYN,
                        [Target].IsExternal = [Source].IsExternal
                WHEN NOT MATCHED THEN
                    INSERT 
                        (SystemId,
                        SystemName, 
                        SystemType,
                        SystemDescription,
                        SystemServer,
                        SystemAuthType,
                        SystemUserName,
                        SystemSecretName,
                        SystemKeyVaultBaseUrl,
                        SystemJSON,
                        ActiveYN,
                        IsExternal)
                    VALUES 
                        (([Source].SystemId + $($idIncrement)),
                        [Source].SystemName,
                        [Source].SystemType,
                        [Source].SystemDescription,
                        [Source].SystemServer,
                        [Source].SystemAuthType,
                        [Source].SystemUserName,
                        [Source].SystemSecretName,
                        [Source].SystemKeyVaultBaseUrl,
                        [Source].SystemJSON,
                        [Source].ActiveYN,
                        [Source].IsExternal);
                GO

"@
           $stsSQLStatement = $stsSQLStatement + "`r" + $stsSQLTemplate 

        }
        $stsSQLStatement = $stsSQLStatement + "`r" + $footerSQL

        #use our map to go line by line and replace our terraform outputs with the dbup variable representation
        $stsSQLStatementCleaned = ""
        foreach($line in $stsSQLStatement)
        {
            foreach ($h in $json.GetEnumerator())
            {
                if ($line -match $h.Key)
                {
                    $line = $line -replace $h.Key, $h.Value
                }
            }
        $stsSQLStatementCleaned = $stsSQLStatementCleaned + $line
        }

        $stsSQLStatementCleaned | Set-Content "./Version-$($versionId)/A-Journaled/SourceAndTargetSystems.sql" -Force

    }      
    $fileCount = ( Get-ChildItem -Path "./Version-$($versionId)/A-Journaled/" -File | Measure-Object ).Count;
    if ($fileCount -gt 0) 
    {

        $files = Get-ChildItem -Path "./Version-$($versionId)/A-Journaled/" -Filter *.sql | Select Name
        [xml]$csproj = Get-Content MetadataCICD.csproj

        foreach($file in $files) {
            $fileName = $file.Name
            $tableName = $file.Name -replace ".sql",""


            #------------------------------------------------------------------------------------------------------------
            # XML elements for csproj
            #------------------------------------------------------------------------------------------------------------


            #append first item group element      
            $childNode = $csproj.CreateElement("None")

            $attrib = $csproj.CreateAttribute('Remove')
            $attrib.Value = "Version-$($versionId)\A-Journaled\$($fileName)"
            [void]$childNode.Attributes.Append($attrib)

            $parentNode = $csproj.Project.ItemGroup[0]
            [void]$parentNode.AppendChild($childNode)

            #append second item group element
            $childNode = $csproj.CreateElement("EmbeddedResource")

            $attrib = $csproj.CreateAttribute('Include')
            $attrib.Value = "Version-$($versionId)\A-Journaled\$($fileName)"
            [void]$childNode.Attributes.Append($attrib)

            $parentNode = $csproj.Project.ItemGroup[1]
            [void]$parentNode.AppendChild($childNode)

            #------------------------------------------------------------------------------------------------------------
            # Set ExtractionVersionId on Table
            #------------------------------------------------------------------------------------------------------------
            $sqlcommand = @"
            UPDATE 
                [dbo].[$($tableName)]
            SET
                ExtractionVersionId = NULL
            WHERE
                ExtractionVersionId = $($versionId);
"@
        $sqlQuery = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand

        }

        #------------------------------------------------------------------------------------------------------------
        # XML element for csproj version folder
        #------------------------------------------------------------------------------------------------------------
        #append folder element
        $childNode = $csproj.CreateElement("Folder")

        $attrib = $csproj.CreateAttribute('Include')
        $attrib.Value = "Version-$($versionId)\"
        [void]$childNode.Attributes.Append($attrib)

        $parentNode = $csproj.Project.ItemGroup[3]
        [void]$parentNode.AppendChild($childNode)

        ##check for init -> First time running, delete placeholder init nodes
        ##these init's exist as if there is no element on a node they are treated as strings by powershell
        if($csproj.project.itemgroup[0].None[0].Remove -eq 'Init')
        {
            $childNode = $csproj.project.itemgroup[0].None[0]
            $parentNode = $csproj.project.itemgroup[0]
            $parentNode.RemoveChild($childNode)
        }
        if($csproj.project.itemgroup[1].EmbeddedResource[0].Include -eq 'Init')
        {
            $childNode = $csproj.project.itemgroup[1].EmbeddedResource[0]
            $parentNode = $csproj.project.itemgroup[1]
            $parentNode.RemoveChild($childNode)
        }
        if($csproj.project.itemgroup[3].Folder[0].Include -eq 'Init')
        {
            $childNode = $csproj.project.itemgroup[3].Folder[0]
            $parentNode = $csproj.project.itemgroup[3]
            $parentNode.RemoveChild($childNode)
        }

        $path = (Get-Location).Path
        $csproj.save("$($path)/MetadataCICD.csproj")

        #------------------------------------------------------------------------------------------------------------
        # Update MetadataExtractionVersion table
        #------------------------------------------------------------------------------------------------------------
        $sqlcommand = @"
        UPDATE 
            [dbo].[MetadataExtractionVersion]
        SET
            ExtractedDateTime = GETDATE()
        WHERE
            ExtractionVersionId = $($versionId)
"@
        $sqlQuery = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand

        $sqlcommand = @"
        SET IDENTITY_INSERT [dbo].[MetadataExtractionVersion] ON
        GO
        INSERT INTO 
            [dbo].[MetadataExtractionVersion] 
                (ExtractionVersionId)
        VALUES
            ($($versionId) + $($versionIncrement));

        SET IDENTITY_INSERT [dbo].[MetadataExtractionVersion] OFF
        GO

"@
        $sqlQuery = Invoke-Sqlcmd -ServerInstance "$sqlserver_name.database.windows.net,1433" -Database $metadatadb_name -AccessToken $token -query $sqlcommand
        #------------------------------------------------------------------------------------------------------------
        # Git push updated repo to branch / delete temporary repo
        #------------------------------------------------------------------------------------------------------------

        if ($user_name -ne "") {
            git config user.name "$($user_name)"
        }
        if ($email_address -ne "") {
            git config user.email "$($email_address)"
        }

        Set-Location "../../../../"
        git add .
        Write-Information ("Pushing to " + $repo_link + "against the branch " + $publish_branch)
        git commit -m "Metadata Extraction Version-$($versionId) commit" --quiet

        git push origin $($publish_branch)

        Set-Location $PathToReturnTo
        Write-Information "Deleting Temporary Repo"
        Remove-Item $temporaryRepoDirectory -Recurse -Force
        Write-Information "Complete!"

    }
    Set-Location $PathToReturnTo

}
else {
    Write-Error "No Valid Version ID found. The latest VersionId must not have an associated ExtractedDateTime"
}