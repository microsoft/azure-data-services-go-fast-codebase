using AutoFixture;
using AutoMapper;
using FluentAssertions;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;
using Moq;
using NodaTime;
using NodaTime.Testing;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Common.Tests.Infrastructure;
using SecureFileUploader.Data;
using SecureFileUploader.Data.Interfaces;
using InviteeDataModel = SecureFileUploader.Data.Models.Invitee;
using InviteeDto = SecureFileUploader.Common.Dtos.Invitee;

namespace SecureFileUploader.Common.Tests.Services;

public class InviteeServiceTests : IClassFixture<MapperFixture>, IClassFixture<ObjectFactoryFixture>
{
    private readonly IMapper _mapper;
    private readonly Fixture _objectFactory;
    private readonly IClock _clock;

    public InviteeServiceTests(MapperFixture mapperFixture, ObjectFactoryFixture objectFactoryFixture)
    {
        _clock = new FakeClock(Instant.FromDateTimeOffset(DateTimeOffset.Now));
        _mapper = mapperFixture.Mapper;
        _objectFactory = objectFactoryFixture.ObjectFactory;
    }

    [Fact]
    public async Task WhenRetrievingInviteeUsingIdOfExistingInvitee_ReturnsExpectedInvitee()
    {
        var invitees = _objectFactory.CreateMany<InviteeDataModel>().ToList();
        var dbContext = CreateDbContext();
        dbContext.Invitee.AddRange(invitees);
        await dbContext.SaveChangesAsync();
        var expectedResult = _mapper.Map<InviteeDto>(invitees.ElementAt(1));

        var inviteeService = new InviteeService(_mapper, dbContext);

        var actualResult = await inviteeService.GetByIdAsync(expectedResult.Id);

        actualResult.Should().BeEquivalentTo(expectedResult);
    }

    [Fact]
    public async Task WhenRetrievingInviteeNotUsingIdOfExistingInvitee_ReturnsNull()
    {
        var invitees = _objectFactory.CreateMany<InviteeDataModel>().ToList();
        var dbContext = CreateDbContext();
        dbContext.Invitee.AddRange(invitees);
        await dbContext.SaveChangesAsync();

        var inviteeService = new InviteeService(_mapper, dbContext);

        var actualResult = await inviteeService.GetByIdAsync(_objectFactory.Create<Guid>());

        actualResult.Should().BeNull();
    }

    private SecureFileUploaderContext CreateDbContext() => new(
        new DbContextOptionsBuilder<SecureFileUploaderContext>().UseInMemoryDatabase(Guid.NewGuid().ToString()).Options,
        Mock.Of<ILogger<SecureFileUploaderContext>>(),
        _clock,
        Mock.Of<IHostEnvironment>(x => x.EnvironmentName == Environments.Development),
        Mock.Of<IRequestContext>(x => x.DisplayName == "TestName"));
}
