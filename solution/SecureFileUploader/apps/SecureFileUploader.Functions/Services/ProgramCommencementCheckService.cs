using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.Extensions.Logging;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Models;
using SecureFileUploader.Functions.Interfaces;

namespace SecureFileUploader.Functions.Services;

public class ProgramCommencementCheckService : IProgramCommencementCheckService
{
    private readonly SecureFileUploaderContext _secureFileUploaderContext;
    private readonly ILogger<ProgramCommencementCheckService> _log;

    public ProgramCommencementCheckService(SecureFileUploaderContext secureFileUploaderContext,
        ILogger<ProgramCommencementCheckService> log)
    {
        _secureFileUploaderContext = secureFileUploaderContext;
        _log = log;
    }

    /// <summary>
    /// For a given commencement date - any Programs that have not been commenced should be marked as such.
    /// </summary>
    /// <param name="commencementDate">A date for which to check if Programs have commenced or not</param>
    public async Task MarkProgramCommencementAsync(DateTime commencementDate)
    {
        // Check if there are any Programs with a newer commencement date than what is passed through.
        // If so -> Commence it
        var programs = _secureFileUploaderContext.Program.Where(p => p.IsCommenced == false &&
                                                      p.CommencementDate <= commencementDate).ToList();

        if (!programs.Any())
        {
            _log.LogInformation("No Programs found to be commenced.");
        }
        else
        {
            _log.LogInformation("Found {programs.Count} to be commenced.", programs.Count);

            var events = new List<ProgramEvent>();
            foreach (var program in programs)
            {
                program.IsCommenced = true;
                var programEvent = new ProgramEvent {
                    Description = "Program Commenced",
                    EventType = new ProgramEventType {
                        Description = "Program Commenced"
                    },
                    Program = program,
                };
                events.Add(programEvent);
            }

            await _secureFileUploaderContext.ProgramEvent.AddRangeAsync(events);
            await _secureFileUploaderContext.SaveChangesAsync();
        }
    }
}
