using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using WebApplication.Services;
using WebApplication.Framework;
using WebApplication.Models;
using Dapper;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace WebApplication.Controllers
{
    public partial class FrameworkTaskRunnerController : BaseController
    {
        protected readonly AdsGoFastContext _context;
        

        public FrameworkTaskRunnerController(AdsGoFastContext context, ISecurityAccessProvider securityAccessProvider, IEntityRoleProvider roleProvider) : base(securityAccessProvider, roleProvider)
        {
            Name = "FrameworkTaskRunner";
            _context = context;
        }

        // GET: FrameworkTaskRunner
        public async Task<IActionResult> Index()
        {
            return View(await _context.FrameworkTaskRunner.ToListAsync());
        }

        // GET: FrameworkTaskRunner/Details/5
        [ChecksUserAccess]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var frameworkTaskRunner = await _context.FrameworkTaskRunner
                .FirstOrDefaultAsync(m => m.TaskRunnerId == id);
            if (frameworkTaskRunner == null)
                return NotFound();
            if (!await CanPerformCurrentActionOnRecord(frameworkTaskRunner))
                return new ForbidResult();


            return View(frameworkTaskRunner);
        }

        // GET: FrameworkTaskRunner/Create
        public IActionResult Create()
        {
     FrameworkTaskRunner frameworkTaskRunner = new FrameworkTaskRunner();
            frameworkTaskRunner.ActiveYn = true;
            return View(frameworkTaskRunner);
        }

        // POST: FrameworkTaskRunner/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Create([Bind("TaskRunnerId,TaskRunnerName,ActiveYn,Status,MaxConcurrentTasks")] FrameworkTaskRunner frameworkTaskRunner)
        {
            if (ModelState.IsValid)
            {
                _context.Add(frameworkTaskRunner);
                if (!await CanPerformCurrentActionOnRecord(frameworkTaskRunner))
                {
                    return new ForbidResult();
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(IndexDataTable));
            }
            return View(frameworkTaskRunner);
        }

        // GET: FrameworkTaskRunner/Edit/5
        [ChecksUserAccess()]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var frameworkTaskRunner = await _context.FrameworkTaskRunner.FindAsync(id);
            if (frameworkTaskRunner == null)
                return NotFound();

            if (!await CanPerformCurrentActionOnRecord(frameworkTaskRunner))
                return new ForbidResult();
            return View(frameworkTaskRunner);
        }

        // POST: FrameworkTaskRunner/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ChecksUserAccess]
        public async Task<IActionResult> Edit(int id, [Bind("TaskRunnerId,TaskRunnerName,ActiveYn,Status,MaxConcurrentTasks")] FrameworkTaskRunner frameworkTaskRunner)
        {
            if (id != frameworkTaskRunner.TaskRunnerId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(frameworkTaskRunner);

                    if (!await CanPerformCurrentActionOnRecord(frameworkTaskRunner))
                        return new ForbidResult();
			
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!FrameworkTaskRunnerExists(frameworkTaskRunner.TaskRunnerId))
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
            return View(frameworkTaskRunner);
        }

        // GET: FrameworkTaskRunner/Delete/5
        [ChecksUserAccess]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var frameworkTaskRunner = await _context.FrameworkTaskRunner
                .FirstOrDefaultAsync(m => m.TaskRunnerId == id);
            if (frameworkTaskRunner == null)
                return NotFound();
		
            if (!await CanPerformCurrentActionOnRecord(frameworkTaskRunner))
                return new ForbidResult();

            return View(frameworkTaskRunner);
        }

        // POST: FrameworkTaskRunner/Delete/5
        [HttpPost, ActionName("Delete")]
        [ChecksUserAccess()]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var frameworkTaskRunner = await _context.FrameworkTaskRunner.FindAsync(id);

            if (!await CanPerformCurrentActionOnRecord(frameworkTaskRunner))
                return new ForbidResult();
		
            _context.FrameworkTaskRunner.Remove(frameworkTaskRunner);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(IndexDataTable));
        }

        private bool FrameworkTaskRunnerExists(int id)
        {
            return _context.FrameworkTaskRunner.Any(e => e.TaskRunnerId == id);
        }

        public IActionResult IndexDataTable()
        {
            return View();
        }

        public async Task<ActionResult> SetFrameworkTaskRunnersBackToIdle()
        {
            List<Int64> Pkeys = JsonConvert.DeserializeObject<List<Int64>>(Request.Form["Pkeys"]);
            var entitys = _context.FrameworkTaskRunner.Where(ti => Pkeys.Contains(ti.TaskRunnerId));
            entitys.ForEachAsync(ti =>
            {
                ti.Status = "Idle";
            }).Wait();
            await _context.SaveChangesAsync();

            return new OkObjectResult(new { });
        }
    }

}
