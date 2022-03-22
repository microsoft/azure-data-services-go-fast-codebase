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

    public class AFExecutionSummaryController : BaseController
    {
        private readonly AppInsightsContext _context;
        public AFExecutionSummaryController(AppInsightsContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
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
            cols.Add(JObject.Parse("{ 'data':0, 'name':'Function Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':1, 'name':'Executions', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':2, 'name':'Errors', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':3, 'name':'TaskInstances', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':4, 'name':'TaskMasters', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':5, 'name':'LastOperation', 'autoWidth':true, 'ads_format':'datetime'}"));

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
                traces
                | extend    Comment = tostring(customDimensions.prop__Comment),
                            ExecutionUid = toguid(customDimensions.prop__ExecutionUid),
                            TaskInstanceId = toint(customDimensions.prop__TaskInstanceId),
                            ActivityType = tostring(customDimensions.prop__ActivityType),
                            LogSource = tostring(customDimensions.prop__LogSource),
                            LogDateUTC = todatetime(customDimensions.prop__LogDateUTC),
                            LogDateTimeOffset = todatetime(customDimensions.prop__LogDateTimeOffset),
                            Status = tostring(customDimensions.prop__Status),            
                            TaskMasterId = toint(customDimensions.prop__TaskMasterId),
                            _Errors = case(severityLevel > 1, 1,0)
                | where timestamp >  now(-1d) and operation_Name != """"
                | order by timestamp desc
                | summarize Executions= dcount(operation_Id), LastOperation = max(timestamp), Errors = sum(_Errors), TaskInstances = dcount(TaskInstanceId), TaskMasters = dcount(TaskMasterId) by operation_Name
                | project 
                    operation_Name, 
                    Executions, 
                    Errors, 
                    TaskInstances,
                    TaskMasters,
                    LastOperation
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
