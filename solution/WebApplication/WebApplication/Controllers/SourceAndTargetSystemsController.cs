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
    public partial class SourceAndTargetSystemsController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public SourceAndTargetSystemsController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "SourceAndTargetSystems";
            _context = context;
        }

        // GET: SourceAndTargetSystems
        public async Task<IActionResult> Index()
        {
            return View(await _context.SourceAndTargetSystems.ToListAsync());
        }

        // GET: SourceAndTargetSystems/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sourceAndTargetSystems = await _context.SourceAndTargetSystems
                .FirstOrDefaultAsync(m => m.SystemId == id);
            if (sourceAndTargetSystems == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystems))
                return new ForbidResult();


            return View(sourceAndTargetSystems);
        }

        private List<SelectListItem> GenerateItems()
        {
            return new List<SelectListItem>()
            {
                new SelectListItem { Selected = true, Text = "MSI", Value = "MSI"},
                new SelectListItem { Selected = false, Text = "SQLAuth", Value = "SQLAuth"},
                new SelectListItem { Selected = false, Text = "Key", Value = "Key"},
                new SelectListItem { Selected = false, Text = "WindowsAuth", Value = "WindowsAuth"}
            };
        }

        // GET: SourceAndTargetSystems/Create
        public IActionResult Create()
        {
            SourceAndTargetSystems sourceAndTargetSystems = new SourceAndTargetSystems();
            ViewData["AuthType"] = GenerateItems();
            sourceAndTargetSystems.ActiveYn = true;
            return View(sourceAndTargetSystems);
        }

        // POST: SourceAndTargetSystems/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("SystemId,SystemName,SystemType,SystemDescription,SystemServer,SystemAuthType,SystemUserName,SystemSecretName,SystemKeyVaultBaseUrl,SystemJson,ActiveYn,IsExternal")] SourceAndTargetSystems sourceAndTargetSystems)
        {
            if (ModelState.IsValid)
            {
                _context.Add(sourceAndTargetSystems);
                if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystems))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(sourceAndTargetSystems);
        }

        // GET: SourceAndTargetSystems/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sourceAndTargetSystems = await _context.SourceAndTargetSystems.FindAsync(id);
            if (sourceAndTargetSystems == null)
                return NotFound();
            ViewData["AuthType"] = GenerateItems();
            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystems))
                return new ForbidResult();
            return View(sourceAndTargetSystems);
        }

        // POST: SourceAndTargetSystems/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, [Bind("SystemId,SystemName,SystemType,SystemDescription,SystemServer,SystemAuthType,SystemUserName,SystemSecretName,SystemKeyVaultBaseUrl,SystemJson,ActiveYn,IsExternal")] SourceAndTargetSystems sourceAndTargetSystems)
        {
            if (id != sourceAndTargetSystems.SystemId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(sourceAndTargetSystems);

                    if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystems))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SourceAndTargetSystemsExists(sourceAndTargetSystems.SystemId))
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
            return View(sourceAndTargetSystems);
        }

        // GET: SourceAndTargetSystems/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sourceAndTargetSystems = await _context.SourceAndTargetSystems
                .FirstOrDefaultAsync(m => m.SystemId == id);
            if (sourceAndTargetSystems == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystems))
                return new ForbidResult();

            return View(sourceAndTargetSystems);
        }

        // POST: SourceAndTargetSystems/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var sourceAndTargetSystems = await _context.SourceAndTargetSystems.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystems))
                return new ForbidResult();
		
            _context.SourceAndTargetSystems.Remove(sourceAndTargetSystems);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool SourceAndTargetSystemsExists(long id)
        {
            return _context.SourceAndTargetSystems.Any(e => e.SystemId == id);
        }

        public IActionResult IndexDataTable()
        {
            return View();
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'SystemId', 'name':'SystemId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SystemName', 'name':'SystemName', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SystemDescription', 'name':'SystemDescription', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SystemType', 'name':'SystemType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'ActiveYn', 'autoWidth':true, 'ads_format':'bool'}"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("SystemId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskMaster/IndexDataTable?TaskGroupId=','Description':'View Task Masters', 'Icon':'list','ButtonClass':'btn-primary'}"));

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "SourceAndTargetSystems";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["CrudController"] = "SourceAndTargetSystems";
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
                var modelDataAll = (from temptable in _context.SourceAndTargetSystems
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.SystemName == searchValue);
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
