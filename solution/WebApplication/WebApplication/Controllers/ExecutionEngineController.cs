using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication.Services;
using WebApplication.Framework;
using WebApplication.Models;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebApplication.Controllers
{
    public partial class ExecutionEngineController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public ExecutionEngineController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "ExecutionEngine";
            _context = context;
        }

        // GET: DataFactory
        public async Task<IActionResult> Index()
        {
            return View(await _context.ExecutionEngine.ToListAsync());
        }

        // GET: DataFactory/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var executionEngine = await _context.ExecutionEngine
                .FirstOrDefaultAsync(m => m.EngineId == id);
            if (executionEngine == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(executionEngine))
                return new ForbidResult();


            return View(executionEngine);
        }

        // GET: DataFactory/Create
        public IActionResult Create()
        {
     ExecutionEngine executionEngine = new ExecutionEngine();
            return View(executionEngine);
        }

        // POST: DataFactory/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("Id,Name,ResourceGroup,SubscriptionUid,DefaultKeyVaultUrl,LogAnalyticsWorkspaceId")] ExecutionEngine executionEngine)
        {
            if (ModelState.IsValid)
            {
                _context.Add(executionEngine);
                if (!await CanPerformCurrentActionOnRecord(executionEngine))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(executionEngine);
        }

        // GET: DataFactory/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var executionEngine = await _context.ExecutionEngine.FindAsync(id);
            if (executionEngine == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(executionEngine))
                return new ForbidResult();
            return View(executionEngine);
        }

        // POST: DataFactory/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(long id, [Bind("Id,Name,ResourceGroup,SubscriptionUid,DefaultKeyVaultUrl, EngineJson, LogAnalyticsWorkspaceId")] ExecutionEngine executionEngine)
        {
            if (id != executionEngine.EngineId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(executionEngine);

                    if (!await CanPerformCurrentActionOnRecord(executionEngine))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ExecutionEngineExists(executionEngine.EngineId))
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
            return View(executionEngine);
        }

        // GET: DataFactory/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var executionEngine = await _context.ExecutionEngine
                .FirstOrDefaultAsync(m => m.EngineId == id);
            if (executionEngine == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(executionEngine))
                return new ForbidResult();

            return View(executionEngine);
        }

        // POST: DataFactory/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(long id)
        {
            var executionEngine = await _context.ExecutionEngine.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(executionEngine))
                return new ForbidResult();
		
            _context.ExecutionEngine.Remove(executionEngine);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool ExecutionEngineExists(long id)
        {
            return _context.ExecutionEngine.Any(e => e.EngineId == id);
        }

        public IActionResult IndexDataTable()
        {
            return View();
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'EngineId', 'name':'EngineId', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'EngineName', name:'EngineName', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SystemType', name:'SystemType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ResourceGroup', 'name':'Resource Group', 'autoWidth':true, 'width':'30%' }"));
            cols.Add(JObject.Parse("{ 'data':'SubscriptionUid', 'name':'Subscription', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DefaultKeyVaultURL', 'name':'Default KeyVault URL', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'EngineJson', name:'EngineJson', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'LogAnalyticsWorkspaceId', 'name':'LogAnalytics Workspace', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("Id");

            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "ExecutionEngine";
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
                var modelDataAll = (from temptable in _context.ExecutionEngine
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.EngineName.Contains(searchValue)
                    || m.ResourceGroup.Contains(searchValue)
                    || (m.SubscriptionUid != null && m.SubscriptionUid.ToString().Contains(searchValue))
                    || (m.LogAnalyticsWorkspaceId != null && m.LogAnalyticsWorkspaceId.ToString().Contains(searchValue)));
                }

                //Custom Includes
                modelDataAll = modelDataAll
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


        public async Task<ActionResult> UpdateTaskMasterActiveYN()
        {
            List<Int64> Pkeys = JsonConvert.DeserializeObject<List<Int64>>(Request.Form["Pkeys"]);
            bool Status = JsonConvert.DeserializeObject<bool>(Request.Form["Status"]);
            var entitys = _context.TaskMasterWaterMark.Where(ti => Pkeys.Contains(ti.TaskMasterId));

            entitys.ForEachAsync(ti =>
            {
                ti.ActiveYn = Status;
            }).Wait();
            await _context.SaveChangesAsync();

            //TODO: Add Error Handling
            return new OkObjectResult(new { });
        }

        public async Task<IActionResult> EditPlus(long? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var taskMaster = await _context.TaskMaster.FindAsync(id);
            if (taskMaster == null)
            {
                return NotFound();
            }

            return View(taskMaster);
        }
    }
}
