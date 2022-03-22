using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Dapper;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using WebApplication.Models;
using WebApplication.Services;

namespace WebApplication.Controllers
{
    public partial class ReportsAndStatisticsController : BaseController
    {
        private readonly AdsGoFastDapperContext _context;

        public ReportsAndStatisticsController(AdsGoFastDapperContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
        {
            _context = context;
        }

        public IActionResult IndexDataTable()
        {            
            return View();
        }

        public IActionResult TaskMasterStats()
        {
            return View();
        }

        public JObject GridCols(string StatsLevel)
        {
            
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data': null, 'name':'', 'width': '25px', 'className':'details-control', 'orderable':false, 'defaultContent': '<i></i>' }"));

            JArray pkeycols = new JArray();

            Name = StatsLevel;
            if (StatsLevel == "TaskGroup")
            {
                cols.Add(JObject.Parse("{ 'data':'TaskGroupId', 'name':'Task Group Id', 'autoWidth':true, ads_format: 'int',  className:'text-right'  }"));
                cols.Add(JObject.Parse("{ 'data':'TaskGroupName', 'name':'Task Group Name', 'autoWidth':true }"));
                GridOptions["InitialOrder"] = JArray.Parse("[[1,'asc']]");
                pkeycols.Add("TaskGroupId");
                GridOptions["CrudController"] = "TaskGroup";
                GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,Edit,Details,Delete");
            }

            if (StatsLevel == "ScheduleInstance")
            {
                cols.Add(JObject.Parse("{ 'data':'ScheduleInstanceId', 'name':'Schedule Instance Id', 'autoWidth':true, ads_format: 'int',  className:'text-right'  }"));
                cols.Add(JObject.Parse("{ 'data':'ScheduleDesciption', 'name':'Schedule Desciption', 'autoWidth':true }"));
                cols.Add(JObject.Parse("{ 'data':'ScheduledDateTimeOffset', 'name':'Scheduled Date', 'autoWidth':true, ads_format: 'datetime' }"));
                GridOptions["InitialOrder"] = JArray.Parse("[[3,'desc']]");
                pkeycols.Add("ScheduleInstanceId");
                GridOptions["CrudController"] = "ScheduleInstance";
                GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,Edit,Details,Delete");
            }

            if (StatsLevel == "TaskMaster")
            {
                cols.Add(JObject.Parse("{ 'data':'TaskMasterId', 'name':'Task Master Id', 'autoWidth':true, ads_format: 'int',  className:'text-right'  }"));
                cols.Add(JObject.Parse("{ 'data':'TaskMasterName', 'name':'Task Master Name', 'autoWidth':true }"));
                GridOptions["InitialOrder"] = JArray.Parse("[[1,'asc']]");
                pkeycols.Add("TaskMasterId");
                GridOptions["CrudController"] = "TaskMaster";
                GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,EditPlus,Details,Delete");
            }

            if (StatsLevel == "TaskInstance")
            {
                cols.Add(JObject.Parse("{ 'data':'TaskInstanceId', 'name':'Task Instance Id', 'autoWidth':true, ads_format: 'int',  className:'text-right' }"));
                cols.Add(JObject.Parse("{ 'data':'TaskMasterName', 'name':'Task Master Name', 'autoWidth':true }"));
                cols.Add(JObject.Parse("{ 'data':'ScheduledDateTimeOffset', 'name':'Scheduled Date', 'autoWidth':true, ads_format: 'datetime' }"));
                cols.Add(JObject.Parse("{ 'data':'UpdatedOn', 'name':'Last Update', 'autoWidth':true, ads_format: 'datetime'}"));
                cols.Add(JObject.Parse("{ 'data':'LastExecutionStatus', 'name':'Last Execution Status', 'autoWidth':true, ads_format: 'taskstatus'}"));                
                cols.Add(JObject.Parse("{ 'data':'EstimatedCost', 'name':'Estimated Cost', 'autoWidth':true, ads_format: 'money', className:'text-right'}"));
                cols.Add(JObject.Parse("{ 'data':'AvgExecTimeSec', 'name':'Avg Execution Time', 'autoWidth':true, ads_format: 'int', className:'text-right'}"));
                GridOptions["InitialOrder"] = JArray.Parse("[[4,'desc']]");
                pkeycols.Add("TaskInstanceId");
                GridOptions["SuppressCrudButtons"] = true;
            }

            if (StatsLevel == "TaskInstanceExecution")
            {
                cols.Add(JObject.Parse("{ 'data':'TaskInstanceId', 'name':'Task Instance Id', 'autoWidth':true, ads_format: 'int',  className:'text-right' }"));
                cols.Add(JObject.Parse("{ 'data':'TaskMasterName', 'name':'Task Master Name', 'autoWidth':true }"));
                cols.Add(JObject.Parse("{ 'data':'ScheduledDateTimeOffset', 'name':'Scheduled Date', 'autoWidth':true, ads_format: 'datetime' }"));
                cols.Add(JObject.Parse("{ 'data':'StartDateTime', 'name':'Start', 'autoWidth':true, ads_format: 'datetime' }"));
                cols.Add(JObject.Parse("{ 'data':'EndDateTime', 'name':'End', 'autoWidth':true, ads_format: 'datetime' }"));
                cols.Add(JObject.Parse("{ 'data':'Status', 'name':'Status', 'autoWidth':true,  ads_format: 'taskstatus' }"));
                cols.Add(JObject.Parse("{ 'data':'EstimatedCost', 'name':'Estimated Cost', 'autoWidth':true, ads_format: 'money'}"));
            }

            if (StatsLevel == "TaskGroup" || StatsLevel == "TaskMaster" || StatsLevel == "ScheduleMaster" || StatsLevel == "ScheduleInstance")
            {
                cols.Add(JObject.Parse("{ 'data':'FailedTasks', 'name':'Failed', 'autoWidth':true, ads_format: 'int', className:'text-right' }"));
                cols.Add(JObject.Parse("{ 'data':'SucceededTasks', 'name':'Succeeded', 'autoWidth':true, ads_format: 'int', className:'text-right' }"));
                cols.Add(JObject.Parse("{ 'data':'UntriedTasks', 'name':'Untried', 'autoWidth':true, ads_format: 'int', className:'text-right' }"));
                cols.Add(JObject.Parse("{ 'data':'InProgressTasks', 'name':'InProgress', 'autoWidth':true, ads_format: 'int', className:'text-right' }"));
                cols.Add(JObject.Parse("{ 'data':'EstimatedCost', 'name':'EstimatedCost', 'autoWidth':true, ads_format: 'money', className:'text-right'}"));
                cols.Add(JObject.Parse("{ 'data':'AvgExecTimeSec', 'name':'Avg Execution Time', 'autoWidth':true, ads_format: 'int', className:'text-right'}"));
                
            }

            HumanizeColumns(cols);


            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "ReportsAndStatistics";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            
            
            

            return GridOptions;
        }

        public ActionResult GetGridOptions()
        {
            string StatsLevel = Request.Form["QueryParams[StatsLevel]"];
            if (StatsLevel == "" || StatsLevel ==  null) { StatsLevel = "TaskGroup"; }
            return new OkObjectResult(JsonConvert.SerializeObject(GridCols(StatsLevel)));
        }

        public async Task<ActionResult> GetGridData()
        {
            try
            {
                
                string draw = Request.Form["draw"];
                string start = Request.Form["start"];
                string length = Request.Form["length"];
                string sortColumn = Request.Form["columns[" + Request.Form["order[0][column]"] + "][data]"];
                string sortColumnDir = Request.Form["order[0][dir]"];

                string searchValue = Request.Form["search[value]"];

                //Paging Size (10,20,50,100)    
                int pageSize = length != null ? Convert.ToInt32(length) : 0;
                int skip = start != null ? Convert.ToInt32(start) : 0;
                int recordsTotal = 0;
                string QueryLevel = "TaskGroup";

                List<string> whereclauses = new List<string>();

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[StatsLevel]"])))
                {
                    QueryLevel = System.Convert.ToString(Request.Form["QueryParams[StatsLevel]"]);
                    
                }
                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskGroupId]"])))
                {
                    //Convert to int first to protect agains sql injection
                    whereclauses.Add("tg.TaskGroupId = " + System.Convert.ToInt64(Request.Form["QueryParams[TaskGroupId]"]).ToString());
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskMasterId]"])))
                {
                    //Convert to int first to protect agains sql injection
                    whereclauses.Add("tm.TaskMasterId = " + System.Convert.ToInt64(Request.Form["QueryParams[TaskMasterId]"]).ToString());
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskInstanceId]"])))
                {
                    //Convert to int first to protect agains sql injection
                    whereclauses.Add("ti.TaskInstanceId = " + System.Convert.ToInt64(Request.Form["QueryParams[TaskInstanceId]"]).ToString());
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[ScheduleInstanceId]"])))
                {
                    //Convert to int first to protect agains sql injection
                    whereclauses.Add("si.ScheduleInstanceId = " + System.Convert.ToInt64(Request.Form["QueryParams[ScheduleInstanceId]"]).ToString());
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TimeFrame]"])))
                {
                    var Lag = System.Convert.ToInt64(Request.Form["QueryParams[TimeFrame]"]);
                    //Convert to int first to protect agains sql injection
                    whereclauses.Add($"(ti.LastExecutionStatus = 'Untried' OR tei.StartDateTime >= dateadd(hour, -{Lag}, getutcdate()))");
                }



                string where = "";
                if (whereclauses.Count > 0)
                {
                    where = System.Environment.NewLine + " WHERE " + string.Join(" AND ", whereclauses.ToArray());
                }

                string GroupByFields = QueryGroupByFields(QueryLevel);
                string Tables = QueryTables(QueryLevel);

                if (sortColumn == "")
                {
                    sortColumn = "ScheduledDateTimeOffset";
                }

                string Order = $@"  
                    ORDER BY [{sortColumn}] {sortColumnDir}
                ";

                string Paging = System.Environment.NewLine +   $"OFFSET {skip} ROWS FETCH NEXT {pageSize} ROWS ONLY" + System.Environment.NewLine;

                string Having = System.Environment.NewLine + $"HAVING count(distinct tm.TaskMasterId)>0" + System.Environment.NewLine;

                string Query = "Select " + GroupByFields + "," + QueryMeasures() + " from " + Tables + where + " GROUP BY " + GroupByFields + Having;
                string RowCountQuery = "Select count(*) from (" + Query + ") ct";
                Query = Query + Order + Paging;

                var con = await _context.GetConnection();
                recordsTotal = await con.ExecuteScalarAsync<int>(RowCountQuery);
                // Getting all Customer data    
                var modelDataAll = (from row in con.Query(Query) select(IDictionary<string, object>)row).AsList();



                //Returning Json Data    
                var jserl = new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                    Converters = { new Newtonsoft.Json.Converters.StringEnumConverter() }
                };

                return new OkObjectResult(JsonConvert.SerializeObject(new { draw = draw, recordsFiltered = recordsTotal, recordsTotal = recordsTotal, data = modelDataAll }, jserl));

            }
            catch (Exception)
            {
                throw;
            }
        }

