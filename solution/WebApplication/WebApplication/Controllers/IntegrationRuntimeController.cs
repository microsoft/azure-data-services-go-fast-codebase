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
    public partial class IntegrationRuntimeController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public IntegrationRuntimeController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "IntegrationRuntime";
            _context = context;
        }

        // GET: IntegrationRuntime
        public async Task<IActionResult> Index()
        {
            var adsGoFastContext = _context.IntegrationRuntime;
            return View(await adsGoFastContext.ToListAsync());
        }

        // GET: IntegrationRuntime/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var ir = await _context.IntegrationRuntime
                .Include(x=>x.ExecutionEngine)
                .FirstOrDefaultAsync(m => m.IntegrationRuntimeId == id);
            if (ir == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(ir))
                return new ForbidResult();


            return View(ir);
        }

        // GET: IntegrationRuntime/Create
        public IActionResult Create()
        {
            ViewData["ExecutionEngines"] = new SelectList(_context.ExecutionEngine.OrderBy(x=>x.EngineName), "EngineId", "EngineName");
            IntegrationRuntime ir = new IntegrationRuntime();
            ir.ActiveYn = true;
            return View(ir);
        }

        // POST: IntegrationRuntime/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("IntegrationRuntimeId,IntegrationRuntimeName,ActiveYn,EngineId")] IntegrationRuntime ir)
        {
            if (ModelState.IsValid)
            {
                _context.Add(ir);
                if (!await CanPerformCurrentActionOnRecord(ir))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            ViewData["ExecutionEngines"] = new SelectList(_context.ExecutionEngine.OrderBy(x => x.EngineName), "EngineId", "EngineName");
            return View(ir);
        }

        // GET: IntegrationRuntime/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var IntegrationRuntime = await _context.IntegrationRuntime.FindAsync(id);
            if (IntegrationRuntime == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(IntegrationRuntime))
                return new ForbidResult();
            ViewData["ExecutionEngines"] = new SelectList(_context.ExecutionEngine.OrderBy(x => x.EngineName), "EngineId", "EngineName");
            return View(IntegrationRuntime);
        }

        // POST: IntegrationRuntime/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(int id, [Bind("IntegrationRuntimeId,IntegrationRuntimeName,ActiveYn,EngineId")] IntegrationRuntime integrationRuntime)
        {
            if (id != integrationRuntime.IntegrationRuntimeId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(integrationRuntime);

                    if (!await CanPerformCurrentActionOnRecord(integrationRuntime))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!IntegrationRuntimeExists(integrationRuntime.IntegrationRuntimeId))
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
            ViewData["ExecutionEngines"] = new SelectList(_context.ExecutionEngine.OrderBy(x => x.EngineName), "EngineId", "EngineName");
            return View(integrationRuntime);
        }

        // GET: IntegrationRuntime/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var IntegrationRuntime = await _context.IntegrationRuntime
                .FirstOrDefaultAsync(m => m.IntegrationRuntimeId == id);
            if (IntegrationRuntime == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(IntegrationRuntime))
                return new ForbidResult();

            return View(IntegrationRuntime);
        }

        // POST: IntegrationRuntime/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var integrationRuntime = await _context.IntegrationRuntime.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(integrationRuntime))
                return new ForbidResult();
		
            _context.IntegrationRuntime.Remove(integrationRuntime);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool IntegrationRuntimeExists(long id)
        {
            return _context.IntegrationRuntime.Any(e => e.IntegrationRuntimeId == id);
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
            cols.Add(JObject.Parse("{ 'data':'IntegrationRuntimeId', 'name':'Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'IntegrationRuntimeName', 'name':'Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'EngineId', 'name':'Execution Engine', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'Is Active', 'autoWidth':true, 'ads_format':'bool'}"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("IntegrationRuntimeId");

            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "IntegrationRuntime";
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
                var modelDataAll = (from temptable in _context.IntegrationRuntime
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.IntegrationRuntimeName == searchValue);
                }

                //total number of rows count     
                recordsTotal = await modelDataAll.CountAsync();
                //Paging
                Console.WriteLine(modelDataAll);
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
