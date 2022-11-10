using AutoMapper;
using AutoMapper.QueryableExtensions;
using Microsoft.EntityFrameworkCore;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Data;
using SecureFileUploader.Portal.Web.Dtos;
using SecureFileUploader.Portal.Web.Dtos.Request;
using SecureFileUploader.Portal.Web.Interfaces;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;
using ProgramDto = SecureFileUploader.Portal.Web.Dtos.Program;

namespace SecureFileUploader.Portal.Web.Services;

public class ProgramService : IProgramService
{
    private readonly ICsvParser _csvParser;
    private readonly IMapper _mapper;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;
    private readonly ICreateProgramService _createProgramService;

    public ProgramService(IMapper mapper, SecureFileUploaderContext secureFileUploaderContext, ICsvParser csvParser, ICreateProgramService createProgramService)
    {
        _mapper = mapper;
        _secureFileUploaderContext = secureFileUploaderContext;
        _csvParser = csvParser;
        _createProgramService = createProgramService;
    }

    public async Task<ProgramDto?> GetByIdAsync(Guid id)
    {
        var program = await _secureFileUploaderContext.FindAsync<ProgramDataModel>(id);
        if (program == null) return null;
        await _secureFileUploaderContext.Entry(program).Collection(x => x.Invitees).Query()
            .Include(x => x.AccessTokens)
            .Include(x => x.SendGridEmails).LoadAsync();
        return _mapper.Map<ProgramDto>(program);
    }

    public async Task<IEnumerable<ProgramSummary>> GetAllThatMatchSearchTermAsync(string? searchTerm, SearchProgramsFilter searchProgramsFilter)
    {
        IQueryable<ProgramDataModel> programs = _secureFileUploaderContext.Program;

        if (!string.IsNullOrWhiteSpace(searchTerm))
            programs = programs.Where(x => x.Name.Contains(searchTerm));

        // keep for if we add explicit status filtering in the future
        //if (searchProgramsFilter.ProgramStatus == ProgramStatus.Pending)
        //    programs = programs.Where(x => x.IsCommenced == false);
        //else if (searchProgramsFilter.ProgramStatus == ProgramStatus.Open)
        //    programs = programs.Where(x => x.IsCommenced && x.SubmissionDeadline > DateTime.Now);
        //else if (searchProgramsFilter.ProgramStatus == ProgramStatus.Closed)
        //    programs = programs.Where(x => x.IsCommenced == false && x.SubmissionDeadline < DateTime.Now);

        if (!searchProgramsFilter.ShowClosedPrograms)
            programs = programs.Where(x => x.IsCommenced == false || x.SubmissionDeadline > DateTime.Now);

        programs = programs.OrderByDescending(x => x.CommencementDate);

        return await programs.ProjectTo<ProgramSummary>(_mapper.ConfigurationProvider).ToListAsync();
    }

    /// <summary>
    /// For a given upload - parse the CSV input and create/save a program.
    /// </summary>
    /// <param name="fileUpload">CSV containing invitees for a program.</param>
    /// <returns>Newly created Program Id</returns>
    public async Task<(bool, string?)> CreateProgramAsync(FileUpload fileUpload)
    {
        try
        {
            var csvRows = await _csvParser.GetRecordsAsync<InviteCsvRow>(fileUpload.File);
            if (!csvRows.Any())
            {
                return (false, "No data found in CSV file");
            }

            var programData = await _createProgramService.InsertProgramData(fileUpload);
            await _createProgramService.InsertInviteeData(csvRows, programData);
            await _secureFileUploaderContext.SaveChangesAsync();
            return (true, programData.Id.ToString());
        }
        catch (Exception e)
        {
            return (false, e.ToString());
        }
    }

    public async Task<ProgramDto> UpdateProgramInformationAsync(Guid id, ProgramUpdate values)
    {
        var program = await _secureFileUploaderContext.FindAsync<ProgramDataModel>(id);
        if (program == null) return null;

        if (program.IsCommenced) throw new InvalidOperationException($"Cannot update program {id} as it has already commenced");

        _mapper.Map(values, program);

        await _secureFileUploaderContext.SaveChangesAsync();

        return _mapper.Map<ProgramDto>(program);
    }
}