        private string QueryGroupByFields(string Level)
        {
            string ret = "";
            if (Level == "TaskGroup")
            {
                ret = @"
                tg.TaskGroupId,
	            tg.TaskGroupName
                "; 
            };

            if (Level == "ScheduleInstance")
            {
                ret = @"
                si.ScheduleInstanceId,
                sm.ScheduleDesciption,
                si.ScheduledDateTimeOffset
     
                ";
            };

            if (Level == "TaskMaster")
            {
                ret = @"
                tg.TaskGroupId,
	            tg.TaskGroupName, 
	            tm.TaskMasterId, 
	            tm.TaskMasterName                
                ";
            };


            if (Level == "TaskInstance")
            {
                ret = @"
                tg.TaskGroupId,
	            tg.TaskGroupName, 
	            tm.TaskMasterId, 
	            tm.TaskMasterName,
                ti.TaskInstanceId,
                ti.LastExecutionStatus,
                ti.UpdatedOn,
                si.ScheduledDateTimeOffset
                ";
            };

            if (Level == "TaskInstanceExecution")
            {
                ret = @"
                tg.TaskGroupId,
	            tg.TaskGroupName, 
	            tm.TaskMasterId, 
	            tm.TaskMasterName,
                ti.TaskInstanceId,
                si.ScheduledDateTimeOffset,
                tei.StartDateTime,
                tei.EndDateTime,
                tei.ExecutionUid,
                tei.Status
                ";
            };


            return ret;
        }


