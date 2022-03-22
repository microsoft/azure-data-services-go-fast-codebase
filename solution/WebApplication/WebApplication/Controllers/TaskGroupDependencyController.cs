using System;
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
    public partial class TaskGroupDependencyController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public TaskGroupDependencyController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "TaskGroupDependency";
            _context = context;
        }

        // GET: TaskGroupDependency
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.TaskGroupDependency.Include(t => t.AncestorTaskGroup).Include(t => t.DescendantTaskGroup);
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: TaskGroupDependency/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskGroupDependency = await _context.TaskGroupDependency
                .Include(t => t.AncestorTaskGroup)
                .Include(t => t.DescendantTaskGroup)
                .FirstOrDefaultAsync(m => m.AncestorTaskGroupId == id);
            if (taskGroupDependency == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(taskGroupDependency))
                return new ForbidResult();


            return View(taskGroupDependency);
        }

        // GET: TaskGroupDependency/Create
        public IActionResult Create()
        {
            ViewData["AncestorTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName");
            ViewData["DescendantTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName");
     TaskGroupDependency taskGroupDependency = new TaskGroupDependency();
            return View(taskGroupDependency);
        }

        // POST: TaskGroupDependency/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("AncestorTaskGroupId,DescendantTaskGroupId,DependencyType")] TaskGroupDependency taskGroupDependency)
        {
            if (ModelState.IsValid)
            {
                _context.Add(taskGroupDependency);
                if (!await CanPerformCurrentActionOnRecord(taskGroupDependency))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
        ViewData["AncestorTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskGroupDependency.AncestorTaskGroupId);
        ViewData["DescendantTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskGroupDependency.DescendantTaskGroupId);
            return View(taskGroupDependency);
        }

        // GET: TaskGroupDependency/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskGroupDependency = await _context.TaskGroupDependency.FindAsync(id);
            if (taskGroupDependency == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskGroupDependency))
                return new ForbidResult();
        ViewData["AncestorTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskGroupDependency.AncestorTaskGroupId);
        ViewData["DescendantTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskGroupDependency.DescendantTaskGroupId);
            return View(taskGroupDependency);
        }

        // POST: TaskGroupDependency/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, [Bind("AncestorTaskGroupId,DescendantTaskGroupId,DependencyType")] TaskGroupDependency taskGroupDependency)
        {
            if (id != taskGroupDependency.AncestorTaskGroupId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskGroupDependency);

                    if (!await CanPerformCurrentActionOnRecord(taskGroupDependency))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskGroupDependencyExists(taskGroupDependency.AncestorTaskGroupId))
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
        ViewData["AncestorTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskGroupDependency.AncestorTaskGroupId);
        ViewData["DescendantTaskGroupId"] = new SelectList(_context.TaskGroup.OrderBy(x=>x.TaskGroupName), "TaskGroupId", "TaskGroupName", taskGroupDependency.DescendantTaskGroupId);
            return View(taskGroupDependency);
        }

        // GET: TaskGroupDependency/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskGroupDependency = await _context.TaskGroupDependency
                .Include(t => t.AncestorTaskGroup)
                .Include(t => t.DescendantTaskGroup)
                .FirstOrDefaultAsync(m => m.AncestorTaskGroupId == id);
            if (taskGroupDependency == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(taskGroupDependency))
                return new ForbidResult();

            return View(taskGroupDependency);
        }

        // POST: TaskGroupDependency/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var taskGroupDependency = await _context.TaskGroupDependency.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(taskGroupDependency))
                return new ForbidResult();
		
            _context.TaskGroupDependency.Remove(taskGroupDependency);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool TaskGroupDependencyExists(long id)
        {
            return _context.TaskGroupDependency.Any(e => e.AncestorTaskGroupId == id);
        }

        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.TaskGroup.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'AncestorTaskGroup.TaskGroupName', 'name':'Ancestor Task Group', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DescendantTaskGroup.TaskGroupName', 'name':'Descendant Task Group', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DependencyType', 'name':'Dependency Type', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("AncestorTaskGroupId");
            pkeycols.Add("DescendantTaskGroupId");

            JArray Navigations = new JArray();


            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskGroup";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["UseCompositeKey"] = true;
            GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,EditPlus,DetailsPlus,DeletePlus");

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
                var modelDataAll = from dep in _context.TaskGroupDependency select dep;

                modelDataAll = modelDataAll
                    .Include(t => t.AncestorTaskGroup)
                    .Include(t => t.DescendantTaskGroup).AsNoTracking();

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.AncestorTaskGroup.TaskGroupName.Contains(searchValue)
                    || m.DescendantTaskGroup.TaskGroupName.Contains(searchValue));
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[TaskGroupId]"])))
                {
                    var taskGroupIdFilter = System.Convert.ToInt64(Request.Form["QueryParams[TaskGroupId]"]);
                    modelDataAll = modelDataAll.Where(t => t.AncestorTaskGroupId == taskGroupIdFilter || t.DescendantTaskGroupId == taskGroupIdFilter);
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

        // GET: TaskGroupDependency/Details/5
        public async Task<IActionResult> DetailsPlus([FromQuery] long AncestorTaskGroupId, [FromQuery] long DescendantTaskGroupId)
        {
            var taskGroupDependency = await _context.TaskGroupDependency
                .FirstOrDefaultAsync(m => m.AncestorTaskGroupId == AncestorTaskGroupId && m.DescendantTaskGroupId == DescendantTaskGroupId);
            if (taskGroupDependency == null)
            {
                return NotFound();
            }

            return View("Details", taskGroupDependency);
        }

        // GET: TaskGroupDependency/Edit/5
        public async Task<IActionResult> EditPlus([FromQuery] long AncestorTaskGroupId, [FromQuery] long DescendantTaskGroupId)
        {
            var taskGroupDependency = await _context.TaskGroupDependency.FindAsync(AncestorTaskGroupId, DescendantTaskGroupId);
            if (taskGroupDependency == null)
            {
                return NotFound();
            }
            return View("Edit", taskGroupDependency);
        }

        // POST: TaskGroupDependency/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> EditPlus([Bind("AncestorTaskGroupId,DescendantTaskGroupId,DependencyType")] TaskGroupDependency taskGroupDependency)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskGroupDependency);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskGroupDependencyExists(taskGroupDependency.AncestorTaskGroupId, taskGroupDependency.DescendantTaskGroupId))
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
            return View("Edit", taskGroupDependency);
        }

        // GET: TaskGroupDependency/Delete/5
        public async Task<IActionResult> DeletePlus([FromQuery] long AncestorTaskGroupId, [FromQuery] long DescendantTaskGroupId)
        {

            var taskGroupDependency = await _context.TaskGroupDependency
                .FirstOrDefaultAsync(m => m.AncestorTaskGroupId == AncestorTaskGroupId
                && m.DescendantTaskGroupId == DescendantTaskGroupId);
            if (taskGroupDependency == null)
            {
                return NotFound();
            }

            return View("Delete", taskGroupDependency);
        }

        // POST: TaskGroupDependency/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id, long dependentId)
        {
            var taskGroupDependency = await _context.TaskGroupDependency.FindAsync(id, dependentId);
            _context.TaskGroupDependency.Remove(taskGroupDependency);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool TaskGroupDependencyExists(long id, long dependentId)
        {
            return _context.TaskGroupDependency.Any(e => e.AncestorTaskGroupId == id && e.DescendantTaskGroupId == dependentId);
        }
    }
}
