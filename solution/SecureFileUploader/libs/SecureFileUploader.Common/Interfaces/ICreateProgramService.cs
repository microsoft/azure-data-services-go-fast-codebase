using SecureFileUploader.Common.Dtos;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;

namespace SecureFileUploader.Common.Interfaces;

public interface ICreateProgramService
{
    Task<ProgramDataModel> InsertProgramData(BaseProgram program);
    Task<List<InviteeDataModel>> InsertInviteeData(IEnumerable<BaseInvitee> csvData, ProgramDataModel program);
}
