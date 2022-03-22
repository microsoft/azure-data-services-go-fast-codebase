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
    public partial class TaskTypeMappingController : BaseController
    {
        protected readonly AdsGoFastContext _context;


        public TaskTypeMappingController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "TaskTypeMapping";
            _context = context;
        }

        // GET: TaskTypeMapping
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.TaskTypeMapping.Include(t => t.TaskType);
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: TaskTypeMapping/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskTypeMapping = await _context.TaskTypeMapping
                .Include(t => t.TaskType)
                .FirstOrDefaultAsync(m => m.TaskTypeMappingId == id);
            if (taskTypeMapping == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(taskTypeMapping))
                return new ForbidResult();


            return View(taskTypeMapping);
        }

        // GET: TaskTypeMapping/Create
        public IActionResult Create()
        {
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x => x.TaskTypeName), "TaskTypeId", "TaskTypeName");
            TaskTypeMapping taskTypeMapping = new TaskTypeMapping();
            taskTypeMapping.ActiveYn = true;
            return View(taskTypeMapping);
        }

        // POST: TaskTypeMapping/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("TaskTypeMappingId,TaskTypeId,MappingType,MappingName,SourceSystemType,SourceType,TargetSystemType,TargetType,TaskTypeJson,ActiveYn,TaskMasterJsonSchema,TaskInstanceJsonSchema")] TaskTypeMapping taskTypeMapping)
        {
            if (ModelState.IsValid)
            {
                _context.Add(taskTypeMapping);
                if (!await CanPerformCurrentActionOnRecord(taskTypeMapping))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x => x.TaskTypeName), "TaskTypeId", "TaskTypeName", taskTypeMapping.TaskTypeId);
            return View(taskTypeMapping);
        }

        // GET: TaskTypeMapping/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskTypeMapping = await _context.TaskTypeMapping.FindAsync(id);
            if (taskTypeMapping == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskTypeMapping))
                return new ForbidResult();
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x => x.TaskTypeName), "TaskTypeId", "TaskTypeName", taskTypeMapping.TaskTypeId);
            return View(taskTypeMapping);
        }

        // POST: TaskTypeMapping/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(int id, [Bind("TaskTypeMappingId,TaskTypeId,MappingType,MappingName,SourceSystemType,SourceType,TargetSystemType,TargetType,TaskTypeJson,ActiveYn,TaskMasterJsonSchema,TaskInstanceJsonSchema")] TaskTypeMapping taskTypeMapping)
        {
            if (id != taskTypeMapping.TaskTypeMappingId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskTypeMapping);

                    if (!await CanPerformCurrentActionOnRecord(taskTypeMapping))
                        return new ForbidResult();

                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskTypeMappingExists(taskTypeMapping.TaskTypeMappingId))
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
            ViewData["TaskTypeId"] = new SelectList(_context.TaskType.OrderBy(x => x.TaskTypeName), "TaskTypeId", "TaskTypeName", taskTypeMapping.TaskTypeId);
            return View(taskTypeMapping);
        }

        // GET: TaskTypeMapping/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskTypeMapping = await _context.TaskTypeMapping
                .Include(t => t.TaskType)
                .FirstOrDefaultAsync(m => m.TaskTypeMappingId == id);
            if (taskTypeMapping == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskTypeMapping))
                return new ForbidResult();

            return View(taskTypeMapping);
        }

        // POST: TaskTypeMapping/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var taskTypeMapping = await _context.TaskTypeMapping.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(taskTypeMapping))
                return new ForbidResult();

            _context.TaskTypeMapping.Remove(taskTypeMapping);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool TaskTypeMappingExists(int id)
        {
            return _context.TaskTypeMapping.Any(e => e.TaskTypeMappingId == id);
        }

        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.TaskTypeMapping.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'TaskTypeMappingId', 'name':'TaskTypeMappingId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskType.TaskTypeName', 'name':'TaskType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'MappingType', 'name':'MappingType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'MappingName', 'name':'MappingName', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SourceSystemType', 'name':'SourceSystemType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TargetSystemType', 'name':'TargetSystemType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SourceType', 'name':'TaskMasterJsonSourceType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TargetType', 'name':'TaskMasterJsonTargetType', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskTypeMappingId");

            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskTypeMapping";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
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

                // Getting all Customer data    
                var modelDataAll = (from temptable in _context.TaskTypeMapping
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    //TODO: Implement search
                    //modelDataAll = modelDataAll.Where(m => m.TaskMasterName.Contains(searchValue));
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskTypeId]"])))
                {
                    var tasktypefilter = System.Convert.ToInt64(Request.Form["QueryParams[TaskTypeId]"]);
                    modelDataAll = modelDataAll.Where(t => t.TaskTypeId == tasktypefilter);
                }

                //Custom Includes
                modelDataAll = modelDataAll
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

        public async Task<IActionResult> FindMapping()
        {


            Int64 TaskTypeId = System.Convert.ToInt64(Request.Form["TaskTypeId"]);


            List<TaskTypeMapping> taskTypeMappings = new List<TaskTypeMapping>();

            if (Request.Form.ContainsKey("SourceSystemId"))
            {
                Int64 SourceSystemId = System.Convert.ToInt64(Request.Form["SourceSystemId"]);
                SourceAndTargetSystems SourceSystem = _context.SourceAndTargetSystems.FirstOrDefault(m => m.SystemId == SourceSystemId);
                if (Request.Form.ContainsKey("TargetSystemId")) //We Have Both Source And Target Systems
                {
                    JObject TaskJsonObject = JObject.Parse(Request.Form["TaskMasterJson"]);
                    Int64 TargetSystemId = System.Convert.ToInt64(Request.Form["TargetSystemId"]);
                    SourceAndTargetSystems TargetSystem = _context.SourceAndTargetSystems.FirstOrDefault(m => m.SystemId == TargetSystemId);

                    string TaskMasterJsonSource = TaskJsonObject["Source"].ToString();
                    string TaskMasterJsonTarget = TaskJsonObject["Target"].ToString();
                    string TaskMasterJsonSourceType = "*";
                    string TaskMasterJsonTargetType = "*";

                    if (TaskMasterJsonSource != null && TaskMasterJsonSource != "")
                    {
                        TaskMasterJsonSourceType = JObject.Parse(TaskMasterJsonSource)["Type"].ToString();
                    }

                    if (TaskMasterJsonTarget != null || TaskMasterJsonTarget != "")
                    {
                        TaskMasterJsonTargetType = JObject.Parse(TaskMasterJsonTarget)["Type"].ToString();
                    }

                    taskTypeMappings = await _context.TaskTypeMapping
                        .Where(m => m.TaskTypeId == TaskTypeId
                            && m.SourceSystemType == SourceSystem.SystemType
                            && m.TargetSystemType == TargetSystem.SystemType
                            && m.SourceType == TaskMasterJsonSourceType
                            && m.TargetType == TaskMasterJsonTargetType
                            ).ToListAsync();
                    goto RetVal;
                }
                else //We Only Have Source System And Dont Have Target
                {
                    taskTypeMappings = await _context.TaskTypeMapping
                    .Where(m => m.TaskTypeId == TaskTypeId
                        && m.SourceSystemType == SourceSystem.SystemType
                        ).ToListAsync();
                    goto RetVal;
                }
            }
            else
            {
                if (Request.Form.ContainsKey("TargetSystemId")) //We Only have Target System
                {
                    Int64 TargetSystemId = System.Convert.ToInt64(Request.Form["TargetSystemId"]);
                    SourceAndTargetSystems TargetSystem = _context.SourceAndTargetSystems.FirstOrDefault(m => m.SystemId == TargetSystemId);
                    taskTypeMappings = await _context.TaskTypeMapping
                    .Where(m => m.TaskTypeId == TaskTypeId
                        && m.TargetSystemType == TargetSystem.SystemType
                        ).ToListAsync();
                    goto RetVal;
                }
                else
                {
                    taskTypeMappings = await _context.TaskTypeMapping
                    .Where(m => m.TaskTypeId == TaskTypeId
                        ).ToListAsync();
                    goto RetVal;

                }
            }


        RetVal:
            if (taskTypeMappings.Count == 0)
            {
                return NotFound("Task Type Mappings do not exist for this current Task Type");
            }

            var SourceTypes = taskTypeMappings.Select(d => d.SourceSystemType).Distinct();
            var TargetTypes = taskTypeMappings.Select(d => d.TargetSystemType).Distinct();

            var ValidSourceSystems = _context.SourceAndTargetSystems.Where(s => SourceTypes.Contains(s.SystemType));
            var ValidTargetSystems = _context.SourceAndTargetSystems.Where(s => TargetTypes.Contains(s.SystemType));

            return new OkObjectResult(JsonConvert.SerializeObject(new { ValidSourceSystems = ValidSourceSystems, ValidTargetSystems = ValidTargetSystems, TaskTypeMappings = taskTypeMappings }));
        }
        public async Task<ActionResult> BulkUpdateTaskTypeMappingTaskMasterJsonSchema()
        {
            List<Int64> Pkeys = JsonConvert.DeserializeObject<List<Int64>>(Request.Form["Pkeys"]);
            string Json = Request.Form["Json"];
            var entitys = _context.TaskTypeMapping.Where(ti => Pkeys.Contains(ti.TaskTypeMappingId));

            entitys.ForEachAsync(ti =>
            {
                ti.TaskMasterJsonSchema = Json;
            }).Wait();

            await _context.SaveChangesAsync();

            return new OkObjectResult(new { });
        }
    }
}
