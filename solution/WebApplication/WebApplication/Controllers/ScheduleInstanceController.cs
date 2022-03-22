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

namespace WebApplication.Controllers
{
    public partial class ScheduleInstanceController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public ScheduleInstanceController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "ScheduleInstance";
            _context = context;
        }

        // GET: ScheduleInstance
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.ScheduleInstance.Include(s => s.ScheduleMaster);
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: ScheduleInstance/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var scheduleInstance = await _context.ScheduleInstance
                .Include(s => s.ScheduleMaster)
                .FirstOrDefaultAsync(m => m.ScheduleInstanceId == id);
            if (scheduleInstance == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(scheduleInstance))
                return new ForbidResult();


            return View(scheduleInstance);
        }

        // GET: ScheduleInstance/Create
        public IActionResult Create()
        {
            ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption");
     ScheduleInstance scheduleInstance = new ScheduleInstance();
            scheduleInstance.ActiveYn = true;
            return View(scheduleInstance);
        }

        // POST: ScheduleInstance/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("ScheduleInstanceId,ScheduleMasterId,ScheduledDateUtc,ScheduledDateTimeOffset,ActiveYn")] ScheduleInstance scheduleInstance)
        {
            if (ModelState.IsValid)
            {
                _context.Add(scheduleInstance);
                if (!await CanPerformCurrentActionOnRecord(scheduleInstance))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
        ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", scheduleInstance.ScheduleMasterId);
            return View(scheduleInstance);
        }

        // GET: ScheduleInstance/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var scheduleInstance = await _context.ScheduleInstance.FindAsync(id);
            if (scheduleInstance == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(scheduleInstance))
                return new ForbidResult();
        ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", scheduleInstance.ScheduleMasterId);
            return View(scheduleInstance);
        }

        // POST: ScheduleInstance/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, [Bind("ScheduleInstanceId,ScheduleMasterId,ScheduledDateUtc,ScheduledDateTimeOffset,ActiveYn")] ScheduleInstance scheduleInstance)
        {
            if (id != scheduleInstance.ScheduleInstanceId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(scheduleInstance);

                    if (!await CanPerformCurrentActionOnRecord(scheduleInstance))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ScheduleInstanceExists(scheduleInstance.ScheduleInstanceId))
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
        ViewData["ScheduleMasterId"] = new SelectList(_context.ScheduleMaster.OrderBy(x=>x.ScheduleDesciption), "ScheduleMasterId", "ScheduleDesciption", scheduleInstance.ScheduleMasterId);
            return View(scheduleInstance);
        }

        // GET: ScheduleInstance/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var scheduleInstance = await _context.ScheduleInstance
                .Include(s => s.ScheduleMaster)
                .FirstOrDefaultAsync(m => m.ScheduleInstanceId == id);
            if (scheduleInstance == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(scheduleInstance))
                return new ForbidResult();

            return View(scheduleInstance);
        }

        // POST: ScheduleInstance/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var scheduleInstance = await _context.ScheduleInstance.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(scheduleInstance))
                return new ForbidResult();
		
            _context.ScheduleInstance.Remove(scheduleInstance);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool ScheduleInstanceExists(long id)
        {
            return _context.ScheduleInstance.Any(e => e.ScheduleInstanceId == id);
        }

        [ChecksUserAccess]
        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.ScheduleInstance.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'ScheduleInstanceId', 'name':'ScheduleInstanceId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ScheduleMaster.ScheduleDesciption', 'name':'ScheduleMaster', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ScheduledDateTimeOffset', 'name':'ScheduledDateTime', 'autoWidth':true, 'ads_format': 'datetime' }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'ActiveYn', 'autoWidth':true, 'ads_format': 'bool' }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("ScheduleInstanceId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskInstance/IndexDataTable?ScheduleInstanceId=','Description':'View Task Instances'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "ScheduleInstance";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["SuppressCrudButtons"] = true;
            GridOptions["InitialOrder"] = JArray.Parse("[[2,'desc']]");

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
                var modelDataAll = (from temptable in _context.ScheduleInstance
                                    select temptable);

                //filter the list by permitted roles
                if (!CanPerformCurrentActionGlobally())
                {
                    var permittedRoles = GetPermittedGroupsForCurrentAction();
                    var identity = User.Identity.Name;

                    modelDataAll =
                        (from md in modelDataAll
                         join ti in _context.TaskInstance
                            on md.ScheduleInstanceId equals ti.ScheduleInstanceId
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


                //Filter based on querystring params
                if (!(string.IsNullOrEmpty(Request.Form["QueryParams[ScheduleMasterId]"])))
                {
                    var filter = System.Convert.ToInt64(Request.Form["QueryParams[ScheduleMasterId]"]);
                    modelDataAll = modelDataAll.Where(t => t.ScheduleMasterId == filter);
                }


                //Custom Includes
                modelDataAll = modelDataAll
                    .Include(t => t.ScheduleMaster).AsNoTracking();

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
