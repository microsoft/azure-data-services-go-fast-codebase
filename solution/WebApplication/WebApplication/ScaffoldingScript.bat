REM WARNING. Regnerating an existing controller may cause code to be lost. Ensure you review the change before commiting it. 
REM The controllers have now reached a point where it is more effort to maintain complex scaffolding templates that it is to be careful with adding / regenerating controllers.
FOR %A IN ("ExecutionEngine" "FrameworkTaskRunner" "ScheduleInstance" "ScheduleMaster" "SourceAndTargetSystems" "SourceAndTargetSystemsJsonSchema" "TaskGroup" "TaskGroupDependency" "TaskInstance" "TaskMaster" "TaskMasterWaterMark" "TaskType" "TaskTypeMapping")	DO 	dotnet aspnet-codegenerator controller -m %A -dc AdsGoFastContext -l "~/Views/Shared/_Layout.cshtml" -name %AController -outDir Controllers -f


REM dotnet ef dbcontext scaffold "Server=adsgofastdatakakeaccelsqlsvr.database.windows.net;Database=AdsGoFast;Integrated Security=False;User=#####;password=#######" Microsoft.EntityFrameworkCore.SqlServer  --context test --context-dir Models2 --output-dir Models2 --table test --no-build


