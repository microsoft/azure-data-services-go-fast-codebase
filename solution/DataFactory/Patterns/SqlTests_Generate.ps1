

$sql = @"
delete from [dbo].[TaskGroup] where taskgroupid <=0;            
            
SET IDENTITY_INSERT [dbo].[TaskGroup] ON
INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-1,'Test Tasks',1, 0,10,null,1)

INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-2,'Test Tasks2',1, 0,10,null,1)

INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-3,'Test Tasks3',1, 0,10,null,1)

INSERT INTO [dbo].[TaskGroup] ([TaskGroupId],[TaskGroupName],[SubjectAreaId], [TaskGroupPriority],[TaskGroupConcurrency],[TaskGroupJSON],[ActiveYN])
Values (-4,'Test Tasks4',1, 0,10,null,1)

SET IDENTITY_INSERT [dbo].[TaskGroup] OFF

delete from [dbo].[TaskMaster] where taskmasterid <=0;

delete from [dbo].[TaskInstance] where taskmasterid <=0;




"@

$tests = (Get-Content -Path  ($PWD.ToString() + '../../../FunctionApp/FunctionApp.TestHarness/UnitTests/tests.json') | ConvertFrom-Json)

$i = 0
foreach ($t in $tests)
{
    Write-Host "_____________________________"
    Write-Host "Writing test number: " $i.ToString()
    Write-Host "_____________________________"
    $TaskMasterId = ($t.TaskMasterId)
    $TaskMasterName = $t.TestDescription
    $TaskTypeId = $t.TaskTypeId
    $TaskGroupId = ( -1, -2, -3, -4 | Get-Random  )
    $ScheduleMasterId = -4
    $SourceSystemId = $t.SourceSystemId
    $TargetSystemId = $t.TargetSystemId
    $DegreeOfCopyParallelism = $t.DegreeOfCopyParallelism
    $AllowMultipleActiveInstances = 0
    $TaskDatafactoryIR = "'Azure'"
    $TaskMasterJSON = $t.TaskMasterJson
    $ActiveYN = 0
    $DependencyChainTag = ""
    $EngineId = $t.EngineId
    
    $i+=1

    $sql += "
                                        
    SET IDENTITY_INSERT [dbo].[TaskMaster] ON;
    insert into [dbo].[TaskMaster]
    (
        [TaskMasterId]                          ,
        [TaskMasterName]                        ,
        [TaskTypeId]                            ,
        [TaskGroupId]                           ,
        [ScheduleMasterId]                      ,
        [SourceSystemId]                        ,
        [TargetSystemId]                        ,
        [DegreeOfCopyParallelism]               ,
        [AllowMultipleActiveInstances]          ,
        [TaskDatafactoryIR]                     ,
        [TaskMasterJSON]                        ,
        [ActiveYN]                              ,
        [DependencyChainTag]                    ,
        [EngineId]                         
    )
    select 
        $TaskMasterId                          ,
        '$TaskMasterName'                      ,
        $TaskTypeId                            ,
        $TaskGroupId                           ,
        $ScheduleMasterId                      ,
        $SourceSystemId                        ,
        $TargetSystemId                        ,
        $DegreeOfCopyParallelism               ,
        $AllowMultipleActiveInstances          ,
        $TaskDatafactoryIR                     ,
        '$TaskMasterJSON'                      ,
        $ActiveYN                              ,
        '$DependencyChainTag'                  ,
        $EngineId;  
    
    SET IDENTITY_INSERT [dbo].[TaskMaster] OFF;        
    
    "

}

$sql | Set-Content ("$PWD/SqlTests.sql")

