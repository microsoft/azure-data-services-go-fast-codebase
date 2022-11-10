using SecureFileUploader.Portal.Web.Dtos;
using SecureFileUploader.Portal.Web.Dtos.Request;

namespace SecureFileUploader.Portal.Web.Interfaces;

public interface IProgramService
{
    Task<Dtos.Program?> GetByIdAsync(Guid id);

    Task<IEnumerable<ProgramSummary>> GetAllThatMatchSearchTermAsync(string? searchTerm, SearchProgramsFilter searchProgramsFilter);

    Task<(bool, string?)> CreateProgramAsync(FileUpload fileUpload);

    Task<Dtos.Program> UpdateProgramInformationAsync(Guid id, ProgramUpdate values);
}
