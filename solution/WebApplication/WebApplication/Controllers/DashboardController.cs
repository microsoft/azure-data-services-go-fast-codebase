using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using WebApplication.Services;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public partial class DashboardController : Controller
    {
        private readonly AdsGoFastDapperContext _context;

        public DashboardController(AdsGoFastDapperContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index(long? id)
        {
            if (id == null) { id = 1; }
			id = id * -1;
            string query = @$"
            
             Select 
				a.SubjectAreas,
				a.TaskGroups, 
				a.TaskMasters,
				a.Systems, 
				a.TaskTypes,
				a.Schedules, 
				TaskInstances = isnull(b.TaskInstances, 0), 
				FailedTasks = isnull(b.FailedTasks, 0), 
				SucceededTasks = isnull(b.SucceededTasks, 0), 
				UntriedTasks = isnull(b.UntriedTasks, 0), 
				InProgressTasks = isnull(b.InProgressTasks, 0), 
				ScheduleInstances = isnull(b.ScheduleInstances, 0), 
				EstimatedCost = isnull(b.EstimatedCost, 0), 
				RowsCopied = isnull(b.RowsCopied, 0), 
				DataRead = isnull(b.DataRead, 0), 
				DataWritten = isnull(b.DataWritten, 0),
				AvgExecTimeSec = isnull(b.AvgExecTimeSec,0)
			 from 
						(
						Select 
						SubjectAreas = (Select Count(*) from SubjectArea),
						TaskGroups = (Select Count(*) from TaskGroup),
						TaskMasters = (Select Count(*) from TaskMaster),
						Systems = (Select Count(*) from SourceandTargetSystems),
						TaskTypes = (Select Count(*) from TaskType),
						Schedules = (Select Count(*) from ScheduleMaster)
						) a 
						cross join 
						(
						Select 
									--count(distinct tm.TaskMasterId) TaskMasters,
									count(distinct ti.TaskInstanceId) TaskInstances,
									count(distinct case when ti.LastExecutionStatus like 'Failed%' then ti.TaskInstanceId else null end) FailedTasks,
									count(distinct case when ti.LastExecutionStatus = 'Complete' then ti.TaskInstanceId else null end) SucceededTasks,
									count(distinct case when ti.LastExecutionStatus = 'Untried' then ti.TaskInstanceId else null end) UntriedTasks,
									count(distinct case when ti.LastExecutionStatus = 'InProgress' then ti.TaskInstanceId else null end) InProgressTasks,
									count(distinct si.ScheduleInstanceId) ScheduleInstances,
									count(distinct cast(tei.ExecutionUid as varchar(200)) + cast(tei.TaskInstanceId as varchar(200))) Executions,
									sum(aps.TotalCost) EstimatedCost,
									sum(aps.rowsCopied) RowsCopied,
									sum(aps.DataRead) DataRead,
									sum(aps.DataWritten) DataWritten,
									avg(case when tei.EndDateTime is null then null else Datediff(second,tei.StartDateTime,tei.EndDateTime) end) AvgExecTimeSec
						From
								TaskGroup tg
								left join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
								left join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
								left join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId
								left join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
								left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
								left join ADFPipelineRun adfpr on adfpr.TaskInstanceId =  tei.TaskInstanceId and adfpr.ExecutionUid = tei.ExecutionUid
								left join ADFActivityRun aps on adfpr.EngineId = aps.EngineId and adfpr.PipelineRunUid = aps.PipelineRunUid 
						Where 
							(ti.LastExecutionStatus = 'Untried' OR tei.StartDateTime >= dateadd(hour, {id}, getutcdate()))
						)b 
            ";
			var con = await _context.GetConnection();

			var modelDataAll = (from row in con.Query(query) select (IDictionary<string, object>)row).AsList();
            return View(modelDataAll);
        }
    }


}
