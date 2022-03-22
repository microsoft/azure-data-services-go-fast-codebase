using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication.Services;
using WebApplication.Framework;
using WebApplication.Models;

namespace WebApplication.Controllers
{
    public partial class SubjectAreaFormController : BaseController
    {
        protected readonly AdsGoFastContext _context;


        public SubjectAreaFormController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "SubjectAreaForm";
            _context = context;
        }

        // GET: SubjectAreaForm
        public async Task<IActionResult> Index()
        {
            return View(await _context.SubjectAreaForm.ToListAsync());
        }

        // GET: SubjectAreaForm/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectAreaForm = await _context.SubjectAreaForm
                .FirstOrDefaultAsync(m => m.SubjectAreaFormId == id);
            if (subjectAreaForm == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(subjectAreaForm))
                return new ForbidResult();


            return View(subjectAreaForm);
        }

        // GET: SubjectAreaForm/Create
        public IActionResult Create()
        {
     SubjectAreaForm subjectAreaForm = new SubjectAreaForm();
            return View(subjectAreaForm);
        }

        // POST: SubjectAreaForm/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("SubjectAreaFormId,FormJson,FormStatus,UpdatedBy,ValidFrom,ValidTo,Revision")] SubjectAreaForm subjectAreaForm)
        {
            if (ModelState.IsValid)
            {
                _context.Add(subjectAreaForm);
                if (!await CanPerformCurrentActionOnRecord(subjectAreaForm))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(subjectAreaForm);
        }

        // GET: SubjectAreaForm/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectAreaForm = await _context.SubjectAreaForm.FindAsync(id);
            if (subjectAreaForm == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(subjectAreaForm))
                return new ForbidResult();
            return View(subjectAreaForm);
        }

        // POST: SubjectAreaForm/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(int id, [Bind("SubjectAreaFormId,FormJson,FormStatus,UpdatedBy,ValidFrom,ValidTo,Revision")] SubjectAreaForm subjectAreaForm)
        {
            if (id != subjectAreaForm.SubjectAreaFormId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(subjectAreaForm);

                    if (!await CanPerformCurrentActionOnRecord(subjectAreaForm))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!SubjectAreaFormExists(subjectAreaForm.SubjectAreaFormId))
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
            return View(subjectAreaForm);
        }

        // GET: SubjectAreaForm/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var subjectAreaForm = await _context.SubjectAreaForm
                .FirstOrDefaultAsync(m => m.SubjectAreaFormId == id);
            if (subjectAreaForm == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(subjectAreaForm))
                return new ForbidResult();

            return View(subjectAreaForm);
        }

        // POST: SubjectAreaForm/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var subjectAreaForm = await _context.SubjectAreaForm.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(subjectAreaForm))
                return new ForbidResult();
		
            _context.SubjectAreaForm.Remove(subjectAreaForm);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool SubjectAreaFormExists(int id)
        {
            return _context.SubjectAreaForm.Any(e => e.SubjectAreaFormId == id);
        }
        public IActionResult IndexDataTable()
        {
            //note - this is just here so that we don't ahve to re-scaffold
            return RedirectToAction(nameof(Index));
        }
    }
}
