using AutoMapper;
using SecureFileUploader.Common.Mapping;

namespace SecureFileUploader.Common.Tests.Infrastructure;

public class MapperFixture
{
    public MapperFixture()
    {
        Mapper = new Mapper(new MapperConfiguration(config => config.AddProfile<MappingProfile>()));
    }

    public IMapper Mapper { get; }
}
