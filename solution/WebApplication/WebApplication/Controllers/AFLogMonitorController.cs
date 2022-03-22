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

    public class AFLogMonitorController : BaseController
    {
        private readonly AppInsightsContext _context;
        public AFLogMonitorController(AppInsightsContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
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
            cols.Add(JObject.Parse("{ 'data':0, 'name':'Timestamp', 'autoWidth':true, 'ads_format': 'datetime' }"));
            cols.Add(JObject.Parse("{ 'data':1, 'name':'Operation Id', 'autoWidth':true, 'visible': false  }"));
            cols.Add(JObject.Parse("{ 'data':2, 'name':'Function Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':3, 'name':'Severity Level', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':4, 'name':'Execution Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':5, 'name':'Task Instance Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':6, 'name':'Activity Type', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':7, 'name':'Log Date (UTC)', 'autoWidth':true, 'visible': false}"));
            cols.Add(JObject.Parse("{ 'data':8, 'name':'Log (DateTimeOffset)', 'autoWidth':true, 'visible': false }"));
            cols.Add(JObject.Parse("{ 'data':9, 'name':'Status', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':10, 'name':'Task Master Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':11, 'name':'Comment', 'autoWidth':true, 'visible': false }"));
            cols.Add(JObject.Parse("{ 'data':12, 'name':'Message', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskGroupId");

            JArray Navigations = new JArray();            

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskGroup";
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
                string QueryStringWhere = "";
                string TimeFrameWhere = " timestamp >= now(-1h) ";
                int recordsTotal = 0;

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[operation_Name]"])))
                {
                    var filter = System.Convert.ToString(Request.Form["QueryParams[operation_Name]"]);
                    QueryStringWhere += " and operation_Name == \"" + filter + "\"";
                }

                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[severityLevel]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[severityLevel]"]);
                    QueryStringWhere += " and severityLevel >= " + filter;
                }

                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TimeFrame]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[TimeFrame]"]);
                    TimeFrameWhere = $"timestamp >= now(-{filter}h)";
                }

                string Query = @$"
                traces
                | extend    Comment = tostring(customDimensions.prop__Comment),
                            ExecutionUid = toguid(customDimensions.prop__ExecutionUid),
                            TaskInstanceId = toint(customDimensions.prop__TaskInstanceId),
                            ActivityType = tostring(customDimensions.prop__ActivityType),
                            LogSource = tostring(customDimensions.prop__LogSource),
                            LogDateUTC = todatetime(customDimensions.prop__LogDateUTC),
                            LogDateTimeOffset = todatetime(customDimensions.prop__LogDateTimeOffset),
                            Status = tostring(customDimensions.prop__Status),            
                            TaskMasterId = toint(customDimensions.prop__TaskMasterId)
                | where {TimeFrameWhere} {QueryStringWhere}
                | order by timestamp desc
                | project 
                    timestamp,
                    operation_Id,
                    operation_Name,
                    severityLevel,
                    ExecutionUid,
                    TaskInstanceId,
                    ActivityType,
                    LogSource,
                    LogDateUTC,
                    LogDateTimeOffset,
                    Status,            
                    TaskMasterId,
                    Comment,
                    message";

                // Getting all Customer data                    
                JArray modelDataAll = await _context.ExecuteQuery(Query);                
                
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
