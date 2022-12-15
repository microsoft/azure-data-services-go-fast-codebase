using System.Net;
using System.Text;
using AutoFixture;
using AutoMapper;
using FluentAssertions;
using FluentAssertions.Execution;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using SecureFileUploader.Common.Tests.Infrastructure;
using SettingsDataModel = SecureFileUploader.Data.Models.Settings;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;

namespace SecureFileUploader.Portal.Web.Tests.Controllers;

public class SettingsControllerTests: IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;


    public SettingsControllerTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Fact]
    public async Task WhenSettingsEndpointHit_Return200()
    {
        var settingsModel = _objectFactory.CreateMany<SettingsDataModel>().ToList();
        var expectedResult = _mapper.Map<SettingsDto>(settingsModel.MaxBy(x => x.LastModifiedOn));

        using var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(settingsModel));

        var response = await client.GetAsync("api/settings");

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var actualResult = JsonConvert.DeserializeObject<SettingsDto>(content);
            actualResult.Should().BeEquivalentTo(expectedResult);
        }
    }

    [Fact]
    public async Task WhenSettingsUpdated_Return200()
    {
        // existing values
        var settingsModel = _objectFactory.Create<SettingsDataModel>();
        // something different
        var expectedResult = _objectFactory.Build<SettingsDto>().With(x => x.FileUnit, "MB")
            .With(x => x.PhnLogo, Convert.ToBase64String(Encoding.UTF8.GetBytes("PhnLogo")))
            .Create();

        using var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(settingsModel));

        var multiData = new MultipartFormDataContent();

        foreach (var property in typeof(SettingsDto).GetProperties())
        {
            var value = property.GetValue(expectedResult);
            multiData.Add(new StringContent(value?.ToString() ?? string.Empty), property.Name);
        }

        var response = await client.PutAsync("api/settings", multiData);

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.Created);
            var content = await response.Content.ReadAsStringAsync();
            var actualResult = JsonConvert.DeserializeObject<Guid>(content);
            actualResult.Should<Guid>();
        }
    }

    [Fact]
    public async Task WhenInvalidFileUnitsUsed_Return400()
    {
        // existing values
        var settingsModel = _objectFactory.Create<SettingsDataModel>();
        // something different
        var expectedResult = _objectFactory.Build<SettingsDto>().With(x => x.FileUnit, "This is not a valid unit").Create();

        using var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(settingsModel));

        var multiData = new MultipartFormDataContent();

        foreach (var property in typeof(SettingsDto).GetProperties())
        {
            var value = property.GetValue(expectedResult);
            multiData.Add(new StringContent(value?.ToString() ?? string.Empty), property.Name);
        }

        var response = await client.PutAsync("api/settings", multiData);

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.BadRequest);
        }
    }

    private TestHostFactory.TestClientCreateOptions UsingDbContextSeededWith(SettingsDataModel settings)
    {
        var databaseName = _objectFactory.Create<string>();
        return new TestHostFactory.TestClientCreateOptions {
            DbContext = {
                Options = options => options.UseInMemoryDatabase(databaseName),
                InitializationStepsForTests = dbContext =>
                {
                    dbContext.Set<SettingsDataModel>().Add(settings);
                    dbContext.SaveChanges();
                }
            }
        };
    }

    private TestHostFactory.TestClientCreateOptions UsingDbContextSeededWith(IEnumerable<SettingsDataModel> settings)
    {
        var databaseName = _objectFactory.Create<string>();
        return new TestHostFactory.TestClientCreateOptions {
            DbContext = {
                Options = options => options.UseInMemoryDatabase(databaseName),
                InitializationStepsForTests = dbContext =>
                {
                    dbContext.Set<SettingsDataModel>().AddRange(settings);
                    dbContext.SaveChanges();
                }
            }
        };
    }
}
