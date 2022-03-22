using System;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using WebApplication.Models;
using WebApplication.Services;

namespace WebApplication.Controllers
{

    public class ADFTasksInProgressController : BaseController
    {
        private readonly LogAnalyticsContext _context;
        public ADFTasksInProgressController(LogAnalyticsContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
        {
            _context = context;
        }

        public IActionResult IndexDataTable()
        {            
            return View();
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();
            
            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':0, 'name':'Start', 'autoWidth':true, 'ads_format':'datetime'}"));
            cols.Add(JObject.Parse("{ 'data':1, 'name':'RunId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':2, 'name':'ExecutionUid', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':3, 'name':'TaskInstanceId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':4, 'name':'QueueTime', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':5, 'name':'RunningTime', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':6, 'name':'TotalTime', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':7, 'name':'PipelineName', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':8, 'name':'PipelineRunId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':9, 'name':'ResourceId', 'autoWidth':true, 'visible': false }"));
            //cols.Add(JObject.Parse("{ 'data':5, 'name':'LastOperation', 'autoWidth':true, 'ads_format':'datetime'}"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("0");

            JArray Navigations = new JArray();
            
            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "AFExecutionSummary";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["SuppressCrudButtons"] = true;

            return GridOptions;


        }

        public ActionResult GetGridOptions()
        {
            return new OkObjectResult(JsonConvert.SerializeObject(GridCols()));
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

                int recordsTotal = 0;

                // Getting all Customer data                    
                JArray modelDataAll = await _context.ExecuteQuery(@"
                
                let MinDate = now(-8d);
                ADFPipelineRun
                | where Start >  MinDate and  Status==""InProgress"" 
                | join kind = leftanti(
                    ADFPipelineRun
                    | where TimeGenerated > MinDate and Status in (""Succeeded"", ""Failed"", ""Cancelled"")
                    )  on $left.RunId == $right.RunId
                | extend        TaskInstanceId = coalesce(toint(parse_json(tostring(parse_json(Parameters).TaskObject)).TaskInstanceId), toint(parse_json(tostring(parse_json(Parameters))).TaskInstanceId)),
                                ExecutionUid = coalesce(tostring(parse_json(tostring(parse_json(Parameters).TaskObject)).ExecutionUid), tostring(parse_json(tostring(parse_json(Parameters))).ExecutionUid))
                | join
                (
                    ADFActivityRun
                        | where Start > MinDate and ActivityType != ""ExecutePipeline""
                        | extend QueueStart = case(Status == ""Queued"", Start, datetime(null))
                        | extend InProgressStart = case(Status == ""InProgress"", Start, datetime(null))
                        | extend CompletedTime = case(Status in (""Succeeded"", ""Failed"", ""Cancelled""), End, datetime(null))
                        | summarize QueueStart = max(QueueStart), InProgressStart = max(InProgressStart), CompletedTime = max(CompletedTime), QueueTime = max(InProgressStart) - max(QueueStart), RunningTime = max(CompletedTime) - max(InProgressStart)
                by PipelineRunId, ActivityRunId
                | extend  TotalTime = QueueTime + RunningTime, QueueTime = QueueTime, RunningTime = RunningTime
                | summarize  QueueTime = sum(QueueTime), RunningTime = sum(RunningTime), TotalTime = sum(TotalTime)
                by PipelineRunId
                ) on $left.RunId == $right.PipelineRunId
                | sort by Start
                | project Start, RunId, ExecutionUid, TaskInstanceId, QueueTime, RunningTime, TotalTime, PipelineName, PipelineRunId, ResourceId
                ");

                //total number of rows count     
                if (((JArray)modelDataAll).HasValues)
                {
                    recordsTotal = ((JArray)modelDataAll[0]["rows"]).Count();
                    return new OkObjectResult(JsonConvert.SerializeObject(new { draw = draw, recordsFiltered = recordsTotal, recordsTotal = recordsTotal, data = ((JArray)modelDataAll[0]["rows"]) }, new Newtonsoft.Json.Converters.StringEnumConverter()));
                }
                else
                {
                    return new OkObjectResult(JsonConvert.SerializeObject(new { draw = draw, recordsFiltered = recordsTotal, recordsTotal = recordsTotal }, new Newtonsoft.Json.Converters.StringEnumConverter()));
                }
            }
            catch (Exception)
            {
                throw;
            }

        }

    }
}
