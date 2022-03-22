using System;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication.Services;
using WebApplication.Framework;
using WebApplication.Models;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;

namespace WebApplication.Controllers
{
    public partial class TaskTypeController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public TaskTypeController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "TaskType";
            _context = context;
        }

        // GET: TaskType
        public async Task<IActionResult> Index()
        {
            return View(await _context.TaskType.ToListAsync());
        }

        // GET: TaskType/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskType = await _context.TaskType
                .FirstOrDefaultAsync(m => m.TaskTypeId == id);
            if (taskType == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(taskType))
                return new ForbidResult();


            return View(taskType);
        }

        // GET: TaskType/Create
        public IActionResult Create()
        {
     TaskType taskType = new TaskType();
            taskType.ActiveYn = true;
            return View(taskType);
        }

        // POST: TaskType/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("TaskExecutionType,TaskTypeId,TaskTypeName,TaskTypeJson,ActiveYn")] TaskType taskType)
        {
            if (ModelState.IsValid)
            {
                _context.Add(taskType);
                if (!await CanPerformCurrentActionOnRecord(taskType))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(taskType);
        }

        // GET: TaskType/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskType = await _context.TaskType.FindAsync(id);
            if (taskType == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskType))
                return new ForbidResult();
            return View(taskType);
        }

        // POST: TaskType/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(int id, [Bind("TaskExecutionType,TaskTypeId,TaskTypeName,TaskTypeJson,ActiveYn")] TaskType taskType)
        {
            if (id != taskType.TaskTypeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskType);

                    if (!await CanPerformCurrentActionOnRecord(taskType))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskTypeExists(taskType.TaskTypeId))
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
            return View(taskType);
        }

        // GET: TaskType/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskType = await _context.TaskType
                .FirstOrDefaultAsync(m => m.TaskTypeId == id);
            if (taskType == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(taskType))
                return new ForbidResult();

            return View(taskType);
        }

        // POST: TaskType/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var taskType = await _context.TaskType.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(taskType))
                return new ForbidResult();
		
            _context.TaskType.Remove(taskType);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool TaskTypeExists(int id)
        {
            return _context.TaskType.Any(e => e.TaskTypeId == id);
        }

        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.TaskType.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'TaskTypeId', 'name':'Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskTypeName', 'name':'Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskTypeJson', 'name':'TaskTypeJson', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskExecutionType', 'name':'Task Execution Type', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'Is Active', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskTypeId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskMaster/IndexDataTable?TaskTypeId=','Description':'View Task Masters', 'Icon':'list-alt','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskTypeMapping/IndexDataTable?TaskTypeId=','Description':'View Task Type Mappings', 'Icon':'map-marked-alt','ButtonClass':'btn-primary'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskType";
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
                var modelDataAll = (from temptable in _context.TaskType
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.TaskTypeName == searchValue);
                }

                //total number of rows count     
                recordsTotal = await modelDataAll.CountAsync();
                //Paging     
                var data = await modelDataAll.Skip(skip).Take(pageSize).ToListAsync();
                //Returning Json Data    
                return new OkObjectResult(JsonConvert.SerializeObject(new { draw = draw, recordsFiltered = recordsTotal, recordsTotal = recordsTotal, data = data }, new Newtonsoft.Json.Converters.StringEnumConverter()));

            }
            catch (Exception)
            {
                throw;
            }

        }
    }
}
