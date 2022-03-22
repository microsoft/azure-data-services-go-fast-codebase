using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using WebApplication.Models;


namespace WebApplication.Controllers.Customisations
{
    public class WizardsController : Controller
    {
        private readonly AdsGoFastContext _context;
        public WizardsController(AdsGoFastContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> ExternalFileUpload()
        {
            
            ViewData["UploadSystemId"] = new SelectList(await _context.SourceAndTargetSystems.Where(t=> t.SystemType.ToLower() == "azure blob").OrderBy(t => t.SystemName).ToListAsync(), "SystemId", "SystemName");
            ViewData["EmailSystemId"] = new SelectList(await _context.SourceAndTargetSystems.Where(t => t.SystemType.ToLower() == "sendgrid").OrderBy(t => t.SystemName).ToListAsync(), "SystemId", "SystemName");
            ViewData["TargetSystemId"] = new SelectList(await _context.SourceAndTargetSystems.Where(t => t.SystemType.ToLower() == "azure blob" || t.SystemType.ToLower() == "adls").OrderBy(t => t.SystemName).ToListAsync(), "SystemId", "SystemName");
            ViewData["TaskGroupId"] = new SelectList(await _context.TaskGroup.OrderBy(t => t.TaskGroupName).ToListAsync(), "TaskGroupId", "TaskGroupName");
            ViewData["ScheduleMasterId"] = new SelectList(await _context.ScheduleMaster.OrderBy(t => t.ScheduleDesciption).ToListAsync(), "ScheduleMasterId", "ScheduleDesciption");
            ViewData["ExternalParties"] = ""; 


            return View();
        }
    }
}
