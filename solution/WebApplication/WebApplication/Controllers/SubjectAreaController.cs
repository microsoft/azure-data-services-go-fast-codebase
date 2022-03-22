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
    public partial class SubjectAreaController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public SubjectAreaController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "SubjectArea";
            _context = context;
        }

        // GET: SubjectArea
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.SubjectArea.Include(s => s.SubjectAreaForm);
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: SubjectArea/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectArea = await _context.SubjectArea
                .Include(s => s.SubjectAreaForm)
                .FirstOrDefaultAsync(m => m.SubjectAreaId == id);
            if (subjectArea == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(subjectArea))
                return new ForbidResult();


            return View(subjectArea);
        }

        // GET: SubjectArea/Create
        public IActionResult Create()
        {
            ViewData["SubjectAreaFormId"] = new SelectList(_context.SubjectAreaForm.OrderBy(x=>x.SubjectAreaFormId), "SubjectAreaFormId", "SubjectAreaFormId");
            SubjectArea subjectArea = new SubjectArea();
            subjectArea.ActiveYn = true;
            return View(subjectArea);
        }

        // POST: SubjectArea/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("SubjectAreaId,SubjectAreaName,ActiveYn,SubjectAreaFormId,DefaultTargetSchema,UpdatedBy")] SubjectArea subjectArea)
        {
            if (ModelState.IsValid)
            {
                subjectArea.UpdatedBy = User.Identity.Name;
                _context.Add(subjectArea);
                if (!await CanPerformCurrentActionOnRecord(subjectArea))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            ViewData["SubjectAreaFormId"] = new SelectList(_context.SubjectAreaForm.OrderBy(x=>x.SubjectAreaFormId), "SubjectAreaFormId", "SubjectAreaFormId", subjectArea.SubjectAreaFormId);
            return View(subjectArea);
        }

        // GET: SubjectArea/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectArea = await _context.SubjectArea.FindAsync(id);
            if (subjectArea == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(subjectArea))
                return new ForbidResult();
            ViewData["SubjectAreaFormId"] = new SelectList(_context.SubjectAreaForm.OrderBy(x=>x.SubjectAreaFormId), "SubjectAreaFormId", "SubjectAreaFormId", subjectArea.SubjectAreaFormId);
            return View(subjectArea);
        }

        // POST: SubjectArea/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(int id, [Bind("SubjectAreaId,SubjectAreaName,ActiveYn,SubjectAreaFormId,DefaultTargetSchema,UpdatedBy")] SubjectArea subjectArea)
        {
            if (id != subjectArea.SubjectAreaId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    subjectArea.UpdatedBy = User.Identity.Name;
                    _context.Update(subjectArea);

                    if (!await CanPerformCurrentActionOnRecord(subjectArea))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SubjectAreaExists(subjectArea.SubjectAreaId))
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
        ViewData["SubjectAreaFormId"] = new SelectList(_context.SubjectAreaForm.OrderBy(x=>x.SubjectAreaFormId), "SubjectAreaFormId", "SubjectAreaFormId", subjectArea.SubjectAreaFormId);
            return View(subjectArea);
        }

        // GET: SubjectArea/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectArea = await _context.SubjectArea
                .Include(s => s.SubjectAreaForm)
                .FirstOrDefaultAsync(m => m.SubjectAreaId == id);
            if (subjectArea == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(subjectArea))
                return new ForbidResult();

            return View(subjectArea);
        }

        // POST: SubjectArea/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var subjectArea = await _context.SubjectArea.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(subjectArea))
                return new ForbidResult();
		
            _context.SubjectArea.Remove(subjectArea);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool SubjectAreaExists(int id)
        {
            return _context.SubjectArea.Any(e => e.SubjectAreaId == id);
        }

        [ChecksUserAccess]
        public IActionResult IndexDataTable()
        {
            return View();
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'SubjectAreaId', 'name':'Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SubjectAreaName', 'name':'Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SubjectAreaFormId', 'name':'Form', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DefaultTargetSchema', 'name':'Default Target Schema', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'UpdatedBy', 'name':'Updated By', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'Is Active', 'autoWidth':true, 'ads_format':'bool'}"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("SubjectAreaId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'View Task Groups', 'Icon':'object-group','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'View System Mappings', 'Icon':'bullseye','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'View Role Mappings', 'Icon':'user-tag','ButtonClass':'btn-primary'}"));
            Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'Auto Create Target Schema & AD Groups', 'Icon':'cogs','ButtonClass':'btn-danger'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "SubjectArea";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            //GridOptions["CrudButtons"] = GetSecurityFilteredActions("Create,Edit,Details,Delete");
            GridOptions["CrudButtons"] = new JArray("Create", "Edit", "Details", "Delete");

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
                var modelDataAll = (from temptable in _context.SubjectArea
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
                    modelDataAll = modelDataAll.Where(m => m.SubjectAreaName == searchValue);
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
