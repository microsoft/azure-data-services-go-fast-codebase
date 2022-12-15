using System.Text;
using AutoMapper;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Data.Models;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeDto = SecureFileUploader.Common.Dtos.Invitee;
using InviteeEventDataModel = SecureFileUploader.Data.Models.InviteeEvent;
using InviteeEventDto = SecureFileUploader.Common.Dtos.Event;
using InviteeAccessTokenDataModel = SecureFileUploader.Data.Models.AccessToken;
using InviteeAccessTokenDto = SecureFileUploader.Common.Dtos.AccessToken;
using SettingsDataModel = SecureFileUploader.Data.Models.Settings;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;
using SendGridEmailModel = SecureFileUploader.Data.Models.SendGridEmail;
using SendGridEmailDto = SecureFileUploader.Common.Dtos.SendGridEmail;

namespace SecureFileUploader.Common.Mapping;

public class MappingProfile : Profile
{
    public MappingProfile()
    {
        CreateMap<InviteeDataModel, InviteeDto>()
            .ForMember(d => d.PracticeName, o => o.MapFrom(s => s.Name))
            .ForMember(d => d.FolderName, o => o.MapFrom(s => s.ContainerName))
            .ForMember(d => d.EmailAddress, o => o.MapFrom(s => s.Email))
            .ForMember(d => d.Status, o => o.MapFrom(s => s.IsFileUploaded ? InviteeStatus.Completed : InviteeStatus.Pending))
            .ForMember(d => d.Events, o => o.MapFrom(s => s.InviteeEvents));

        CreateMap<InviteeEventDataModel, InviteeEventDto>()
            .ForMember(d => d.TriggeredAt, o => o.MapFrom(s => s.PerformedOn))
            .ForMember(d => d.Description, o => o.MapFrom(s => s.Description))
            .ForMember(d => d.TriggeredBy, o => o.MapFrom(s => s.PerformedBy));

        CreateMap<InviteeAccessTokenDataModel, InviteeAccessTokenDto>()
            .ForMember(d => d.GeneratedAt, o => o.MapFrom(s => s.GeneratedOn))
            .ForMember(d => d.ActiveWindowStartsAt, o => o.MapFrom(s => s.StartsOn))
            .ForMember(d => d.ActiveWindowEndsAt, o => o.MapFrom(s => s.EndsOn))
            .ForMember(d => d.GeneratedBy, o => o.MapFrom(s => s.CreatedBy));

        // Ignore the ID
        CreateMap<SettingsDataModel, SettingsDto>()
            .ForSourceMember(s => s.Id, y => y.DoNotValidate())
            .ForMember(d => d.PhnLogo, o => o.MapFrom(s => Convert.ToBase64String(s.PhnLogo)));

        CreateMap<string, byte[]>().ConvertUsing<Base64Converter>();
        CreateMap<SettingsValues, SettingsDto>();

        CreateMap<SendGridEmailModel, SendGridEmailDto>()
            .ForSourceMember(s => s.InviteeId, y => y.DoNotValidate());
    }

    private class Base64Converter : ITypeConverter<string, byte[]>, ITypeConverter<byte[], string>
    {
        public byte[] Convert(string source, byte[] destination, ResolutionContext context) => System.Convert.FromBase64String(source);
        public string Convert(byte[] source, string destination, ResolutionContext context) => System.Convert.ToBase64String(source);
    }
}
