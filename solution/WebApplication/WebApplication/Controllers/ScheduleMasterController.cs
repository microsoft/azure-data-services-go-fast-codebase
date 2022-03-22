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
using System.Data;

namespace WebApplication.Controllers
{
    public partial class ScheduleMasterController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public ScheduleMasterController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "ScheduleMaster";
            _context = context;
        }

        // GET: ScheduleMaster
        public async Task<IActionResult> Index()
        {
            return View(await _context.ScheduleMaster.ToListAsync());
        }

        // GET: ScheduleMaster/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var scheduleMaster = await _context.ScheduleMaster
                .FirstOrDefaultAsync(m => m.ScheduleMasterId == id);
            if (scheduleMaster == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(scheduleMaster))
                return new ForbidResult();


            return View(scheduleMaster);
        }

        // GET: ScheduleMaster/Create
        public IActionResult Create()
        {
     ScheduleMaster scheduleMaster = new ScheduleMaster();
            scheduleMaster.ActiveYn = true;
            return View(scheduleMaster);
        }

        // POST: ScheduleMaster/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("ScheduleMasterId,ScheduleDesciption,ScheduleCronExpression,ActiveYn")] ScheduleMaster scheduleMaster)
        {
            if (ModelState.IsValid)
            {
                _context.Add(scheduleMaster);
                if (!await CanPerformCurrentActionOnRecord(scheduleMaster))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(scheduleMaster);
        }

        // GET: ScheduleMaster/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var scheduleMaster = await _context.ScheduleMaster.FindAsync(id);
            if (scheduleMaster == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(scheduleMaster))
                return new ForbidResult();
            return View(scheduleMaster);
        }

        // POST: ScheduleMaster/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, [Bind("ScheduleMasterId,ScheduleDesciption,ScheduleCronExpression,ActiveYn")] ScheduleMaster scheduleMaster)
        {
            if (id != scheduleMaster.ScheduleMasterId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(scheduleMaster);

                    if (!await CanPerformCurrentActionOnRecord(scheduleMaster))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ScheduleMasterExists(scheduleMaster.ScheduleMasterId))
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
            return View(scheduleMaster);
        }

        // GET: ScheduleMaster/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var scheduleMaster = await _context.ScheduleMaster
                .FirstOrDefaultAsync(m => m.ScheduleMasterId == id);
            if (scheduleMaster == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(scheduleMaster))
                return new ForbidResult();

            return View(scheduleMaster);
        }

        // POST: ScheduleMaster/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var scheduleMaster = await _context.ScheduleMaster.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(scheduleMaster))
                return new ForbidResult();
		
            _context.ScheduleMaster.Remove(scheduleMaster);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool ScheduleMasterExists(long id)
        {
            return _context.ScheduleMaster.Any(e => e.ScheduleMasterId == id);
        }

        public async Task<IActionResult> IndexDataTable()
        {
            var adsGoFastContext = _context.ScheduleMaster.Take(1);
            return View(await adsGoFastContext.ToListAsync());
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'ScheduleMasterId', 'name':'ScheduleMasterId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ScheduleDesciption', 'name':'ScheduleDesciption', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ScheduleCronExpression', 'name':'ScheduleCronExpression', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'ActiveYn', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("ScheduleMasterId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/ScheduleInstance/IndexDataTable?ScheduleMasterId=','Description':'View Schedule Instances','Icon':'calendar-day','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskMaster/IndexDataTable?ScheduleMasterId=','Description':'View Task Masters', 'Icon':'list-alt','ButtonClass':'btn-primary'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "ScheduleMaster";
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
                var modelDataAll = (from temptable in _context.ScheduleMaster
                                    select temptable);


                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
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
