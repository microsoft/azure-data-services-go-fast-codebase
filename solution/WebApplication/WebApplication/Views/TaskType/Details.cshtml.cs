using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using WebApplication.Models;

namespace WebApplication.Views_TaskType
{
    public class DetailsModel : PageModel
    {
        private readonly WebApplication.Models.AdsGoFastContext _context;

        public DetailsModel(WebApplication.Models.AdsGoFastContext context)
        {
            _context = context;
        }

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
    }
}
