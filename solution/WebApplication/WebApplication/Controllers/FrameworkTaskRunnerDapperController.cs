using Dapper;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using WebApplication.Services;

namespace WebApplication.Controllers
{

    public partial class FrameworkTaskRunnerDapperController : BaseController
    {
        private readonly AdsGoFastDapperContext _context;

        public FrameworkTaskRunnerDapperController(AdsGoFastDapperContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
        {
            _context = context;
        }


        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'TaskRunnerId', 'name':'TaskRunnerId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskRunnerName', 'name':'TaskRunnerName', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'Status', 'name':'Status', 'autoWidth':true, 'ads_format':'taskrunnerstatus' }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYN', 'name':'ActiveYn', 'autoWidth':true, 'ads_format':'bool' }"));
            cols.Add(JObject.Parse("{ 'data':'LastExecutionStartDateTime', 'name':'LastRunStart', 'autoWidth':true, 'ads_format':'datetime' }"));
            cols.Add(JObject.Parse("{ 'data':'LastExecutionEndDateTime', 'name':'LastRunEnd', 'autoWidth':true, 'ads_format':'datetime'  }"));
            cols.Add(JObject.Parse("{ 'data':'MaxConcurrentTasks', 'name':'Task Slots', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskInstances', 'name':'Assigned Tasks', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'RunningTasks', 'name':'Running Tasks', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'RunTimeInSeconds', 'name':'Run Time In Seconds', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskRunnerId");

            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "FrameworkTaskRunner";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["SuppressCrudButtons"] = false;
            GridOptions["CrudController"] = "FrameworkTaskRunner";
            GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,Edit,Details,Delete");

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


                string Order = $@"  
                    ORDER BY [{sortColumn}] {sortColumnDir}
                ";

                string Paging = System.Environment.NewLine + $"OFFSET {skip} ROWS FETCH NEXT {pageSize} ROWS ONLY" + System.Environment.NewLine;

                string Having = System.Environment.NewLine + $"HAVING count(distinct tm.TaskMasterId)>0" + System.Environment.NewLine;

                string Query = @"
                Select 
	                ftr.*, 
	                TaskInstances, 
	                RunningTasks,
					RunTimeInSeconds = DATEDIFF(SECOND,ftr.LastExecutionStartDateTime, ftr.LastExecutionEndDateTime)
                from FrameworkTaskRunner ftr
                left join 
                (
	                Select ti.TaskRunnerId, 
		                   TaskInstances = count(*), 
		                   RunningTasks = sum(case when ti.LastExecutionStatus = 'InProgress' then 1 else 0 end)
						  
	                from TaskInstance ti 
	                group by ti.TaskRunnerId
                ) ti	
	                on ftr.TaskRunnerId = ti.TaskRunnerId";

                string RowCountQuery = "Select count(*) from (" + Query + ") ct";
                Query = Query + Order + Paging;

                var con = await _context.GetConnection();
                recordsTotal = await con.ExecuteScalarAsync<int>(RowCountQuery);
                // Getting all Customer data    
                var modelDataAll = (from row in con.Query(Query) select (IDictionary<string, object>)row).AsList();

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
    }
}