        private string QueryTables(string Level)
        {
            string ret = "";
            if (Level == "TaskGroup")
            {
                ret = @"
                TaskGroup tg
	            left join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
	            left join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
	            left join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId
	            left join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
	            left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	            left join ADFPipelineRun adfpr on adfpr.TaskInstanceId =  tei.TaskInstanceId and adfpr.ExecutionUid = tei.ExecutionUid
                left join ADFActivityRun aps on adfpr.EngineId = aps.EngineId and adfpr.PipelineRunUid = aps.PipelineRunUid 
                ";
            };

            if (Level == "ScheduleInstance")
            {
                ret = @"
	            ScheduleInstance si 
                left join TaskInstance ti on si.ScheduleInstanceId = ti.ScheduleInstanceId
                left join TaskMaster tm on ti.TaskMasterId = tm.TaskMasterId
	            left join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
	            left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	            left join ADFPipelineRun adfpr on adfpr.TaskInstanceId =  tei.TaskInstanceId and adfpr.ExecutionUid = tei.ExecutionUid
                left join ADFActivityRun aps on adfpr.EngineId = aps.EngineId and adfpr.PipelineRunUid = aps.PipelineRunUid 
                ";
            };




            if (Level == "TaskMaster")
            {
                ret = @"
                TaskGroup tg
	            join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
	            join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
                left join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
	            left join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId	            
	            left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	            left join ADFPipelineRun adfpr on adfpr.TaskInstanceId =  tei.TaskInstanceId and adfpr.ExecutionUid = tei.ExecutionUid
                left join ADFActivityRun aps on adfpr.EngineId = aps.EngineId and adfpr.PipelineRunUid = aps.PipelineRunUid 
                ";
            };


            if (Level == "TaskInstance")
            {
                ret = @"
                TaskGroup tg
	            join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
	            join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
                join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
	            join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId	            
	            left join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	            left join ADFPipelineRun adfpr on adfpr.TaskInstanceId =  tei.TaskInstanceId and adfpr.ExecutionUid = tei.ExecutionUid
                left join ADFActivityRun aps on adfpr.EngineId = aps.EngineId and adfpr.PipelineRunUid = aps.PipelineRunUid
                ";
            };

            if (Level == "TaskInstanceExecution")
            {
                ret = @"
                TaskGroup tg
	            join TaskMaster tm on tm.TaskGroupId = tg.TaskGroupId
	            join ScheduleMaster sm on sm.ScheduleMasterId = tm.ScheduleMasterId
                join TaskInstance ti on ti.TaskMasterId = tm.TaskMasterId
	            join ScheduleInstance si on si.ScheduleInstanceId = ti.ScheduleInstanceId	            
	            join TaskInstanceExecution tei on tei.TaskInstanceId = ti.TaskInstanceId 
	            left join ADFPipelineRun adfpr on adfpr.TaskInstanceId =  tei.TaskInstanceId and adfpr.ExecutionUid = tei.ExecutionUid
                left join ADFActivityRun aps on adfpr.EngineId = aps.EngineId and adfpr.PipelineRunUid = aps.PipelineRunUid 
";
            };
            

            return ret;
        }

