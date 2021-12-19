using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebApplication.Services;
using WebApplication.Framework;
using WebApplication.Models;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace WebApplication.Controllers
{
    public partial class TaskMasterController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public TaskMasterController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "TaskMaster";
            _context = context;
        }

        // GET: TaskMaster
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.TaskMaster.Include(t => t.ScheduleMaster).Include(t => t.SourceSystem).Include(t => t.TargetSystem).Include(t => t.TaskGroup).Include(t => t.TaskType);
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: TaskMaster/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskMaster = await _context.TaskMaster
                .Include(t => t.ScheduleMaster)
                .Include(t => t.SourceSystem)
                .Include(t => t.TargetSystem)
                .Include(t => t.TaskGroup)
                .Include(t => t.TaskType)
                .FirstOrDefaultAsync(m => m.TaskMasterId == id);
            if (taskMaster == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(taskMaster))
                return new ForbidResult();


            return View(taskMaster);
        }

        // GET: TaskMaster/Create
        public IActionResult Create(int? TaskGroupId)
        {
                        
            ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption");
            ViewData["SourceSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName");
            ViewData["TargetSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName");

            if (TaskGroupId != null)
            {
                ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup.Where(x => x.TaskGroupId == TaskGroupId), "TaskGroupId", "TaskGroupName");
            }
            else
            {
                ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x => x.TaskGroupName), "TaskGroupId", "TaskGroupName");
            }
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x=>x.TaskTypeName), "TaskTypeId", "TaskTypeName");
            ViewData["DataFactoryId"] = new SelectList(_context.DataFactory.OrderBy(x => x.Name), "Id", "Name");
            TaskMaster taskMaster = new TaskMaster();
            taskMaster.TaskMasterJson = "{}";
            taskMaster.DegreeOfCopyParallelism = 1;
            taskMaster.ActiveYn = true;
            return View("EditPlus",taskMaster);
        }


        // POST: TaskMaster/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("TaskMasterId,TaskMasterName,TaskTypeId,TaskGroupId,ScheduleMasterId,SourceSystemId,TargetSystemId,DegreeOfCopyParallelism,AllowMultipleActiveInstances,TaskDatafactoryIr,TaskMasterJson,ActiveYn,DependencyChainTag,DataFactoryId")] TaskMaster taskMaster)
        {
            if (ModelState.IsValid)
            {
                _context.Add(taskMaster);
                if (!await CanPerformCurrentActionOnRecord(taskMaster))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
        ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", taskMaster.ScheduleMasterId);
        ViewData["SourceSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName", taskMaster.SourceSystemId);
        ViewData["TargetSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName", taskMaster.TargetSystemId);
        ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskMaster.TaskGroupId);
        ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x=>x.TaskTypeName), "TaskTypeId", "TaskTypeName", taskMaster.TaskTypeId);
        ViewData["DataFactoryId"] = new SelectList(_context.DataFactory.OrderBy(x => x.Name), "Id", "Name");
            return View(taskMaster);
        }

        // GET: TaskMaster/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskMaster = await _context.TaskMaster.FindAsync(id);
            if (taskMaster == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskMaster))
                return new ForbidResult();
        ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", taskMaster.ScheduleMasterId);
        ViewData["SourceSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName", taskMaster.SourceSystemId);
        ViewData["TargetSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName", taskMaster.TargetSystemId);
        ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskMaster.TaskGroupId);
        ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x=>x.TaskTypeName), "TaskTypeId", "TaskTypeName", taskMaster.TaskTypeId);
        ViewData["DataFactoryId"] = new SelectList(_context.DataFactory.OrderBy(x => x.Name), "Id", "DataFactoryName");
            return View(taskMaster);
        }

        // POST: TaskMaster/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, [Bind("TaskMasterId,TaskMasterName,TaskTypeId,TaskGroupId,ScheduleMasterId,SourceSystemId,TargetSystemId,DegreeOfCopyParallelism,AllowMultipleActiveInstances,TaskDatafactoryIr,TaskMasterJson,ActiveYn,DependencyChainTag,DataFactoryId")] TaskMaster taskMaster)
        {
            if (id != taskMaster.TaskMasterId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskMaster);

                    if (!await CanPerformCurrentActionOnRecord(taskMaster))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskMasterExists(taskMaster.TaskMasterId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(IndexDataTable));
            }
        ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", taskMaster.ScheduleMasterId);
        ViewData["SourceSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName", taskMaster.SourceSystemId);
        ViewData["TargetSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(x=>x.SystemName), "SystemId", "SystemName", taskMaster.TargetSystemId);
        ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskMaster.TaskGroupId);
        ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x=>x.TaskTypeName), "TaskTypeId", "TaskTypeName", taskMaster.TaskTypeId);
        ViewData["DataFactoryId"] = new SelectList(_context.DataFactory.OrderBy(x => x.Name), "Id", "DataFactoryName");
            return View(taskMaster);
        }

        // GET: TaskMaster/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskMaster = await _context.TaskMaster
                .Include(t => t.ScheduleMaster)
                .Include(t => t.SourceSystem)
                .Include(t => t.TargetSystem)
                .Include(t => t.TaskGroup)
                .Include(t => t.TaskType)
                .FirstOrDefaultAsync(m => m.TaskMasterId == id);
            if (taskMaster == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(taskMaster))
                return new ForbidResult();

            return View(taskMaster);
        }

        // POST: TaskMaster/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var taskMaster = await _context.TaskMaster.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(taskMaster))
                return new ForbidResult();
		
            _context.TaskMaster.Remove(taskMaster);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool TaskMasterExists(long id)
        {
            return _context.TaskMaster.Any(e => e.TaskMasterId == id);
        }

        [ChecksUserAccess]
        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.TaskMaster.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'TaskMasterId', 'name':'Id' }"));
            cols.Add(JObject.Parse("{ 'data':'TaskMasterName', 'name':'Name', }"));
            cols.Add(JObject.Parse("{ 'data':'TaskType.TaskTypeName', 'name':'Task Type'}"));
            cols.Add(JObject.Parse("{ 'data':'ScheduleMaster.ScheduleDesciption', 'name':'Schedule'}"));
            cols.Add(JObject.Parse("{ 'data':'SourceSystem.SystemName', 'name':'Source' }"));
            cols.Add(JObject.Parse("{ 'data':'TargetSystem.SystemName', 'name':'Target' }"));
            cols.Add(JObject.Parse("{ 'data':'TaskDatafactoryIr', 'name':'Data Factory IR'}"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'ActiveYn', 'autoWidth':true, 'ads_format': 'bool' }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskMasterId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskInstance/IndexDataTable?TaskMasterId=','Description':'View Task Instances', 'Icon':'list-alt','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskMasterWaterMark/IndexDataTable?TaskMasterId=','Description':'View Water Mark', 'Icon':'water','ButtonClass':'btn-primary'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskMaster";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["AutoWidth"] = false;
            GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,EditPlus,Details,Delete");

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
                var modelDataAll = (from temptable in _context.TaskMaster
                                    select temptable);

                //filter the list by permitted roles
                if (!CanPerformCurrentActionGlobally())
                {
                    var permittedRoles = GetPermittedGroupsForCurrentAction();
                    var identity = User.Identity.Name;

                    modelDataAll =
                        (from md in modelDataAll
                         join tg in _context.TaskGroup
                            on md.TaskGroupId equals tg.TaskGroupId
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
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.TaskMasterName.Contains(searchValue));
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskTypeId]"])))
                {
                    var tasktypefilter = System.Convert.ToInt64(Request.Form["QueryParams[TaskTypeId]"]);
                    modelDataAll = modelDataAll.Where(t => t.TaskTypeId == tasktypefilter);
                }

                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskGroupId]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[TaskGroupId]"]);
                    modelDataAll = modelDataAll.Where(t => t.TaskGroupId == filter);
                }

                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[ScheduleMasterId]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[ScheduleMasterId]"]);
                    modelDataAll = modelDataAll.Where(t => t.ScheduleMasterId == filter);
                }

                //Custom Includes
                modelDataAll = modelDataAll
                    .Include(t => t.TaskGroup)
                    .Include(t => t.ScheduleMaster)
                    .Include(t => t.SourceSystem)
                    .Include(t => t.TargetSystem)
                    .Include(t => t.TaskType).AsNoTracking();


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


        [ChecksUserAccess]
        public async Task<IActionResult> CopyTaskMaster()
        {
            List<Int64> Pkeys = JsonConvert.DeserializeObject<List<Int64>>(Request.Form["Pkeys"]);
            var entitys = await _context.TaskMaster.Where(ti => Pkeys.Contains(ti.TaskMasterId)).AsNoTracking().ToArrayAsync();

            foreach (var tm in entitys)
            {
                if (!await CanPerformCurrentActionOnRecord(tm))
                    return Forbid();

                tm.TaskMasterId = 0;
                tm.TaskMasterName = tm.TaskMasterName + " Copy";
                _context.Add(tm);
            }
            await _context.SaveChangesAsync();

            //TODO: Add Error Handling
            return new OkObjectResult(new { });
        }

        [ChecksUserAccess]
        public async Task<IActionResult> UpdateTaskMasterActiveYN()
        {
            List<Int64> Pkeys = JsonConvert.DeserializeObject<List<Int64>>(Request.Form["Pkeys"]);
            bool Status = JsonConvert.DeserializeObject<bool>(Request.Form["Status"]);
            var entitys = await _context.TaskMaster.Where(ti => Pkeys.Contains(ti.TaskMasterId)).ToArrayAsync();

            foreach (var ti in entitys)
            {
                if (!await CanPerformCurrentActionOnRecord(ti))
                    return Forbid();

                ti.ActiveYn = Status;
            }
            await _context.SaveChangesAsync();

            //TODO: Add Error Handling
            return new OkObjectResult(new { });
        }

        [ChecksUserAccess]
        public async Task<IActionResult> EditPlus(long? id)
        {
            
            if (id == null)
            {
                return NotFound();
            }

            var taskMaster = await _context.TaskMaster.FindAsync(id);

            if (taskMaster == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskMaster))
                return Forbid();

            ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x => x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskMaster.TaskGroupId);
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType, "TaskTypeId", "TaskTypeName", taskMaster.TaskTypeId);
            ViewData["SourceSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(t => t.SystemName), "SystemId", "SystemName", taskMaster.SourceSystemId);
            ViewData["TargetSystemId"] = new SelectList(_context.SourceAndTargetSystems.OrderBy(t => t.SystemName), "SystemId", "SystemName", taskMaster.TargetSystemId);
            ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(t => t.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", taskMaster.ScheduleMasterId);
            ViewData["DataFactoryId"] = new SelectList(_context.DataFactory.OrderBy(x => x.Name), "Id", "Name");
            ViewBag.returnUrl = Request.Headers["Referer"].ToString();
            return View(taskMaster);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> EditPlus(long id, string returnUrl, [Bind("TaskMasterId,TaskMasterName,TaskTypeId,TaskGroupId,ScheduleMasterId,SourceSystemId,TargetSystemId,DegreeOfCopyParallelism,AllowMultipleActiveInstances,TaskDatafactoryIr,TaskMasterJson,ActiveYn,DependencyChainTag,DataFactoryId")] TaskMaster taskMaster)
        {
            if (id != taskMaster.TaskMasterId)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskMaster))
                return Forbid();

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskMaster);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskMasterExists(taskMaster.TaskMasterId))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                
                return Redirect(returnUrl);
            }
            ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster, "ScheduleMasterId", "ScheduleCronExpression", taskMaster.ScheduleMasterId);
            ViewData["SourceSystemId"] = new SelectList(_context.SourceAndTargetSystems, "SystemId", "SystemAuthType", taskMaster.SourceSystemId);
            ViewData["TargetSystemId"] = new SelectList(_context.SourceAndTargetSystems, "SystemId", "SystemAuthType", taskMaster.TargetSystemId);
            ViewData["TaskGroupId"] = new SelectList(_context.TaskGroup, "TaskGroupId", "TaskGroupName", taskMaster.TaskGroupId);
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType, "TaskTypeId", "TaskTypeName", taskMaster.TaskTypeId);
            ViewData["DataFactoryId"] = new SelectList(_context.DataFactory.OrderBy(x => x.Name), "Id", "Name");
            return View(taskMaster);
        }
    }
}
