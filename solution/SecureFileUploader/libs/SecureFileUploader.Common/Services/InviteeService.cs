using AutoMapper;
using SecureFileUploader.Data;
using SecureFileUploader.Common.Interfaces;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeDto = SecureFileUploader.Common.Dtos.Invitee;

namespace SecureFileUploader.Common.Services;

public class InviteeService : IInviteeService
{
    private readonly IMapper _mapper;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;

    public InviteeService(IMapper mapper, SecureFileUploaderContext secureFileUploaderContext)
    {
        _mapper = mapper;
        _secureFileUploaderContext = secureFileUploaderContext;
    }

    public async Task<InviteeDto?> GetByIdAsync(Guid id)
    {
        var invitee = await _secureFileUploaderContext.FindAsync<InviteeDataModel>(id);
        if (invitee == null) return null;
        await _secureFileUploaderContext.Entry(invitee).Collection(x => x.AccessTokens).LoadAsync();
        await _secureFileUploaderContext.Entry(invitee).Collection(x => x.InviteeEvents).LoadAsync();
        await _secureFileUploaderContext.Entry(invitee).Collection(x => x.SendGridEmails).LoadAsync();
        return _mapper.Map<InviteeDto>(invitee);
    }

    // isFileUploaded -> true basically
    // lodge an InvteeEvent
    /// <summary>
    /// For a given Invitee ID - mark that Invitee as having uploaded a their file.
    /// </summary>
    /// <param name="id">The invitee to update</param>
    /// <exception cref="ArgumentException">If an Invitee does not exist</exception>
    public async Task MarkInviteeFileUpload(Guid id)
    {
        var invitee = await _secureFileUploaderContext.FindAsync<InviteeDataModel>(id);
        if (invitee == null)
            throw new ArgumentException($"Unable to find Invitee {id}");

        invitee.IsFileUploaded = true;

        await _secureFileUploaderContext.SaveChangesAsync();
    }
}