        private string QueryMeasures()
        {
            string ret = "";
          
            ret = @"
            count(distinct tm.TaskMasterId) TaskMasters,
	        count(distinct ti.TaskInstanceId) TaskInstances,
	        count(distinct case when ti.LastExecutionStatus like 'Failed%' then ti.TaskInstanceId else null end) FailedTasks,
	        count(distinct case when ti.LastExecutionStatus = 'Complete' then ti.TaskInstanceId else null end) SucceededTasks,
	        count(distinct case when ti.LastExecutionStatus = 'Untried' then ti.TaskInstanceId else null end) UntriedTasks,
	        count(distinct case when ti.LastExecutionStatus = 'InProgress' then ti.TaskInstanceId else null end) InProgressTasks,
            count(distinct sm.ScheduleMasterId) Schedules,
	        count(distinct si.ScheduleInstanceId) ScheduleInstances,
	        count(distinct cast(tei.ExecutionUid as varchar(200)) + cast(tei.TaskInstanceId as varchar(200))) Executions,
	        sum(aps.TotalCost) EstimatedCost,
	        sum(aps.rowsCopied) RowsCopied,
	        sum(aps.DataRead) DataRead,
	        sum(aps.DataWritten) DataWritten,
		    avg(case when tei.EndDateTime is null then null else Datediff(second,tei.StartDateTime,tei.EndDateTime) end) AvgExecTimeSec
            ";
            

            return ret;
        }

      
    }


}
