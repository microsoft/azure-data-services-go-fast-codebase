using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Data;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;

namespace SecureFileUploader.Common.Services;

public class CreateProgramService : ICreateProgramService
{
    private readonly SecureFileUploaderContext _secureFileUploaderContext;

    public CreateProgramService(SecureFileUploaderContext secureFileUploaderContext)
    {
        _secureFileUploaderContext = secureFileUploaderContext;
    }

    // This method can be converted to a extension/overload method if needed
    public async Task<ProgramDataModel> InsertProgramData(BaseProgram program)
    {
        var toSave = new ProgramDataModel {
            Name = program.Name,
            CommencementDate = program.CommencementDate,
            SubmissionDeadline = program.SubmissionDeadline,
            IsCommenced = false,
            TimeZone = program.TimeZone
        };
        await _secureFileUploaderContext.Program.AddAsync(toSave);
        return toSave;
    }

    // This method can be converted to a extension/overload method if needed
    public async Task<List<InviteeDataModel>> InsertInviteeData(IEnumerable<BaseInvitee> csvData, ProgramDataModel program)
    {
        var list = csvData.Select(rows => new InviteeDataModel {
                Email = rows.GenericEmailAddress,
                Name = rows.GeneralPracticeName,
                Program = program,
                ContainerName = rows.FolderName,
                CrmId = rows.CrmId,
                IsFileUploaded = false,
                PHN = rows.Phn,
                PracticeId = rows.PracticeId,
                ReportingQuarter = rows.ReportingQuarter
            })
            .ToList();

        await _secureFileUploaderContext.Invitee.AddRangeAsync(list);
        return list;
    }
}
