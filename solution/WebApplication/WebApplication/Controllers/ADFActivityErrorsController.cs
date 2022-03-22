/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/
using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using WebApplication.Models;
using Dapper;
using Microsoft.EntityFrameworkCore;
using WebApplication.Controllers.Customisations;
using WebApplication.Services;

namespace WebApplication.Controllers
{
    
    public class ADFActivityErrorsController : Controller
    {
        private readonly AdsGoFastDapperContext _context;
        public ADFActivityErrorsController(AdsGoFastDapperContext context)
        {
            _context = context;
        }

        public IActionResult IndexDataTable()
        {
            return View();
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


                Dictionary<string, object> SqlParams = new Dictionary<string, object>();
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskInstanceId]"])))
                {
                    SqlParams.Add("@TaskInstanceId", System.Convert.ToInt64(Request.Form["QueryParams[TaskInstanceId]"]));
                }
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[ExecutionUid]"])))
                {
                    SqlParams.Add("@ExecutionUid", Guid.Parse(Request.Form["QueryParams[ExecutionUid]"].ToString().ToUpper()));
                }

                using var _con = await _context.GetConnection();
                var modelDataAll = (from row in await _con.QueryAsync(@"
                    select 
	                    a.ExecutionUid, 
	                    a.TaskInstanceId, 
	                    b.[Start],
	                    b.[End],
	                    a.PipelineRunStatus,  
	                    b.PipelineName,
	                    b.OperationName, 
	                    b.ErrorMessage,
	                    b.Input, 
	                    b.ActivityName, 
	                    b.ActivityType,
	                    b.[Output]
                    from ADFPipelineRun a 
                    join ADFActivityErrors b on a.EngineId = b.EngineId and a.PipelineRunUid = b.PipelineRunId
                    where TaskInstanceId =@TaskInstanceId and ExecutionUid=@ExecutionUid", SqlParams) select (IDictionary<string, object>)row).AsList();



                //total number of rows count     
                recordsTotal = modelDataAll.Count();
                //Paging     
                var data = modelDataAll.Skip(skip).Take(pageSize).ToList();
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


