using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using WebApplication.Framework;
using WebApplication.Models;
using WebApplication.Services;

namespace WebApplication.Controllers
{
    public partial class TaskInstanceExecutionController : BaseController
    {
        private readonly AdsGoFastContext _context;

        public TaskInstanceExecutionController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleprovider) : base(securityAccessProvider, roleprovider)
        { 
            _context = context;
        }

        [ChecksUserAccess]
        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.TaskInstanceExecution.Take(1);           
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'TaskInstance.TaskMaster.TaskMasterName', 'name':'TaskMaster', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ExecutionUid', 'name':'ExecutionUid', 'autoWidth':true }"));                        
            cols.Add(JObject.Parse("{ 'data':'PipelineName', 'name':'PipelineName', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'StartDateTime', 'name':'StartDateTime', 'autoWidth':true, 'ads_format': 'DateTime' }"));
            cols.Add(JObject.Parse("{ 'data':'EndDateTime', 'name':'EndDateTime', 'autoWidth':true, 'ads_format': 'DateTime' }"));
            cols.Add(JObject.Parse("{ 'data':'Status', 'name':'Status', 'autoWidth':true, 'ads_format':'taskstatus'}"));   
            cols.Add(JObject.Parse("{ 'data':'Comment', 'name':'Comment', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskGroupId");

            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskInstanceExecution";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["SuppressCrudButtons"] = true;
            GridOptions["InitialOrder"] = JArray.Parse("[[3,'desc']]");

            return GridOptions;
        }

        [ChecksUserAccess]
        public ActionResult GetGridOptions()
        {                 
            return new OkObjectResult(JsonConvert.SerializeObject(GridCols()));
        }

        [ChecksUserAccess]
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

                // Getting all Customer data    
                var modelDataAll = (from temptable in _context.TaskInstanceExecution
                                    select temptable);

                //filter the list by permitted roles
                if (!CanPerformCurrentActionGlobally())
                {
                    var permittedRoles = GetPermittedGroupsForCurrentAction();
                    var identity = User.Identity.Name;

                    modelDataAll =
                        (from md in modelDataAll
                         join ti in _context.TaskInstance
                            on md.TaskInstanceId equals ti.TaskInstanceId
                         join tm in _context.TaskMaster
                            on ti.TaskMasterId equals tm.TaskMasterId
                         join tg in _context.TaskGroup
                            on tm.TaskGroupId equals tg.TaskGroupId
                         join rm in _context.SubjectAreaRoleMap
                            on tg.SubjectAreaId equals rm.SubjectAreaId
                         where
                             GetUserAdGroupUids().Contains(rm.AadGroupUid)
                             && permittedRoles.Contains(rm.ApplicationRoleName)
                             && rm.ExpiryDate > DateTimeOffset.Now
                             && rm.ActiveYn
                         select md).Distinct();
                }


                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    TODO
                if (!string.IsNullOrEmpty(searchValue))
                {
                    //modelDataAll = modelDataAll.Where(m => m.TaskInstance.Contains(searchValue));
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskInstanceId]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[TaskInstanceId]"]);
                    modelDataAll = modelDataAll.Where(t => t.TaskInstanceId == filter);
                }


                //total number of rows count     
                recordsTotal = await modelDataAll.CountAsync();

                //Custom Includes
                modelDataAll = modelDataAll
                    .Include(t => t.TaskInstance).ThenInclude(t => t.TaskMaster)                    
                    .AsNoTracking();

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
            catch (Exception e)
            {
                throw;
            }
        }
    }


}
