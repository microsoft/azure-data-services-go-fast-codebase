using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using WebApplication.Models;

namespace WebApplication.Views_TaskType
{
    public class CreateModel : PageModel
    {
        private readonly WebApplication.Models.AdsGoFastContext _context;

        public CreateModel(WebApplication.Models.AdsGoFastContext context)
        {
            _context = context;
        }

        public IActionResult OnGet()
        {
            return Page();
        }

        [BindProperty]
        public TaskType TaskType { get; set; }

        // To protect from overposting attacks, enable the specific properties you want to bind to, for
        // more details, see https://aka.ms/RazorPagesCRUD.
        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
            {
                return Page();
            }

            _context.TaskType.Add(TaskType);
            await _context.SaveChangesAsync();

            return RedirectToPage("./Index");
        }
    }
}
