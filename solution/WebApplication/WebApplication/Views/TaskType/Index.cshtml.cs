using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.EntityFrameworkCore;
using WebApplication.Models;

namespace WebApplication.Views_TaskType
{
    public class IndexModel : PageModel
    {
        private readonly WebApplication.Models.AdsGoFastContext _context;

        public IndexModel(WebApplication.Models.AdsGoFastContext context)
        {
            _context = context;
        }

        public IList<TaskType> TaskType { get;set; }

        public async Task OnGetAsync()
        {
            TaskType = await _context.TaskType.ToListAsync();
        }
    }
}
