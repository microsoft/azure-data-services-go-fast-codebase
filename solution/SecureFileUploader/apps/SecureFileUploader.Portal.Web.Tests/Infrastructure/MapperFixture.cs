using AutoMapper;
using CommonMappingProfile = SecureFileUploader.Common.Mapping.MappingProfile;
using PortalApiMappingProfile = SecureFileUploader.Portal.Web.Mapping.MappingProfile;

namespace SecureFileUploader.Portal.Web.Tests.Infrastructure;

public class MapperFixture
{
    public MapperFixture()
    {
        Mapper = new Mapper(new MapperConfiguration(config =>
        {
            config.AddProfile<CommonMappingProfile>();
            config.AddProfile<PortalApiMappingProfile>();
        }));
    }

    public IMapper Mapper { get; }
}
