using AutoMapper;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Portal.Web.Dtos;
using ProgramDataModel = SecureFileUploader.Data.Models.Program;
using ProgramDto = SecureFileUploader.Portal.Web.Dtos.Program;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using SendGridEmailModel = SecureFileUploader.Data.Models.SendGridEmail;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;

namespace SecureFileUploader.Portal.Web.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<ProgramDataModel, ProgramSummary>()
            .ForMember(d => d.NumberOfInvitees, o => o.MapFrom(s => s.Invitees.Count))
            .ForMember(d => d.NumberOfInviteesThatHaveUploaded, o => o.MapFrom(s => s.Invitees.Count(y => y.IsFileUploaded)))
            .ForMember(d => d.Status, o => o.MapFrom(s => ResolveProgramStatus(s.IsCommenced, s.SubmissionDeadline)));

        CreateMap<ProgramDataModel, ProgramDto>()
            .ForMember(d => d.Status, o => o.MapFrom(s => ResolveProgramStatus(s.IsCommenced, s.SubmissionDeadline)));

        CreateMap<SendGridEmailModel, SendGridEmailDto>();

        CreateMap<InviteeDataModel, InviteeSummary>()
            .ForMember(d => d.PracticeName, o => o.MapFrom(s => s.Name))
            .ForMember(d => d.EmailAddress, o => o.MapFrom(s => s.Email))
            .ForMember(d => d.HasBeenInvited, o => o.MapFrom(s => s.AccessTokens.Any(x => x.IsSentToMailProvider)))
            .ForMember(d => d.HasUploaded, o => o.MapFrom(s => s.IsFileUploaded))
            .ForMember(d => d.BounceResponses, o => o.MapFrom(s => s.SendGridEmails))
            .ForMember(d => d.Status, o => o.MapFrom(s => ResolveInviteeStatus(s.IsFileUploaded, s.SendGridEmails)));

        CreateMap<ProgramUpdate, ProgramDataModel>();
    }

    public static ProgramStatus ResolveProgramStatus(bool isCommenced, DateTime submissionDeadline)
    {
        var utcNow = DateTime.UtcNow;
        if (!isCommenced) return ProgramStatus.Pending;
        if (utcNow <= submissionDeadline) return ProgramStatus.Open;
        return ProgramStatus.Closed;
    }

    public static InviteeStatus ResolveInviteeStatus(bool isFileUploaded, IEnumerable<SendGridEmailModel> sendGridEmails)
    {
        // If a file is uploaded, this overrides any bounced status
        if (isFileUploaded)
        {
            return InviteeStatus.Completed;
        }

        // if ANY row has a bounce - mark the Invitee in the UI as Bounced
        return sendGridEmails.Any(email => email.BouncedOn.HasValue) ? InviteeStatus.Bounced : InviteeStatus.Pending;
    }
}
