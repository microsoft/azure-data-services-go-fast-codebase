using System;
using System.Collections.Generic;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Options;
using Microsoft.Graph;
using WebApplication.Services;
using WebApplication.Framework;
using WebApplication.Models;
using Newtonsoft.Json.Linq;
using Newtonsoft.Json;
using WebApplication.Forms;
using WebApplication.Models.Forms;
using WebApplication.Models.Options;
using WebApplication.Models.Wizards;
using Site = WebApplication.Models.Site;

namespace WebApplication.Controllers
{
    public partial class SubjectAreaController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        private readonly IOptions<ApplicationOptions> _options;


        public SubjectAreaController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider, IOptions<ApplicationOptions> options) : base(securityAccessProvider, roleProvider)
        {
            Name = "SubjectArea";
            _context = context;
            _options = options;
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
        	if (!CanPerformCurrentActionGlobally())
            {
                return Forbid();
            }

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
        public async Task<IActionResult> Create(
            [Bind("SubjectAreaId,SubjectAreaName,ShortCode, ActiveYn,SubjectAreaFormId,DefaultTargetSchema,UpdatedBy")]
            SubjectArea subjectArea)
        {
            if (ModelState.IsValid)
            {
                subjectArea.UpdatedBy = User.Identity.Name;
                subjectArea.ShortCode = subjectArea.ShortCode?.ToLower();

                _context.Add(subjectArea);
                if (!await CanPerformCurrentActionOnRecord(subjectArea))
                {
                    return new ForbidResult();
                }

                await _context.SaveChangesAsync();
                try
                {
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateException e)
                {
                    ModelState.AddModelError("SubjectAreaName", e.InnerException.Message);
                    return View(subjectArea);
                }

                if (subjectArea.SubjectAreaFormId == null)
                {
                    await CreateEmptySubjectAreaFormAndPIAAsync(subjectArea);
                }

                
            }
            return RedirectToAction(nameof(IndexDataTable));
        }

        private async Task CreateEmptySubjectAreaFormAndPIAAsync(SubjectArea subjectArea)
        {
            var currentSite = new Site() { Name = _options.Value.SiteName, Id = _options.Value.SiteId };

            PIAWizardViewModel pia = new PIAWizardViewModel()
            {
                BelongingDataset = subjectArea.SubjectAreaName,
                BelongingDatasetCode = subjectArea.ShortCode,
                Site = currentSite
            };

            var form = new SubjectAreaForm()
            {
                FormJson = JsonConvert.SerializeObject(pia.ToForm(), PIAForm.JsonSettings),
                FormStatus = default,
                Revision = 1,
                UpdatedBy = User.Identity.Name
            };

            subjectArea.SubjectAreaForm = form;

            _context.Add(form);
            await _context.SaveChangesAsync();
        }

        // GET: SubjectArea/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectArea = await _context.SubjectArea
                .Include(x => x.SubjectAreaForm)
                .FirstOrDefaultAsync(x => x.SubjectAreaId == id);
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
            var subjectAreaRecord = await _context.SubjectArea
                .Include(x => x.SubjectAreaForm)
                .FirstOrDefaultAsync(x => x.SubjectAreaId == id);

            if (subjectAreaRecord == null)
                return NotFound();

            var hasGlobalPermission = await CanPerformCurrentActionOnRecord(subjectAreaRecord);
            var hasSpecialPermission = await this.CanEditSubjectArea(subjectAreaRecord);
            if (!hasGlobalPermission && !hasSpecialPermission)
                return Forbid();

            if (ModelState.IsValid)
            {
                try
                {
                    //explicit property setting because we now have additional fields that are *NOT* set by edit
                    subjectAreaRecord.SubjectAreaName = subjectArea.SubjectAreaName;
                    subjectAreaRecord.ActiveYn = subjectArea.ActiveYn;
                    subjectAreaRecord.SubjectAreaFormId = subjectArea.SubjectAreaFormId;
                    subjectAreaRecord.DefaultTargetSchema = subjectArea.DefaultTargetSchema;
                    subjectAreaRecord.UpdatedBy = User.GetUserName();

                    if (subjectAreaRecord.SubjectAreaFormId == null)
                    {
                        await CreateEmptySubjectAreaFormAndPIAAsync(subjectAreaRecord);
                    }

                    _context.Update(subjectAreaRecord);

                    if (!await CanPerformCurrentActionOnRecord(subjectAreaRecord))
                        return new ForbidResult();

                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SubjectAreaExists(subjectAreaRecord.SubjectAreaId))
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

        [HttpGet]
        [ChecksUserAccess]
        public async Task<IActionResult> EditPIA(int? id)
        {
            if (id == null)
            {
                return View("Error", new ErrorViewModel() { Message = "Subject area was not found." });
            }

            var subjectAreaRecord = await _context.SubjectArea
                .Include(x => x.SubjectAreaForm)
                .FirstOrDefaultAsync(x => x.SubjectAreaId == id);

            if (subjectAreaRecord == null)
                return NotFound();

            var hasGlobalPermission = await CanPerformCurrentActionOnRecord(subjectAreaRecord);
            var hasSpecialPermission = await this.CanEditSubjectArea(subjectAreaRecord);
            if (!hasGlobalPermission && !hasSpecialPermission)
                return Forbid();

            if (subjectAreaRecord.SubjectAreaFormId == null)
            {
                await CreateEmptySubjectAreaFormAndPIAAsync(subjectAreaRecord);
            }

            return RedirectToAction("PIAWizard", "Wizards", new { id = subjectAreaRecord.SubjectAreaId });
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
            cols.Add(JObject.Parse("{ 'data':'ShortCode', 'name':'Code', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SubjectAreaId', 'name':'Id', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SubjectAreaName', 'name':'Name', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'SubjectAreaFormId', 'name':'Form', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'DefaultTargetSchema', 'name':'Default Target Schema', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'UpdatedBy', 'name':'Updated By', 'autoWidth':true }"));
            cols.Add(JObject.Parse("{ 'data':'ActiveYn', 'name':'Is Active', 'autoWidth':true, 'ads_format':'bool'}"));
            cols.Add(JObject.Parse("{ 'data':'ExtractionVersionId', 'name':'ExtractionVersionId', 'autoWidth':true }"));

            HumanizeColumns(cols);

            JArray pkeycols = new JArray();
            pkeycols.Add("SubjectAreaId");

            JArray Navigations = new JArray();
            Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'View Task Groups', 'Icon':'object-group','ButtonClass':'btn-primary'}"));
            //Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'View System Mappings', 'Icon':'bullseye','ButtonClass':'btn-primary'}"));
            //Navigations.Add(JObject.Parse("{'Url':'/TaskGroup/IndexDataTable?SubjectAreaId=','Description':'View Role Mappings', 'Icon':'user-tag','ButtonClass':'btn-primary'}"));
			Navigations.Add(JObject.Parse("{'Url':'/SubjectArea/Provision?Id=','Description':'Auto Create Target Schema & AD Groups', 'Icon':'cogs','ButtonClass':'btn-danger'}"));
			Navigations.Add(JObject.Parse("{'Url':'/SubjectArea/EditPIA/','Description':'Edit Privacy Impact Assessment', 'Icon':'pencil-alt','ButtonClass':'btn-primary'}"));
			Navigations.Add(JObject.Parse("{'Url':'/Wizards/PIASummary/','Description':'View PIA Details', 'Icon':'list-alt','ButtonClass':'btn-primary'}"));

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
                    //TODO: Ensure that this works properly with the switch from Roles to Groups
                    var permittedRoles = GetPermittedGroupsForCurrentAction();
                    var identity = User.GetUserName();

                    var myIncompleteForms = _context
                        .SubjectArea
                        .Include(x => x.SubjectAreaForm)
                        .Where(x => x.SubjectAreaForm == null || x.SubjectAreaForm.FormStatus < (int)SubjectAreaFormStatus.Complete)
                        .Where(x => x.UpdatedBy == identity || (x.SubjectAreaForm != null && x.SubjectAreaForm.UpdatedBy == identity))
                      ;

                    var myRoleMaps = _context.GetEntityRoleMapsFor(EntityRoleMap.SubjectAreaTypeName,GetUserAdGroupUids(), permittedRoles);

                    modelDataAll =
                        from md in modelDataAll
                        where
                            myIncompleteForms.Any(x => x.SubjectAreaId == md.SubjectAreaId)
                            || myRoleMaps.Any(x => x.EntityId == md.SubjectAreaId && x.EntityTypeName == EntityRoleMap.SubjectAreaTypeName)
                        select md;
                }

                //Sorting    
                if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDir)))
                {
                    modelDataAll = modelDataAll.OrderBy(sortColumn + " " + sortColumnDir);
                }
                //Search    
                if (!string.IsNullOrEmpty(searchValue))
                {
                    modelDataAll = modelDataAll.Where(m => m.SubjectAreaName.Contains(searchValue));
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

        [HttpGet]
        [ChecksUserAccess]
        public async Task<IActionResult> Publish(int? id)
        {
            var subjectArea = await _context.SubjectArea.FindAsync(id);
            if (subjectArea == null)
            {
                return NotFound();
            }

            if (!await CanPerformCurrentActionOnRecord(subjectArea))
            {
                return Forbid();
            }

            subjectArea.TaskGroups = await _context.TaskGroup.Where(x => x.SubjectAreaId == subjectArea.SubjectAreaId).ToListAsync();
            if (subjectArea.SubjectAreaFormId != null && subjectArea.SubjectAreaFormId != 0)
                subjectArea.SubjectAreaForm = _context.SubjectAreaForm.First(x => x.SubjectAreaFormId == subjectArea.SubjectAreaFormId);

            ViewBag.Roles = _context.EntityRoleMap.Where(x => x.EntityId == subjectArea.SubjectAreaId && x.EntityTypeName == EntityRoleMap.SubjectAreaTypeName);
            return View(subjectArea);
        }


        [ChecksUserAccess]
        public async Task<IActionResult> Provision(int id)
        {
            var subjectArea = await _context.SubjectArea.FindAsync(id);
            if (subjectArea == null)
            {
                return NotFound();
            }
            // TODO: Implement the processing functionality
            //await _processingClient.QueueSubjectAreaProvisioning(id);
            return View(subjectArea);
        }

        [ChecksUserAccess]
        public async Task<IActionResult> ToggleExtractionIdTag()
        {
            List<Int64> Pkeys = JsonConvert.DeserializeObject<List<Int64>>(Request.Form["Pkeys"]);
            var entitys = await _context.SubjectArea.Where(ti => Pkeys.Contains(ti.SubjectAreaId)).ToArrayAsync();
            var row = _context.MetadataExtractionVersion.Where(
                m =>
                m.ExtractedDateTime == null &&
                m.ExtractionVersionId == _context.MetadataExtractionVersion.Max(x => x.ExtractionVersionId)).SingleOrDefault();
            foreach (var ti in entitys)
            {
                if (!await CanPerformCurrentActionOnRecord(ti))
                    return Forbid();
                if (ti.ExtractionVersionId != null)
                {
                    ti.ExtractionVersionId = null;
                }
                else
                {
                    ti.ExtractionVersionId = row.ExtractionVersionId;
                }
            }
            await _context.SaveChangesAsync();

            //TODO: Add Error Handling
            return new OkObjectResult(new { });
        }

        [ChecksUserAccess]
        public async Task<IActionResult> Revise(int? id)
        {
            if (id == null)
            {
                return RedirectToAction(nameof(IndexDataTable));
            }

            // get the subject area
            var subjectArea = await _context.SubjectArea.FindAsync(id);
            if (subjectArea == null)
            {
                return View("Error", new ErrorViewModel() { Message = "Subject area not found." });
            }

            if (!await base.CanPerformCurrentActionOnRecord(subjectArea))
                return Forbid();

            var saForm = await _context.SubjectAreaForm.FindAsync(subjectArea.SubjectAreaFormId);

            // Deserialize model so we can reset some values
            PIAWizardViewModel PIA = PIAWizardViewModel.FromForm(JsonConvert.DeserializeObject<PIAForm>(saForm.FormJson, PIAForm.JsonSettings));

            // Set DbId within the json after getting id of new SubjectAreaForm
            PIA.SubjectAreaId = subjectArea.SubjectAreaId;
            PIA.MaxStep = 0;
            PIA.Step = 0;

            // Create new SubjectAreaForm with copied values
            // Increment revision num and set form status back to 1
            var revisedSubjectAreaForm = new SubjectAreaForm
            {
                FormStatus = (byte)SubjectAreaFormStatus.Incomplete,
                FormJson = JsonConvert.SerializeObject(PIA.ToForm(), PIAForm.JsonSettings),
                SubjectAreas = saForm.SubjectAreas,
                Revision = (byte)(saForm.Revision + 1)
            };

            // Add to db
            _context.SubjectAreaForm.Add(revisedSubjectAreaForm);
            await _context.SaveChangesAsync();

            subjectArea.SubjectAreaFormId = revisedSubjectAreaForm.SubjectAreaFormId;
            await _context.SaveChangesAsync();

            // Now we can redireect to the wizard with our new SubjectAreaForm
            return RedirectToAction("PIAWizard", "Wizards", new { id = subjectArea.SubjectAreaId });
        }
    }
}
