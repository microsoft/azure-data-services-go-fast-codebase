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
    public partial class SourceAndTargetSystemsJsonSchemaController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public SourceAndTargetSystemsJsonSchemaController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "SourceAndTargetSystemsJsonSchema";
            _context = context;
        }

        // GET: SourceAndTargetSystemsJsonSchema
        public async Task<IActionResult> Index()
        {
            return View(await _context.SourceAndTargetSystemsJsonSchema.ToListAsync());
        }

        // GET: SourceAndTargetSystemsJsonSchema/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sourceAndTargetSystemsJsonSchema = await _context.SourceAndTargetSystemsJsonSchema
                .FirstOrDefaultAsync(m => m.SystemType == id);
            if (sourceAndTargetSystemsJsonSchema == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystemsJsonSchema))
                return new ForbidResult();


            return View(sourceAndTargetSystemsJsonSchema);
        }

        // GET: SourceAndTargetSystemsJsonSchema/Create
        public IActionResult Create()
        {
     SourceAndTargetSystemsJsonSchema sourceAndTargetSystemsJsonSchema = new SourceAndTargetSystemsJsonSchema();
            return View(sourceAndTargetSystemsJsonSchema);
        }

        // POST: SourceAndTargetSystemsJsonSchema/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("SystemType,JsonSchema")] SourceAndTargetSystemsJsonSchema sourceAndTargetSystemsJsonSchema)
        {
            if (ModelState.IsValid)
            {
                _context.Add(sourceAndTargetSystemsJsonSchema);
                if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystemsJsonSchema))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(sourceAndTargetSystemsJsonSchema);
        }

        // GET: SourceAndTargetSystemsJsonSchema/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sourceAndTargetSystemsJsonSchema = await _context.SourceAndTargetSystemsJsonSchema.FindAsync(id);
            if (sourceAndTargetSystemsJsonSchema == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystemsJsonSchema))
                return new ForbidResult();
            return View(sourceAndTargetSystemsJsonSchema);
        }

        // POST: SourceAndTargetSystemsJsonSchema/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(string id, [Bind("SystemType,JsonSchema")] SourceAndTargetSystemsJsonSchema sourceAndTargetSystemsJsonSchema)
        {
            if (id != sourceAndTargetSystemsJsonSchema.SystemType)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(sourceAndTargetSystemsJsonSchema);

                    if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystemsJsonSchema))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SourceAndTargetSystemsJsonSchemaExists(sourceAndTargetSystemsJsonSchema.SystemType))
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
            return View(sourceAndTargetSystemsJsonSchema);
        }

        // GET: SourceAndTargetSystemsJsonSchema/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(string id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var sourceAndTargetSystemsJsonSchema = await _context.SourceAndTargetSystemsJsonSchema
                .FirstOrDefaultAsync(m => m.SystemType == id);
            if (sourceAndTargetSystemsJsonSchema == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystemsJsonSchema))
                return new ForbidResult();

            return View(sourceAndTargetSystemsJsonSchema);
        }

        // POST: SourceAndTargetSystemsJsonSchema/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(string id)
        {
            var sourceAndTargetSystemsJsonSchema = await _context.SourceAndTargetSystemsJsonSchema.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(sourceAndTargetSystemsJsonSchema))
                return new ForbidResult();
		
            _context.SourceAndTargetSystemsJsonSchema.Remove(sourceAndTargetSystemsJsonSchema);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool SourceAndTargetSystemsJsonSchemaExists(string id)
        {
            return _context.SourceAndTargetSystemsJsonSchema.Any(e => e.SystemType == id);
        }

        public IActionResult IndexDataTable()
        {
            return View();
        }

        public JObject GridCols()
        {
            JObject GridOptions = new JObject();

            JArray cols = new JArray();
            cols.Add(JObject.Parse("{ 'data':'SystemType', 'name':'SystemType', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'JsonSchema', 'name':'JsonSchema', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("SystemType");

            JArray Navigations = new JArray();

            GridOptions["GridColumns"] = cols;
            GridOptions["ModelName"] = "SourceAndTargetSystemsJsonSchema";
            GridOptions["PrimaryKeyColumns"] = pkeycols;
            GridOptions["Navigations"] = Navigations;
            GridOptions["CrudController"] = "SourceAndTargetSystemsJsonSchema";
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
                var modelDataAll = (from temptable in _context.SourceAndTargetSystemsJsonSchema
                                    select temptable);

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.SystemType == searchValue);
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
