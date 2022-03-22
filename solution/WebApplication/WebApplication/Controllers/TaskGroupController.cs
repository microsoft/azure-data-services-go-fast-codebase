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
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System.Web;
using System.Collections.Specialized;

namespace WebApplication.Controllers
{
    public partial class TaskGroupController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public TaskGroupController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "TaskGroup";
            _context = context;
        }

        // GET: TaskGroup
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.TaskGroup.Include(t => t.SubjectArea);
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: TaskGroup/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskGroup = await _context.TaskGroup
                .Include(t => t.SubjectArea)
                .FirstOrDefaultAsync(m => m.TaskGroupId == id);
            if (taskGroup == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(taskGroup))
                return new ForbidResult();


            return View(taskGroup);
        }

        // GET: TaskGroup/Create
        public IActionResult Create()
        {
            NameValueCollection QueryParams = HttpUtility.ParseQueryString(new Uri(Request.Headers["Referer"]).Query);
            if(QueryParams["SubjectAreaId"] != null)
            {
                ViewData["selectedSubjectAreaId"] = int.Parse(QueryParams["SubjectAreaId"]);
            }

            ViewData["SubjectAreaId"] = new SelectList(_context.SubjectArea.OrderBy(x => x.SubjectAreaId), "SubjectAreaId", "SubjectAreaName");
            ViewBag.returnUrl = Request.Headers["Referer"].ToString();
            TaskGroup taskGroup = new TaskGroup();
            taskGroup.ActiveYn = true;
            return View(taskGroup);
        }

        // POST: TaskGroup/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create(string returnUrl, [Bind("TaskGroupId,TaskGroupName,TaskGroupPriority,TaskGroupConcurrency,TaskGroupJson,SubjectAreaId,ActiveYn")] TaskGroup taskGroup)
        {
            if (ModelState.IsValid)
            {
                _context.Add(taskGroup);
                if (!await CanPerformCurrentActionOnRecord(taskGroup))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return Redirect(returnUrl);
            }
            ViewData["SubjectAreaId"] = new SelectList(_context.SubjectArea.OrderBy(x=>x.SubjectAreaId), "SubjectAreaId", "SubjectAreaId", taskGroup.SubjectAreaId);
            return View(taskGroup);
        }

        // GET: TaskGroup/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskGroup = await _context.TaskGroup.FindAsync(id);
            if (taskGroup == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(taskGroup))
                return new ForbidResult();
            ViewData["SubjectAreaId"] = new SelectList(_context.SubjectArea.OrderBy(x=>x.SubjectAreaId), "SubjectAreaId", "SubjectAreaId", taskGroup.SubjectAreaId);
            ViewBag.returnUrl = Request.Headers["Referer"].ToString();
            return View(taskGroup);
        }

        // POST: TaskGroup/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, string returnUrl, [Bind("TaskGroupId,TaskGroupName,TaskGroupPriority,TaskGroupConcurrency,TaskGroupJson,SubjectAreaId,ActiveYn")] TaskGroup taskGroup)
        {
            if (id != taskGroup.TaskGroupId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(taskGroup);

                    if (!await CanPerformCurrentActionOnRecord(taskGroup))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!TaskGroupExists(taskGroup.TaskGroupId))
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
            ViewData["SubjectAreaId"] = new SelectList(_context.SubjectArea.OrderBy(x=>x.SubjectAreaId), "SubjectAreaId", "SubjectAreaId", taskGroup.SubjectAreaId);
            return View(taskGroup);
        }

        // GET: TaskGroup/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskGroup = await _context.TaskGroup
                .Include(t => t.SubjectArea)
                .FirstOrDefaultAsync(m => m.TaskGroupId == id);
            if (taskGroup == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(taskGroup))
                return new ForbidResult();

            return View(taskGroup);
        }

        // POST: TaskGroup/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var taskGroup = await _context.TaskGroup.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(taskGroup))
                return new ForbidResult();
		
            _context.TaskGroup.Remove(taskGroup);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool TaskGroupExists(long id)
        {
            return _context.TaskGroup.Any(e => e.TaskGroupId == id);
        }

        [ChecksUserAccess]
        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.TaskGroup.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'TaskGroupId', 'name':'Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskGroupName', 'name':'Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SubjectArea.SubjectAreaName', 'name':'Subject Area', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskGroupPriority', 'name':'Priority', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskGroupConcurrency', 'name':'Concurrency', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'TaskGroupJson', 'name':'Configuration Json', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'Is Active', 'autoWidth':true, 'ads_format':'bool'}"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("TaskGroupId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskMaster/IndexDataTable?TaskGroupId=','Description':'View Task Masters', 'Icon':'list','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskGroupDependency/IndexDataTable?TaskGroupId=','Description':'View Dependencies', 'Icon':'indent','ButtonClass':'btn-primary'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "TaskGroup";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,Edit,Details,Delete");

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
                var modelDataAll = (from temptable in _context.TaskGroup
                                    select temptable);

                //filter the list by permitted roles
                if (!CanPerformCurrentActionGlobally())
                {
                    var permittedRoles = GetPermittedGroupsForCurrentAction();
                    var identity = User.Identity.Name;

                    modelDataAll =
                        (from md in modelDataAll
                         join rm in _context.SubjectAreaRoleMap
                            on md.SubjectAreaId equals rm.SubjectAreaId
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
                    modelDataAll = modelDataAll.Where(m => m.TaskGroupName == searchValue);
                }

                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[SubjectAreaId]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[SubjectAreaId]"]);
                    modelDataAll = modelDataAll.Where(t => t.SubjectAreaId == filter);
                }

                //Custom Includes
                modelDataAll = modelDataAll
                    .Include(t => t.SubjectArea)
                    .AsNoTracking();

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
