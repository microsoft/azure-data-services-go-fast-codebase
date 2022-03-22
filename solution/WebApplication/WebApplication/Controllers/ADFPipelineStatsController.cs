using System;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using WebApplication.Models;
using WebApplication.Services;

namespace WebApplication.Controllers
{

    public class ADFPipelineStatsController : BaseController
    {
        private readonly AdsGoFastContext _context;
        public ADFPipelineStatsController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
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
            cols.Add(JObject.Parse("{ 'data':'ExecutionUid', 'name':'ExecutionUid', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskInstanceId', 'name':'TaskInstanceId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'PipelineRunStatus', 'name':'PipelineRunStatus', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'PipelineRunUid', 'name':'PipelineRunUid', 'autoWidth':true, 'visible':false }"));
            cols.Add(JObject.Parse("{ 'data':'CloudOrchestrationCost', 'name':'CloudOrchestrationCost', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SelfHostedOrchestrationCost', 'name':'SelfHostedOrchestrationCost', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SelfHostedDataMovementCost', 'name':'SelfHostedDataMovementCost', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SelfHostedPipelineActivityCost', 'name':'SelfHostedPipelineActivityCost', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'CloudPipelineActivityCost', 'name':'CloudPipelineActivityCost', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'RowsCopied', 'name':'RowsCopied', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DataRead', 'name':'DataRead', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DataWritten', 'name':'DataWritten', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskExecutionStatus', 'name':'TaskExecutionStatus', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'FailedActivities', 'name':'FailedActivities', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'Start', 'name':'Start', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'End', 'name':'End', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'MaxActivityTimeGenerated', 'name':'MaxActivityTimeGenerated', 'autoWidth':true }"));


            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("0");

            JArray Navigations = new JArray();            

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "ADFPipelineStats";
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

                //Paging Size (10,20,50,100)    
                int pageSize = length != null ? Convert.ToInt32(length) : 0;
                int skip = start != null ? Convert.ToInt32(start) : 0;
                int recordsTotal = 0;

                // Getting Data - Using the view Pbi.AdfPipelinestats   
                var modelDataAll = (from temptable in _context.AdfpipelineStats1
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }


                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskInstanceId]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[TaskInstanceId]"]);
                    modelDataAll = modelDataAll.Where(t => t.TaskInstanceId == filter);
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[ExecutionUid]"])))
                {
                    var filter = Guid.Parse(Request.Form["QueryParams[ExecutionUid]"]);
                    modelDataAll = modelDataAll.Where(t => t.ExecutionUid == filter);
                }

                //total number of rows count     
                recordsTotal = await modelDataAll.CountAsync();
                //Paging     
                var data = await modelDataAll.Skip(skip).Take(pageSize).ToListAsync();
                //Returning Json Data    
                var jserl = new JsonSerializerSettings
                {
                    ReferenceLoopHandling = ReferenceLoopHandling.Ignore,
                    Converters = { new Newtonsoft.Json.Converters.StringEnumConverter() }
                };

                return new OkObjectResult(JsonConvert.SerializeObject(new { draw = draw, recordsFiltered = recordsTotal, recordsTotal = recordsTotal, data = data }, jserl));

            }
            catch (Exception)
            {
                throw;
            }

        }

    }
}
