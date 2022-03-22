using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using WebApplication.Models;

namespace WebApplication.Views_TaskType
{
    public class EditModel : PageModel
    {
        private readonly WebApplication.Models.AdsGoFastContext _context;

        public EditModel(WebApplication.Models.AdsGoFastContext context)
        {
            _context = context;
        }

        [BindProperty]
        public TaskType TaskType { get; set; }

        public async Task<IActionResult> OnGetAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            TaskType = await _context.TaskType.FirstOrDefaultAsync(m => m.TaskTypeId == id);

            if (TaskType == null)
            {
                return NotFound();
            }
            return Page();
        }

        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.Attach(TaskType).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!TaskTypeExists(TaskType.TaskTypeId))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return RedirectToPage("./Index");
        }

        private bool TaskTypeExists(int id)
        {
            return _context.TaskType.Any(e => e.TaskTypeId == id);
        }
    }
}
