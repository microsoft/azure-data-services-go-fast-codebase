using System.Net;
using AutoFixture;
using AutoMapper;
using FluentAssertions;
using FluentAssertions.Execution;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using SecureFileUploader.Portal.Web.Tests.Infrastructure;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeDto = SecureFileUploader.Common.Dtos.Invitee;

namespace SecureFileUploader.Portal.Web.Tests.Controllers;

public class InviteesControllerTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;

    public InviteesControllerTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Fact]
    public async Task WhenGetByIdEndpointHitUsingIdOfExistingInvitee_ReturnsOkResponseContainingExpectedInvitee()
    {
        var invitees = _objectFactory.CreateMany<InviteeDataModel>().ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(invitees));
        var inviteeToGet = invitees.ElementAt(1);
        var expectedResult = _mapper.Map<InviteeDto>(inviteeToGet);

        var response = await client.GetAsync($"api/invitees/{inviteeToGet.Id}");

        using (new AssertionScope())
        {
            response.StatusCode.Should().Be(HttpStatusCode.OK);
            var content = await response.Content.ReadAsStringAsync();
            var actualResult = JsonConvert.DeserializeObject<InviteeDto>(content);
            actualResult.Should().BeEquivalentTo(expectedResult);
        }
    }

    [Fact]
    public async Task WhenGetByIdEndpointHitNotUsingIdOfExistingInvitee_ReturnsNotFoundResponse()
    {
        var invitees = _objectFactory.CreateMany<InviteeDataModel>().ToList();
        var client = TestHostFactory.CreateTestClient(UsingDbContextSeededWith(invitees));

        var response = await client.GetAsync($"api/invitees/{_objectFactory.Create<Guid>()}");

        response.StatusCode.Should().Be(HttpStatusCode.NotFound);
    }

    private TestHostFactory.TestClientCreateOptions UsingDbContextSeededWith(IEnumerable<InviteeDataModel> invitees)
    {
        var databaseName = _objectFactory.Create<string>();
        return new TestHostFactory.TestClientCreateOptions {
            DbContext = {
                Options = options => options.UseInMemoryDatabase(databaseName),
                InitializationStepsForTests = dbContext =>
                {
                    dbContext.Set<InviteeDataModel>().AddRange(invitees);
                    dbContext.SaveChanges();
                }
            }
        };
    }
}
