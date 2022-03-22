using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using WebApplication.Models;

namespace WebApplication.Views_TaskType
{
    public class DeleteModel : PageModel
    {
        private readonly WebApplication.Models.AdsGoFastContext _context;

        public DeleteModel(WebApplication.Models.AdsGoFastContext context)
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

        public async Task<IActionResult> OnPostAsync(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            TaskType = await _context.TaskType.FindAsync(id);

            if (TaskType != null)
            {
                _context.TaskType.Remove(TaskType);
                await _context.SaveChangesAsync();
            }

            return RedirectToPage("./Index");
        }
    }
}
